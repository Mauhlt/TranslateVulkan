//! Emits vk.zig from a `Registry`, plus two test files that check every
//! generated declaration against the official C headers:
//!   vk_c_test.zig   enum values, constants, scalar sizes and command
//!                   signatures, compared with `zig translate-c` output
//!   vk_layout.c     sizeof/_Alignof/offsetof of every struct, computed by a
//!                   real C compiler (covers bitfields, which translate-c skips)
const std = @import("std");
const Allocator = std.mem.Allocator;
const Writer = std.Io.Writer;
const registry = @import("registry.zig");
const Registry = registry.Registry;
const Decl = registry.Decl;
const naming = @import("naming.zig");
const fmtId = naming.fmtId;

const preamble = @embedFile("preamble.zig");

pub const Output = struct {
    vk_zig: []const u8,
    c_test_zig: []const u8,
    layout_c: []const u8,
    /// e.g. "1.4.368"
    version: []const u8,
};

/// Types from platform headers, mapped to ABI-compatible Zig types.
/// Anything not listed becomes `opaque {}` (only ever used behind a pointer).
const platform_types = std.StaticStringMap([]const u8).initComptime(.{
    .{ "HINSTANCE", "?*anyopaque" },         .{ "HWND", "?*anyopaque" },
    .{ "HMONITOR", "?*anyopaque" },          .{ "HANDLE", "?*anyopaque" },
    .{ "DWORD", "u32" },                     .{ "LPCWSTR", "?[*:0]const u16" },
    .{ "VisualID", "c_ulong" },              .{ "Window", "c_ulong" },
    .{ "RROutput", "c_ulong" },              .{ "xcb_visualid_t", "u32" },
    .{ "xcb_window_t", "u32" },              .{ "zx_handle_t", "u32" },
    .{ "GgpStreamDescriptor", "u32" },       .{ "GgpFrameToken", "u64" },
    .{ "NvSciSyncAttrList", "?*anyopaque" }, .{ "NvSciSyncObj", "?*anyopaque" },
    .{ "NvSciBufAttrList", "?*anyopaque" },  .{ "NvSciBufObj", "?*anyopaque" },
});

const c_builtin_types = std.StaticStringMap([]const u8).initComptime(.{
    .{ "void", "void" },    .{ "char", "u8" },      .{ "float", "f32" },
    .{ "double", "f64" },   .{ "int8_t", "i8" },    .{ "uint8_t", "u8" },
    .{ "int16_t", "i16" },  .{ "uint16_t", "u16" }, .{ "int32_t", "i32" },
    .{ "uint32_t", "u32" }, .{ "int64_t", "i64" },  .{ "uint64_t", "u64" },
    .{ "size_t", "usize" }, .{ "int", "c_int" },
});

/// Where a declaration appears; decides how C pointers become Zig pointers.
const Ctx = enum {
    /// Struct members and callback parameters: the outer pointer is always
    /// optional, so every struct can default-initialize to `.{}`.
    member,
    /// Command parameters: optionality follows the registry's `optional`.
    param,
    /// Return types.
    ret,
};

const Level = enum { global, instance, device };

/// Accumulates the test files while vk.zig is written: one check statement
/// per generated declaration (see src/test_preamble.zig for the helpers).
const Tests = struct {
    constants: Writer.Allocating,
    sizes: Writer.Allocating,
    enums: Writer.Allocating,
    commands: Writer.Allocating,
    layouts: Writer.Allocating,
    /// Entries of `vkzig_layout[]` in vk_layout.c, in the order `layouts` reads them.
    layout_c: Writer.Allocating,
    layout_count: usize = 0,

    fn init(a: Allocator) Tests {
        return .{
            .constants = .init(a),
            .sizes = .init(a),
            .enums = .init(a),
            .commands = .init(a),
            .layouts = .init(a),
            .layout_c = .init(a),
        };
    }

    /// `if (@hasDecl(c, "C")) expectEq("what", zig_expr, c.C);`
    fn check(w: *Writer.Allocating, what: []const u8, zig_expr: []const u8, c_name: []const u8, comptime c_wrap: []const u8) !void {
        try w.writer.print("    if (@hasDecl(c, \"{s}\")) expectEq(\"{s}\", {s}, " ++ c_wrap ++ ");\n", .{ c_name, what, zig_expr, c_name });
    }
};

const Renderer = struct {
    a: Allocator,
    reg: *Registry,
    w: *Writer,
    tests: *Tests,
    /// Every top-level name in vk.zig, to catch collisions.
    top_names: std.StringHashMapUnmanaged(void) = .empty,
    /// C enum value name -> Zig field name (used for `sType` defaults).
    enum_fields: std.StringHashMapUnmanaged([]const u8) = .empty,
    /// { Zig error name, Result field name } for every negative VkResult.
    errors: std.ArrayList([2][]const u8) = .empty,
    warnings: usize = 0,

    fn print(r: *Renderer, comptime format: []const u8, args: anytype) !void {
        try r.w.print(format, args);
    }

    fn fmt(r: *Renderer, comptime format: []const u8, args: anytype) ![]const u8 {
        return std.fmt.allocPrint(r.a, format, args);
    }

    /// Reserves a top-level name; returns false (and warns) on a collision.
    fn claim(r: *Renderer, name: []const u8) !bool {
        const gop = try r.top_names.getOrPut(r.a, name);
        if (gop.found_existing) {
            std.log.warn("duplicate top-level name `{s}`, skipping", .{name});
            r.warnings += 1;
        }
        return !gop.found_existing;
    }

    fn zigTypeName(r: *Renderer, c_name: []const u8) ![]const u8 {
        return c_builtin_types.get(c_name) orelse naming.typeName(r.a, c_name);
    }

    fn isFuncPointer(r: *Renderer, c_name: []const u8) bool {
        const t = r.reg.resolve(c_name) orelse return false;
        return t.kind == .funcpointer;
    }

    /// The Zig type for a C declaration, e.g.
    ///   const char* const* ppEnabledLayerNames (len="enabledLayerCount,null-terminated")
    ///   -> ?[*]const [*:0]const u8
    fn declType(r: *Renderer, d: Decl, ctx: Ctx) ![]const u8 {
        const is_void = std.mem.eql(u8, d.type_name, "void");
        var t = try r.zigTypeName(d.type_name);
        if (r.isFuncPointer(d.type_name)) t = try r.fmt("?{s}", .{t});
        if (is_void and d.pointers.len > 0) t = "anyopaque";

        const lens = try splitComma(r.a, d.len);
        const optionals = try splitComma(r.a, d.optional);
        // `pointers` is innermost-first; `len`/`optional` lists are outermost-first.
        for (d.pointers, 0..) |level, k| {
            const outer = d.pointers.len - 1 - k;
            const innermost = k == 0;
            const len: []const u8 = if (outer < lens.len) lens[outer] else "1";
            const ptr = if (innermost and is_void)
                "*"
            else if (std.mem.eql(u8, len, "null-terminated"))
                "[*:0]"
            else if (std.mem.eql(u8, len, "1"))
                "*"
            else
                "[*]";
            // Count-sized arrays (`[*]`) may be null when their count is 0, which
            // vk.xml marks on the count rather than on the pointer.
            const optional = (innermost and is_void) or
                (outer == 0 and ctx != .param) or
                (outer == 0 and std.mem.eql(u8, ptr, "[*]")) or
                (outer < optionals.len and std.mem.eql(u8, optionals[outer], "true"));
            t = try r.fmt("{s}{s}{s}{s}", .{ if (optional) "?" else "", ptr, if (level.pointee_const) "const " else "", t });
        }
        var i = d.dims.len;
        while (i > 0) {
            i -= 1;
            t = try r.fmt("[{s}]{s}", .{ try r.dimText(d.dims[i]), t });
        }
        // C array parameters decay to pointers: `const float x[4]` is `*const [4]f32`.
        if (ctx == .param and d.dims.len > 0) t = try r.fmt("*{s}{s}", .{ if (d.is_const) "const " else "", t });
        return t;
    }

    fn dimText(r: *Renderer, dim: []const u8) ![]const u8 {
        _ = std.fmt.parseInt(u32, dim, 10) catch return naming.constantName(r.a, dim);
        return dim;
    }

    /// Default value for a struct field so that `.{}` is always a valid,
    /// zeroed struct (with `sType` already set).
    fn defaultValue(r: *Renderer, d: Decl, zig_type: []const u8) ![]const u8 {
        if (d.values) |v| {
            if (r.enum_fields.get(std.mem.sliceTo(v, ','))) |field| return r.fmt(".{f}", .{fmtId(field)});
        }
        if (zig_type[0] == '?') return "null";
        const zeroes = try r.fmt("std.mem.zeroes({s})", .{zig_type});
        if (d.dims.len > 0) return zeroes;
        if (c_builtin_types.has(d.type_name)) return "0";
        if (platform_types.get(d.type_name)) |p| return if (p[0] == '?') "null" else "0";
        const t = r.reg.resolve(d.type_name) orelse return zeroes;
        return switch (t.kind) {
            .basetype => |b| switch (b) {
                .bool32 => ".false",
                .typedef => "0",
                else => zeroes,
            },
            .handle => ".null",
            .bitmask => ".empty",
            .@"enum" => "@enumFromInt(0)",
            .@"struct" => |s| if (s.is_union) zeroes else ".{}",
            else => zeroes,
        };
    }

    // -- vk.zig sections ----------------------------------------------------

    fn header(r: *Renderer, version: []const u8) !void {
        try r.print(
            \\//! Vulkan {s} bindings for Zig.
            \\//!
            \\//! GENERATED by TranslateVulkan from vk.xml + video.xml. Do not edit by hand;
            \\//! change the generator (or src/preamble.zig) and regenerate instead.
            \\//!
            \\//! Quick start:
            \\//!     try vk.loadLibrary();                 // opens vulkan-1.dll / libvulkan.so.1
            \\//!     try vk.createInstance(&info, null, &instance);
            \\//!     vk.loadInstance(instance);            // instance + device commands
            \\//!     ...
            \\//!     vk.loadDevice(device);                // optional: direct device dispatch
            \\const std = @import("std");
            \\const builtin = @import("builtin");
            \\
            \\
        , .{version});
        try r.w.writeAll(preamble);
        _ = try r.claim("std");
        _ = try r.claim("builtin");
        var lines = std.mem.splitScalar(u8, preamble, '\n');
        while (lines.next()) |line| {
            if (declName(line)) |name| _ = try r.claim(name);
        }
    }

    fn versions(r: *Renderer, major_minor: []const u8) !void {
        try r.w.writeAll("\n// Versions\n");
        for (r.reg.features.items) |f| {
            const dot = std.mem.indexOfScalar(u8, f.number, '.') orelse continue;
            const major, const minor = .{ f.number[0..dot], f.number[dot + 1 ..] };
            const name = try r.fmt("api_version_{s}_{s}", .{ major, minor });
            if (try r.claim(name)) try r.print("pub const {s} = makeApiVersion(0, {s}, {s}, 0);\n", .{ name, major, minor });
        }
        const dot = std.mem.indexOfScalar(u8, major_minor, '.').?;
        for ([_][]const u8{ "header_version", "header_version_complete", "version_string" }) |n| _ = try r.claim(n);
        try r.print(
            \\pub const header_version = {d};
            \\pub const header_version_complete = makeApiVersion(0, {s}, {s}, header_version);
            \\pub const version_string = "{s}.{d}";
            \\
        , .{ r.reg.header_version, major_minor[0..dot], major_minor[dot + 1 ..], major_minor, r.reg.header_version });
    }

    fn constants(r: *Renderer) !void {
        try r.w.writeAll("\n// Constants\n");
        for (r.reg.constants.values()) |c| {
            if (std.mem.eql(u8, c.name, "VK_TRUE") or std.mem.eql(u8, c.name, "VK_FALSE")) continue; // see Bool32
            const name = try naming.constantName(r.a, c.name);
            const value = try r.constantValue(c) orelse continue;
            if (!try r.claim(name)) continue;
            try r.print("pub const {f}{s} = {s};\n", .{ fmtId(name), value.type_annotation, value.text });
            if (value.is_integer) try Tests.check(&r.tests.constants, name, try r.fmt("vk.{f}", .{fmtId(name)}), c.name, "c.{s}");
        }
    }

    const ConstantValue = struct { text: []const u8, type_annotation: []const u8 = "", is_integer: bool = false };

    /// `256` / `(~0U)` / `1000.0F` / `"VK_KHR_surface"` / another constant's name.
    fn constantValue(r: *Renderer, c: registry.Constant) !?ConstantValue {
        const reference = c.alias orelse if (r.reg.constants.contains(c.value)) c.value else null;
        if (reference) |target| {
            if (!r.reg.constants.contains(target)) return null;
            return .{ .text = try r.fmt("{f}", .{fmtId(try naming.constantName(r.a, target))}) };
        }
        const v = c.value;
        if (v.len >= 2 and v[0] == '"') return .{ .text = v };
        const zig_type: ?[]const u8 = if (c.c_type) |ct| c_builtin_types.get(ct) else null;
        if (zig_type != null and std.mem.eql(u8, zig_type.?, "f32")) {
            return .{ .text = std.mem.trimEnd(u8, v, "fF"), .type_annotation = ": f32" };
        }
        const inner = std.mem.trim(u8, v, " ()");
        if (inner.len > 0 and inner[0] == '~') {
            const n = registry.parseCInt(inner[1..]) orelse return null;
            return .{ .text = try r.fmt("~@as({s}, {d})", .{ zig_type orelse "u32", n }), .is_integer = true };
        }
        const n = registry.parseCInt(v) orelse return null;
        const annotation = if (zig_type) |zt| try r.fmt(": {s}", .{zt}) else "";
        return .{ .text = try r.fmt("{d}", .{n}), .type_annotation = annotation, .is_integer = true };
    }

    fn types(r: *Renderer) !void {
        try r.w.writeAll("\n// Types\n");
        var structs: std.ArrayList(registry.TypeDef) = .empty;
        for (r.reg.types.values()) |t| {
            if (!r.reg.isRequiredType(t.name) or c_builtin_types.has(t.name)) continue;
            switch (t.kind) {
                .@"struct" => try structs.append(r.a, t),
                .@"enum" => try r.enumType(t.name),
                else => try r.simpleType(t),
            }
        }
        // Structs last: their sType defaults need every enum field name.
        for (structs.items) |t| try r.structType(t);
    }

    fn simpleType(r: *Renderer, t: registry.TypeDef) !void {
        if (t.kind == .basetype and t.kind.basetype == .bool32) return; // in the preamble
        if (t.kind == .alias and r.reg.resolve(t.kind.alias) == null) return;
        const name = try naming.typeName(r.a, t.name);
        if (!try r.claim(name)) return;
        const id = fmtId(name);
        switch (t.kind) {
            .alias => |target| try r.print("pub const {f} = {f};\n", .{ id, fmtId(try r.zigTypeName(target)) }),
            .basetype => |b| switch (b) {
                .typedef => |d| try r.print("pub const {f} = {s};\n", .{ id, try r.declType(d, .ret) }),
                .opaque_type => try r.print("pub const {f} = opaque {{}};\n", .{id}),
                .opaque_pointer => try r.print("pub const {f} = ?*anyopaque;\n", .{id}),
                .bool32 => unreachable,
            },
            .external => try r.print("pub const {f} = {s};\n", .{ id, platform_types.get(t.name) orelse "opaque {}" }),
            // Dispatchable handles are pointers; non-dispatchable ones are
            // 64-bit integers even on 32-bit targets.
            .handle => |h| try r.print("pub const {f} = enum({s}) {{ null = 0, _ }};\n", .{ id, if (h.dispatchable) "usize" else "u64" }),
            .bitmask => |bm| {
                const bits = bm.bits orelse "";
                if (r.reg.enums.contains(bits)) {
                    try r.print("pub const {f} = FlagSet({f});\n", .{ id, fmtId(try naming.typeName(r.a, bits)) });
                } else {
                    try r.print("pub const {f} = FlagSet(enum({s}) {{ _ }});\n", .{ id, if (bm.is_64) "u64" else "u32" });
                }
            },
            .funcpointer => |f| {
                try r.print("pub const {f} = *const fn (", .{id});
                for (f.params, 0..) |p, i| try r.print("{s}{s}", .{ if (i > 0) ", " else "", try r.declType(p, .member) });
                try r.print(") callconv(.c) {s};\n", .{try r.declType(f.ret, .ret)});
            },
            .@"struct", .@"enum" => unreachable,
        }
        switch (t.kind) {
            .handle, .bitmask, .basetype => try r.sizeCheck(name, t.name),
            else => {},
        }
    }

    fn enumType(r: *Renderer, c_name: []const u8) !void {
        const name = try naming.typeName(r.a, c_name);
        if (!try r.claim(name)) return;
        const block = r.reg.enums.getPtr(c_name);
        const is_result = std.mem.eql(u8, c_name, "VkResult");
        const is_bits = if (block) |b| b.is_bitmask else false;
        // Unsigned like the C values in practice; only enums with negative
        // values (VkResult) are signed. Same size as C's `int` either way.
        const has_negative = if (block) |b| for (b.values.items) |v| {
            if (v.value == .int and v.value.int < 0) break true;
        } else false else false;
        const tag = if (has_negative) "i32" else if (is_bits and block.?.is_64) "u64" else "u32";
        try r.print("pub const {f} = enum({s}) {{\n", .{ fmtId(name), tag });
        if (!is_result) try r.sizeCheck(name, c_name);

        // Zig enums cannot repeat a value or a name: the first name for each
        // value becomes a field, the rest (and registry aliases) become decls.
        var names: std.StringHashMapUnmanaged(void) = .empty;
        var by_value: std.AutoHashMapUnmanaged(i128, []const u8) = .empty;
        var decls: Writer.Allocating = .init(r.a);
        if (block) |b| {
            const value_naming = try naming.enumNaming(r.a, c_name, r.reg.tagList());
            for ([_]bool{ false, true }) |aliases_pass| {
                for (b.values.items) |v| {
                    const is_alias = v.value == .alias;
                    if (is_alias != aliases_pass) continue;
                    const field = try naming.enumFieldName(r.a, value_naming, v.name);
                    if ((try names.getOrPut(r.a, field)).found_existing) continue;
                    const same_as: ?[]const u8 = switch (v.value) {
                        .alias => |target| r.enum_fields.get(target) orelse continue,
                        .int => |n| by_value.get(n),
                    };
                    try r.enum_fields.put(r.a, v.name, field);
                    try Tests.check(
                        &r.tests.enums,
                        try r.fmt("{s}.{s}", .{ name, field }),
                        try r.fmt("@intFromEnum(vk.{f}.{f})", .{ fmtId(name), fmtId(field) }),
                        v.name,
                        "c.{s}",
                    );
                    if (same_as) |first| {
                        try decls.writer.print("    pub const {f}: {f} = .{f};\n", .{ fmtId(field), fmtId(name), fmtId(first) });
                        continue;
                    }
                    const n = v.value.int;
                    try by_value.put(r.a, n, field);
                    if (is_bits) {
                        try r.print("    {f} = 0x{x},\n", .{ fmtId(field), n });
                    } else {
                        try r.print("    {f} = {d},\n", .{ fmtId(field), n });
                    }
                    if (is_result and n < 0) {
                        try r.errors.append(r.a, .{ try naming.errorName(r.a, v.name, r.reg.tagList()), field });
                    }
                }
            }
        }
        try r.w.writeAll("    _,\n");
        try r.w.writeAll(decls.written());
        if (is_result) try r.w.writeAll(
            \\
            \\    /// Negative codes become `Error`s; success and status codes are returned.
            \\    pub fn check(self: Result) Error!Result {
            \\        if (@intFromEnum(self) >= 0) return self;
            \\        return resultToError(self);
            \\    }
            \\
        );
        try r.w.writeAll("};\n");
    }

    fn errorSet(r: *Renderer) !void {
        for ([_][]const u8{ "Error", "resultToError", "errorToResult" }) |n| _ = try r.claim(n);
        const has_unknown = for (r.errors.items) |e| {
            if (std.mem.eql(u8, e[0], "Unknown")) break true;
        } else false;

        try r.w.writeAll(
            \\
            \\/// Every negative `VkResult` as a Zig error. Commands return these instead
            \\/// of a raw `Result`; commands that can also return status codes
            \\/// (e.g. `.suboptimal_khr`) return `Error!Result`.
            \\pub const Error = error{
            \\
        );
        for (r.errors.items) |e| try r.print("    {s},\n", .{e[0]});
        if (!has_unknown) try r.w.writeAll("    Unknown,\n");

        try r.w.writeAll("};\n\nfn resultToError(result: Result) Error {\n    return switch (result) {\n");
        for (r.errors.items) |e| try r.print("        .{f} => error.{s},\n", .{ fmtId(e[1]), e[0] });
        try r.w.writeAll("        else => error.Unknown,\n    };\n}\n");

        try r.w.writeAll("\n/// The `Result` for an `Error`, e.g. when returning from a layer or callback.\n");
        try r.w.writeAll("pub fn errorToResult(err: Error) Result {\n    return switch (err) {\n");
        for (r.errors.items) |e| try r.print("        error.{s} => .{f},\n", .{ e[0], fmtId(e[1]) });
        if (!has_unknown) try r.w.writeAll("        error.Unknown => .error_unknown,\n");
        try r.w.writeAll("    };\n}\n");
    }

    const Field = struct { name: []const u8, ty: []const u8, default: []const u8, c_name: ?[]const u8 };

    fn structType(r: *Renderer, t: registry.TypeDef) !void {
        const s = t.kind.@"struct";
        const name = try naming.typeName(r.a, t.name);
        if (!try r.claim(name)) return;

        var fields: std.ArrayList(Field) = .empty;
        var bitfield_groups: usize = 0;
        var i: usize = 0;
        while (i < s.members.len) {
            const m = s.members[i];
            if (m.bitfield == null) {
                const ty = try r.declType(m, .member);
                try fields.append(r.a, .{ .name = try naming.snakeCase(r.a, m.name), .ty = ty, .default = try r.defaultValue(m, ty), .c_name = m.name });
                i += 1;
                continue;
            }
            // Consecutive C bitfields share one storage unit: `packed struct(uN)`.
            const unit = bitWidthOf(m.type_name);
            var used: u16 = 0;
            var body: Writer.Allocating = .init(r.a);
            var names: std.ArrayList([]const u8) = .empty;
            while (i < s.members.len) : (i += 1) {
                const width = s.members[i].bitfield orelse break;
                if (used + width > unit) break;
                const field = try naming.snakeCase(r.a, s.members[i].name);
                try names.append(r.a, field);
                try body.writer.print("    {f}: u{d} = 0,\n", .{ fmtId(field), width });
                used += width;
            }
            if (used < unit) try body.writer.print("    _reserved_bits: u{d} = 0,\n", .{unit - used});
            if (bitfield_groups == 0 and fields.items.len == 0 and i == s.members.len) {
                // The whole struct is a single unit (most video `*Flags` structs).
                try r.print("pub const {f} = packed struct(u{d}) {{\n{s}}};\n", .{ fmtId(name), unit, body.written() });
                try r.layoutCheck(t, name, &.{});
                return;
            }
            const group_name = if (names.items.len <= 3)
                try std.mem.join(r.a, "_and_", names.items)
            else
                try r.fmt("bitfields{d}", .{bitfield_groups});
            bitfield_groups += 1;
            try fields.append(r.a, .{
                .name = group_name,
                .ty = try r.fmt("packed struct(u{d}) {{\n{s}    }}", .{ unit, try indent(r.a, body.written()) }),
                .default = ".{}",
                .c_name = null,
            });
        }

        try r.print("pub const {f} = extern {s} {{\n", .{ fmtId(name), if (s.is_union) "union" else "struct" });
        for (fields.items) |f| {
            if (s.is_union) {
                try r.print("    {f}: {s},\n", .{ fmtId(f.name), f.ty });
            } else {
                try r.print("    {f}: {s} = {s},\n", .{ fmtId(f.name), f.ty, f.default });
            }
        }
        try r.w.writeAll("};\n");
        try r.layoutCheck(t, name, if (s.is_union) &.{} else fields.items);
    }

    /// Adds `sizeof`, `_Alignof` and one `offsetof` per plain field to vk_layout.c,
    /// and the matching Zig names to vk_c_test.zig (same order).
    fn layoutCheck(r: *Renderer, t: registry.TypeDef, name: []const u8, fields: []const Field) !void {
        if (r.reg.platform_types.contains(t.name)) return; // needs windows.h etc.
        const c = &r.tests.layout_c.writer;
        const id = fmtId(name);
        try c.print("    sizeof({0s}), _Alignof({0s}),", .{t.name});
        try r.layoutEntry(try r.fmt("@sizeOf({s})", .{name}), try r.fmt("@sizeOf(vk.{f})", .{id}));
        try r.layoutEntry(try r.fmt("@alignOf({s})", .{name}), try r.fmt("@alignOf(vk.{f})", .{id}));
        for (fields) |f| {
            const c_name = f.c_name orelse continue; // bitfield groups have no C name
            try c.print(" offsetof({s}, {s}),", .{ t.name, c_name });
            try r.layoutEntry(try r.fmt("@offsetOf({s}, {s})", .{ name, f.name }), try r.fmt("@offsetOf(vk.{f}, \"{s}\")", .{ id, f.name }));
        }
        try c.writeAll("\n");
    }

    fn layoutEntry(r: *Renderer, what: []const u8, zig_expr: []const u8) !void {
        try r.tests.layouts.writer.print("    expectEq(\"{s}\", {s}, vkzig_layout[{d}]);\n", .{ what, zig_expr, r.tests.layout_count });
        r.tests.layout_count += 1;
    }

    fn sizeCheck(r: *Renderer, name: []const u8, c_name: []const u8) !void {
        try Tests.check(&r.tests.sizes, try r.fmt("@sizeOf({s})", .{name}), try r.fmt("@sizeOf(vk.{f})", .{fmtId(name)}), c_name, "@sizeOf(c.{s})");
    }

    fn commands(r: *Renderer) !void {
        // target command -> its required alias names (vkFooKHR for vkFoo).
        var aliases_of: std.StringHashMapUnmanaged(std.ArrayList([]const u8)) = .empty;
        for (r.reg.command_aliases.keys(), r.reg.command_aliases.values()) |alias, target| {
            if (!r.reg.required_commands.contains(alias)) continue;
            const gop = try aliases_of.getOrPut(r.a, target);
            if (!gop.found_existing) gop.value_ptr.* = .empty;
            try gop.value_ptr.append(r.a, alias);
        }
        var cmds: std.ArrayList(registry.Command) = .empty;
        for (r.reg.commands.values()) |cmd| {
            if (r.reg.required_commands.contains(cmd.name) or aliases_of.contains(cmd.name)) try cmds.append(r.a, cmd);
        }
        const aliasesOf = struct {
            fn get(map: anytype, n: []const u8) []const []const u8 {
                return if (map.get(n)) |list| list.items else &.{};
            }
        }.get;

        try r.w.writeAll("\n// Command function pointer types\n");
        for (cmds.items) |cmd| {
            const pfn = try r.fmt("Pfn{s}", .{cmd.name[2..]});
            if (!try r.claim(pfn)) continue;
            try r.print("pub const {s} = *const fn (", .{pfn});
            for (cmd.params, 0..) |p, i| try r.print("{s}{s}", .{ if (i > 0) ", " else "", try r.declType(p, .param) });
            try r.print(") callconv(.c) {s};\n", .{try r.declType(cmd.ret, .ret)});
            try r.tests.commands.writer.print("    if (@hasDecl(c, \"PFN_{0s}\")) expectSignature(vk.{1s}, c.PFN_{0s}, \"{0s}\");\n", .{ cmd.name, pfn });
            for (aliasesOf(aliases_of, cmd.name)) |alias| {
                const alias_pfn = try r.fmt("Pfn{s}", .{alias[2..]});
                if (try r.claim(alias_pfn)) try r.print("pub const {s} = {s};\n", .{ alias_pfn, pfn });
            }
        }

        _ = try r.claim("Dispatch");
        try r.w.writeAll("\n/// One optional function pointer per command, filled by the load* functions.\npub const Dispatch = struct {\n");
        for (cmds.items) |cmd| try r.print("    {s}: ?Pfn{s} = null,\n", .{ cmd.name, cmd.name[2..] });
        try r.w.writeAll("};\n");

        for ([_]Level{ .global, .instance, .device }) |level| {
            const list_name = try r.fmt("{t}_commands", .{level});
            _ = try r.claim(list_name);
            try r.print("\nconst {s} = [_]CommandEntry{{\n", .{list_name});
            for (cmds.items) |cmd| {
                if (commandLevel(cmd) != level or std.mem.eql(u8, cmd.name, "vkGetInstanceProcAddr")) continue;
                try r.print("    .{{ .name = \"{s}\"", .{cmd.name});
                const aliases = aliasesOf(aliases_of, cmd.name);
                if (aliases.len > 0) {
                    try r.w.writeAll(", .aliases = &.{");
                    for (aliases, 0..) |alias, i| try r.print("{s}\"{s}\"", .{ if (i > 0) ", " else " ", alias });
                    try r.w.writeAll(" }");
                }
                try r.w.writeAll(" },\n");
            }
            try r.w.writeAll("};\n");
        }

        // Wrappers: vkCreateInstance -> vk.createInstance, returning Error!...
        try r.w.writeAll("\n// Commands\n");
        for (cmds.items) |cmd| _ = try r.claim(try naming.commandName(r.a, cmd.name));
        for (cmds.items) |cmd| {
            const fn_name = try naming.commandName(r.a, cmd.name);
            try r.wrapper(cmd, fn_name);
            for (aliasesOf(aliases_of, cmd.name)) |alias| {
                const alias_name = try naming.commandName(r.a, alias);
                if (try r.claim(alias_name)) try r.print("pub const {f} = {f};\n", .{ fmtId(alias_name), fmtId(fn_name) });
            }
        }
    }

    /// pub fn createInstance(...) Error!void {
    ///     return checkSuccess((dispatch.vkCreateInstance orelse unloaded("vkCreateInstance"))(...));
    /// }
    fn wrapper(r: *Renderer, cmd: registry.Command, fn_name: []const u8) !void {
        var params: std.ArrayList([]const u8) = .empty;
        try r.print("pub fn {f}(", .{fmtId(fn_name)});
        for (cmd.params, 0..) |p, i| {
            var param = try naming.snakeCase(r.a, p.name);
            if (r.top_names.contains(param)) param = try r.fmt("{s}_", .{param}); // no shadowing
            try params.append(r.a, param);
            try r.print("{s}{f}: {s}", .{ if (i > 0) ", " else "", fmtId(param), try r.declType(p, .param) });
        }

        const Kind = enum { plain, check_success, check_status };
        const kind: Kind = if (!std.mem.eql(u8, cmd.ret.type_name, "VkResult"))
            .plain
        else if (cmd.success_codes.len <= 1)
            .check_success
        else
            .check_status;
        switch (kind) {
            .plain => try r.print(") {s} {{\n    return ", .{try r.declType(cmd.ret, .ret)}),
            .check_success => try r.w.writeAll(") Error!void {\n    return checkSuccess("),
            .check_status => try r.w.writeAll(") Error!Result {\n    return "),
        }
        try r.print("(dispatch.{s} orelse unloaded(\"{s}\"))(", .{ cmd.name, cmd.name });
        for (params.items, 0..) |p, i| try r.print("{s}{f}", .{ if (i > 0) ", " else "", fmtId(p) });
        try r.w.writeAll(switch (kind) {
            .plain => ");\n}\n",
            .check_success => "));\n}\n",
            .check_status => ").check();\n}\n",
        });
    }
};

/// Instance-level commands take an instance or physical device first;
/// device-level ones a device, queue or command buffer.
fn commandLevel(cmd: registry.Command) Level {
    if (std.mem.eql(u8, cmd.name, "vkGetDeviceProcAddr")) return .instance;
    if (cmd.params.len == 0) return .global;
    const first = cmd.params[0].type_name;
    for ([_][]const u8{ "VkInstance", "VkPhysicalDevice" }) |h| if (std.mem.eql(u8, first, h)) return .instance;
    for ([_][]const u8{ "VkDevice", "VkQueue", "VkCommandBuffer" }) |h| if (std.mem.eql(u8, first, h)) return .device;
    return .global;
}

fn bitWidthOf(c_type: []const u8) u16 {
    if (std.mem.endsWith(u8, c_type, "8_t")) return 8;
    if (std.mem.endsWith(u8, c_type, "16_t")) return 16;
    if (std.mem.endsWith(u8, c_type, "64_t")) return 64;
    return 32;
}

/// Name of a top-level `[pub] const|var|fn` declaration on this line, if any.
fn declName(line: []const u8) ?[]const u8 {
    var rest = line;
    if (std.mem.startsWith(u8, rest, "pub ")) rest = rest[4..];
    inline for (.{ "const ", "var ", "fn " }) |kw| {
        if (std.mem.startsWith(u8, rest, kw)) {
            const s = rest[kw.len..];
            var end: usize = 0;
            while (end < s.len and (std.ascii.isAlphanumeric(s[end]) or s[end] == '_')) end += 1;
            return if (end > 0) s[0..end] else null;
        }
    }
    return null;
}

fn indent(a: Allocator, text: []const u8) ![]const u8 {
    var out: std.ArrayList(u8) = .empty;
    var it = std.mem.splitScalar(u8, text, '\n');
    var first = true;
    while (it.next()) |line| : (first = false) {
        if (!first) try out.append(a, '\n');
        if (line.len > 0) try out.appendSlice(a, "    ");
        try out.appendSlice(a, line);
    }
    return out.items;
}

fn splitComma(a: Allocator, raw: ?[]const u8) ![]const []const u8 {
    const s = raw orelse return &.{};
    var out: std.ArrayList([]const u8) = .empty;
    var it = std.mem.splitScalar(u8, s, ',');
    while (it.next()) |x| try out.append(a, std.mem.trim(u8, x, " "));
    return out.items;
}

pub fn render(arena: Allocator, reg: *Registry) !Output {
    var out: Writer.Allocating = .init(arena);
    var tests: Tests = .init(arena);
    var r: Renderer = .{ .a = arena, .reg = reg, .w = &out.writer, .tests = &tests };

    var major_minor: []const u8 = "1.0"; // highest core version, e.g. "1.4"
    for (reg.features.items) |f| {
        if (std.mem.order(u8, f.number, major_minor) == .gt) major_minor = f.number;
    }
    const version = try std.fmt.allocPrint(arena, "{s}.{d}", .{ major_minor, reg.header_version });

    try r.header(version);
    try r.versions(major_minor);
    try r.constants();
    try r.types();
    try r.errorSet();
    try r.commands();
    if (r.warnings > 0) std.log.warn("{d} generator warnings", .{r.warnings});

    var c_test: Writer.Allocating = .init(arena);
    try c_test.writer.writeAll(@embedFile("test_preamble.zig"));
    try c_test.writer.print(
        \\
        \\// ---------------------------------------------------------------------------
        \\// Generated checks
        \\// ---------------------------------------------------------------------------
        \\
        \\/// sizeof, _Alignof and offsetof values from vk_layout.c, compiled by a C compiler.
        \\extern const vkzig_layout: [{d}]usize;
        \\
        \\test "enum values match the C headers (naming schema)" {{
        \\{s}    try finish("enum value");
        \\}}
        \\
        \\test "constants match the C headers" {{
        \\{s}    try finish("constant");
        \\}}
        \\
        \\test "handle, flag and enum sizes match the C headers" {{
        \\{s}    try finish("size");
        \\}}
        \\
        \\test "command signatures match the C headers" {{
        \\{s}    try finish("command signature");
        \\}}
        \\
        \\test "struct layouts match a C compiler" {{
        \\{s}    try finish("struct layout");
        \\}}
        \\
    , .{
        tests.layout_count,    tests.enums.written(),    tests.constants.written(),
        tests.sizes.written(), tests.commands.written(), tests.layouts.written(),
    });
    var layout_c: Writer.Allocating = .init(arena);
    try layout_c.writer.print(
        \\// GENERATED alongside vk.zig: struct layouts as computed by a C compiler.
        \\// The order matches `layouts` in vk_c_test.zig.
        \\#include <stddef.h>
        \\#define VK_ENABLE_BETA_EXTENSIONS
        \\#include <vulkan/vulkan_core.h>
        \\#include <vulkan/vulkan_beta.h>
        \\
        \\const size_t vkzig_layout[] = {{
        \\{s}    0
        \\}};
        \\
    , .{tests.layout_c.written()});

    return .{ .vk_zig = out.written(), .c_test_zig = c_test.written(), .layout_c = layout_c.written(), .version = version };
}

test declName {
    try std.testing.expectEqualStrings("FlagSet", declName("pub fn FlagSet(comptime Bits: type) type {").?);
    try std.testing.expectEqualStrings("library", declName("var library: ?Library = null;").?);
    try std.testing.expect(declName("    const x = 1;") == null);
}
