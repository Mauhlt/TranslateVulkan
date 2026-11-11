//! Turns the XML DOM of vk.xml (+ video.xml) into a typed model and computes
//! exactly which types / commands / enum values belong to the `vulkan` API
//! (as opposed to `vulkansc`, or `disabled` extensions).
const std = @import("std");
const Allocator = std.mem.Allocator;
const xml = @import("xml.zig");
const naming = @import("naming.zig");

pub const api_name = "vulkan";

/// One `*` in a C declaration. Stored innermost-first: for
/// `const char* const* p`, level 0 is `const char*` and level 1 is the outer pointer.
pub const PtrLevel = struct {
    pointee_const: bool,
};

/// A C declaration as it appears in `<member>`, `<param>` and `<proto>`.
pub const Decl = struct {
    name: []const u8,
    type_name: []const u8,
    /// `const` before the base type (`const float x[4]`).
    is_const: bool = false,
    pointers: []const PtrLevel = &.{},
    /// Array dimensions, outermost first. Either a literal ("4") or a constant name.
    dims: []const []const u8 = &.{},
    bitfield: ?u16 = null,
    /// `len` attribute: comma separated, outermost pointer first.
    len: ?[]const u8 = null,
    /// `optional` attribute: comma separated, outermost pointer first.
    optional: ?[]const u8 = null,
    /// `values` attribute on sType members.
    values: ?[]const u8 = null,
};

pub const Basetype = union(enum) {
    /// `typedef uint32_t VkSampleMask;` / `typedef void* VkRemoteAddressNV;`
    typedef: Decl,
    /// `struct ANativeWindow;` / `typedef void CAMetalLayer;`
    opaque_type,
    /// `typedef void* MTLDevice_id;` / `typedef struct __IOSurface* IOSurfaceRef;`
    opaque_pointer,
    bool32,
};

pub const TypeKind = union(enum) {
    alias: []const u8,
    basetype: Basetype,
    bitmask: struct { bits: ?[]const u8, is_64: bool },
    handle: struct { dispatchable: bool },
    @"enum",
    funcpointer: struct { ret: Decl, params: []const Decl },
    @"struct": struct { members: []const Decl, is_union: bool },
    /// Provided by an external header (windows.h, X11, ...).
    external,
};

pub const TypeDef = struct {
    name: []const u8,
    kind: TypeKind,
};

pub const EnumValue = struct {
    name: []const u8,
    value: union(enum) { int: i128, alias: []const u8 },
};

pub const EnumBlock = struct {
    name: []const u8,
    is_bitmask: bool,
    is_64: bool,
    values: std.ArrayList(EnumValue) = .empty,

    fn has(self: *const EnumBlock, name: []const u8) bool {
        for (self.values.items) |v| if (std.mem.eql(u8, v.name, name)) return true;
        return false;
    }
};

pub const Constant = struct {
    name: []const u8,
    /// Raw C value: `256`, `(~0U)`, `1000.0F`, `"VK_KHR_surface"` ...
    value: []const u8,
    c_type: ?[]const u8 = null,
    alias: ?[]const u8 = null,
};

pub const Command = struct {
    name: []const u8,
    ret: Decl,
    params: []const Decl,
    success_codes: []const []const u8 = &.{},
    error_codes: []const []const u8 = &.{},
};

pub const Feature = struct {
    name: []const u8,
    number: []const u8,
};

pub const Registry = struct {
    arena: Allocator,
    tags: std.ArrayList([]const u8) = .empty,
    types: std.StringArrayHashMapUnmanaged(TypeDef) = .empty,
    enums: std.StringArrayHashMapUnmanaged(EnumBlock) = .empty,
    constants: std.StringArrayHashMapUnmanaged(Constant) = .empty,
    commands: std.StringArrayHashMapUnmanaged(Command) = .empty,
    /// alias name -> target name
    command_aliases: std.StringArrayHashMapUnmanaged([]const u8) = .empty,
    features: std.ArrayList(Feature) = .empty,
    header_version: u32 = 0,

    required_types: std.StringArrayHashMapUnmanaged(void) = .empty,
    required_commands: std.StringArrayHashMapUnmanaged(void) = .empty,
    /// Types declared in a platform header (vulkan_win32.h, vulkan_xlib.h, ...).
    platform_types: std.StringArrayHashMapUnmanaged(void) = .empty,

    pub fn init(arena: Allocator) Registry {
        return .{ .arena = arena };
    }

    pub fn tagList(self: *const Registry) []const []const u8 {
        return if (self.tags.items.len > 0) self.tags.items else &naming.default_tags;
    }

    /// Follows `alias` chains to the defining type.
    pub fn resolve(self: *const Registry, name: []const u8) ?TypeDef {
        var current = name;
        var depth: usize = 0;
        while (depth < 16) : (depth += 1) {
            const t = self.types.get(current) orelse return null;
            switch (t.kind) {
                .alias => |target| current = target,
                else => return t,
            }
        }
        return null;
    }

    /// Loads one registry file. Load video.xml before vk.xml so its real type
    /// definitions win over vk.xml's `requires="vk_video/..."` stubs.
    pub fn load(self: *Registry, root: *const xml.Element) !void {
        var sections = root.elements(null);
        while (sections.next()) |section| {
            if (eql(section.tag, "tags")) {
                var it = section.elements("tag");
                while (it.next()) |t| if (t.attr("name")) |n| try self.tags.append(self.arena, n);
            } else if (eql(section.tag, "types")) {
                var it = section.elements("type");
                while (it.next()) |t| try self.loadType(t);
            } else if (eql(section.tag, "enums")) {
                try self.loadEnums(section);
            } else if (eql(section.tag, "commands")) {
                var it = section.elements("command");
                while (it.next()) |c| try self.loadCommand(c);
            } else if (eql(section.tag, "feature")) {
                if (!apiMatches(section.attr("api"))) continue;
                const name = section.attr("name") orelse continue;
                if (std.mem.startsWith(u8, name, "VK_VERSION_")) {
                    try self.features.append(self.arena, .{ .name = name, .number = section.attr("number") orelse "" });
                }
                try self.loadRequires(section, null);
            } else if (eql(section.tag, "extensions")) {
                var it = section.elements("extension");
                while (it.next()) |ext| {
                    if (!listContains(ext.attr("supported") orelse "", api_name)) continue;
                    const number = if (ext.attr("number")) |n| std.fmt.parseInt(u32, n, 10) catch null else null;
                    try self.loadRequires(ext, number);
                }
            }
        }
    }

    fn loadType(self: *Registry, el: *const xml.Element) !void {
        if (!apiMatches(el.attr("api"))) return;
        const category = el.attr("category") orelse "";
        const name = el.attr("name") orelse el.childText("name") orelse
            (if (el.child("proto")) |p| p.childText("name") else null) orelse return;

        if (el.attr("alias")) |target| {
            return self.putType(.{ .name = name, .kind = .{ .alias = target } });
        }
        if (eql(category, "include")) return;
        if (eql(category, "define")) {
            if (eql(name, "VK_HEADER_VERSION")) {
                // `#define <name>VK_HEADER_VERSION</name> 368`
                const after = textAfterChild(el, "name") orelse return;
                const trimmed = std.mem.trim(u8, after, " \t\r\n");
                self.header_version = std.fmt.parseInt(u32, trimmed, 10) catch 0;
            }
            return;
        }
        if (eql(category, "basetype")) {
            if (eql(name, "VkBool32")) {
                return self.putType(.{ .name = name, .kind = .{ .basetype = .bool32 } });
            }
            if (el.child("type") != null) {
                const decl = try parseDecl(self.arena, el);
                return self.putType(.{ .name = name, .kind = .{ .basetype = .{ .typedef = decl } } });
            }
            const all = try allText(self.arena, el);
            const base: Basetype = if (std.mem.indexOfScalar(u8, all, '*') != null) .opaque_pointer else .opaque_type;
            return self.putType(.{ .name = name, .kind = .{ .basetype = base } });
        }
        if (eql(category, "bitmask")) {
            const base = el.childText("type") orelse "VkFlags";
            const bits = el.attr("bitvalues") orelse el.attr("requires");
            return self.putType(.{ .name = name, .kind = .{ .bitmask = .{ .bits = bits, .is_64 = eql(base, "VkFlags64") } } });
        }
        if (eql(category, "handle")) {
            const macro = el.childText("type") orelse "";
            return self.putType(.{ .name = name, .kind = .{ .handle = .{ .dispatchable = eql(macro, "VK_DEFINE_HANDLE") } } });
        }
        if (eql(category, "enum")) {
            return self.putType(.{ .name = name, .kind = .@"enum" });
        }
        if (eql(category, "funcpointer")) {
            const proto = el.child("proto") orelse return error.UnsupportedFuncpointer;
            var params: std.ArrayList(Decl) = .empty;
            var it = el.elements("param");
            while (it.next()) |p| try params.append(self.arena, try parseDecl(self.arena, p));
            return self.putType(.{ .name = name, .kind = .{ .funcpointer = .{
                .ret = try parseDecl(self.arena, proto),
                .params = params.items,
            } } });
        }
        if (eql(category, "struct") or eql(category, "union")) {
            var members: std.ArrayList(Decl) = .empty;
            var it = el.elements("member");
            while (it.next()) |m| {
                if (!apiMatches(m.attr("api"))) continue;
                try members.append(self.arena, try parseDecl(self.arena, m));
            }
            return self.putType(.{ .name = name, .kind = .{ .@"struct" = .{
                .members = members.items,
                .is_union = eql(category, "union"),
            } } });
        }
        if (el.attr("requires") != null and category.len == 0) {
            // `<type requires="windows.h" name="HWND"/>`, `uint32_t`, video stubs...
            if (self.types.contains(name)) return; // keep a real definition
            return self.putType(.{ .name = name, .kind = .external });
        }
    }

    fn putType(self: *Registry, t: TypeDef) !void {
        const gop = try self.types.getOrPut(self.arena, t.name);
        if (gop.found_existing and gop.value_ptr.kind != .external and t.kind == .external) return;
        gop.value_ptr.* = t;
    }

    fn loadEnums(self: *Registry, section: *const xml.Element) !void {
        const name = section.attr("name") orelse return;
        const kind = section.attr("type") orelse "";
        if (eql(kind, "constants")) {
            var it = section.elements("enum");
            while (it.next()) |e| {
                if (!apiMatches(e.attr("api"))) continue;
                const n = e.attr("name") orelse continue;
                try self.constants.put(self.arena, n, .{
                    .name = n,
                    .value = e.attr("value") orelse "",
                    .c_type = e.attr("type"),
                    .alias = e.attr("alias"),
                });
            }
            return;
        }
        if (!eql(kind, "enum") and !eql(kind, "bitmask")) return;
        const gop = try self.enums.getOrPut(self.arena, name);
        if (!gop.found_existing) gop.value_ptr.* = .{
            .name = name,
            .is_bitmask = eql(kind, "bitmask"),
            .is_64 = eql(section.attr("bitwidth") orelse "", "64"),
        };
        var it = section.elements("enum");
        while (it.next()) |e| {
            if (!apiMatches(e.attr("api"))) continue;
            if (try enumValueFromElement(e, null)) |v| {
                if (!gop.value_ptr.has(v.name)) try gop.value_ptr.values.append(self.arena, v);
            }
        }
    }

    fn loadCommand(self: *Registry, el: *const xml.Element) !void {
        if (!apiMatches(el.attr("api"))) return;
        if (el.attr("alias")) |target| {
            const name = el.attr("name") orelse return;
            try self.command_aliases.put(self.arena, name, target);
            return;
        }
        const proto = el.child("proto") orelse return;
        const ret = try parseDecl(self.arena, proto);
        var params: std.ArrayList(Decl) = .empty;
        var it = el.elements("param");
        while (it.next()) |p| {
            if (!apiMatches(p.attr("api"))) continue;
            try params.append(self.arena, try parseDecl(self.arena, p));
        }
        try self.commands.put(self.arena, ret.name, .{
            .name = ret.name,
            .ret = ret,
            .params = params.items,
            .success_codes = try splitList(self.arena, el.attr("successcodes")),
            .error_codes = try splitList(self.arena, el.attr("errorcodes")),
        });
    }

    fn loadRequires(self: *Registry, parent: *const xml.Element, ext_number: ?u32) !void {
        // Types from e.g. VK_KHR_win32_surface live in vulkan_win32.h, which
        // needs windows.h; the C layout test leaves them out.
        const platform = parent.attr("platform");
        const needs_platform_header = platform != null and !eql(platform.?, "provisional");
        var reqs = parent.elements("require");
        while (reqs.next()) |req| {
            if (!apiMatches(req.attr("api"))) continue;
            var items = req.elements(null);
            while (items.next()) |item| {
                if (!apiMatches(item.attr("api"))) continue;
                const name = item.attr("name") orelse continue;
                if (eql(item.tag, "type")) {
                    try self.required_types.put(self.arena, name, {});
                    if (needs_platform_header) try self.platform_types.put(self.arena, name, {});
                } else if (eql(item.tag, "command")) {
                    try self.required_commands.put(self.arena, name, {});
                } else if (eql(item.tag, "enum")) {
                    if (item.attr("extends")) |extends| {
                        const v = (try enumValueFromElement(item, ext_number)) orelse continue;
                        const gop = try self.enums.getOrPut(self.arena, extends);
                        if (!gop.found_existing) gop.value_ptr.* = .{ .name = extends, .is_bitmask = false, .is_64 = false };
                        if (!gop.value_ptr.has(v.name)) try gop.value_ptr.values.append(self.arena, v);
                    } else if (item.attr("value") != null or item.attr("alias") != null) {
                        // Extension-name / spec-version / video constants.
                        if (self.constants.contains(name)) continue;
                        try self.constants.put(self.arena, name, .{
                            .name = name,
                            .value = item.attr("value") orelse "",
                            .c_type = item.attr("type"),
                            .alias = item.attr("alias"),
                        });
                    }
                }
            }
        }
    }

    /// Adds every type transitively referenced by required types and commands.
    pub fn computeClosure(self: *Registry) !void {
        // Seed with the types used by required commands (and their aliases).
        for (self.required_commands.keys()) |cmd_name| {
            const target = self.command_aliases.get(cmd_name) orelse cmd_name;
            const cmd = self.commands.get(target) orelse continue;
            try self.requireType(cmd.ret.type_name);
            for (cmd.params) |p| try self.requireType(p.type_name);
        }
        // Worklist over required types; `keys()` grows while iterating by index.
        var i: usize = 0;
        while (i < self.required_types.count()) : (i += 1) {
            const name = self.required_types.keys()[i];
            const t = self.types.get(name) orelse continue;
            switch (t.kind) {
                .alias => |target| try self.requireType(target),
                .basetype => |b| switch (b) {
                    .typedef => |d| try self.requireType(d.type_name),
                    else => {},
                },
                .bitmask => |bm| if (bm.bits) |bits| try self.requireType(bits),
                .funcpointer => |f| {
                    try self.requireType(f.ret.type_name);
                    for (f.params) |p| try self.requireType(p.type_name);
                },
                .@"struct" => |s| for (s.members) |m| try self.requireType(m.type_name),
                .handle, .@"enum", .external => {},
            }
        }
    }

    fn requireType(self: *Registry, name: []const u8) !void {
        try self.required_types.put(self.arena, name, {});
    }

    pub fn isRequiredType(self: *const Registry, name: []const u8) bool {
        return self.required_types.contains(name);
    }
};

fn enumValueFromElement(e: *const xml.Element, ext_number: ?u32) !?EnumValue {
    const name = e.attr("name") orelse return null;
    if (e.attr("alias")) |a| return .{ .name = name, .value = .{ .alias = a } };
    if (e.attr("bitpos")) |bp| {
        const pos = try std.fmt.parseInt(u7, bp, 10);
        return .{ .name = name, .value = .{ .int = @as(i128, 1) << pos } };
    }
    if (e.attr("value")) |v| {
        const n = parseCInt(v) orelse return null;
        return .{ .name = name, .value = .{ .int = n } };
    }
    if (e.attr("offset")) |off| {
        const ext = if (e.attr("extnumber")) |x| try std.fmt.parseInt(u32, x, 10) else ext_number orelse return null;
        const offset = try std.fmt.parseInt(i128, off, 10);
        var value: i128 = 1_000_000_000 + (@as(i128, ext) - 1) * 1000 + offset;
        if (eql(e.attr("dir") orelse "", "-")) value = -value;
        return .{ .name = name, .value = .{ .int = value } };
    }
    return null;
}

/// Parses `12`, `-4`, `0x7FFFFFFF`, `(~0U)`, `(~0ULL)`, `(~1U)`.
pub fn parseCInt(raw: []const u8) ?i128 {
    var s = std.mem.trim(u8, raw, " ()");
    var invert = false;
    if (s.len > 0 and s[0] == '~') {
        invert = true;
        s = s[1..];
    }
    s = std.mem.trimEnd(u8, s, "ULul");
    const n = std.fmt.parseInt(i128, s, 0) catch return null;
    return if (invert) ~n else n;
}

/// Parses the mixed text / `<type>` / `<name>` / `<enum>` content of a declaration.
pub fn parseDecl(arena: Allocator, el: *const xml.Element) !Decl {
    var decl: Decl = .{
        .name = "",
        .type_name = "",
        .len = el.attr("len"),
        .optional = el.attr("optional"),
        .values = el.attr("values"),
    };
    const State = enum { before_type, after_type, after_name };
    var state: State = .before_type;
    var base_const = false;
    var pending_const = false;
    var levels: std.ArrayList(PtrLevel) = .empty;
    var tail: std.ArrayList(u8) = .empty;

    for (el.children) |node| switch (node) {
        .text => |text| switch (state) {
            .before_type => if (std.mem.indexOf(u8, text, "const") != null) {
                base_const = true;
            },
            // `* const*`: each `*` points at something const if `const` came just before it.
            .after_type => {
                var i: usize = 0;
                while (i < text.len) : (i += 1) {
                    if (text[i] == '*') {
                        try levels.append(arena, .{ .pointee_const = pending_const });
                        pending_const = false;
                    } else if (std.mem.startsWith(u8, text[i..], "const")) {
                        pending_const = true;
                        i += "const".len - 1;
                    }
                }
            },
            .after_name => try tail.appendSlice(arena, text),
        },
        .element => |child| {
            if (eql(child.tag, "type")) {
                decl.type_name = child.firstText() orelse "";
                pending_const = base_const; // `const char*`: the first `*` points at const
                state = .after_type;
            } else if (eql(child.tag, "name")) {
                decl.name = child.firstText() orelse "";
                state = .after_name;
            } else if (eql(child.tag, "enum")) {
                try tail.appendSlice(arena, child.firstText() orelse "");
            }
            // <comment> is ignored.
        },
    };
    decl.pointers = levels.items;
    decl.is_const = base_const;

    // Tail: `[4]`, `[VK_UUID_SIZE]`, `[3][4]`, `:24`
    var dims: std.ArrayList([]const u8) = .empty;
    const t = tail.items;
    var i: usize = 0;
    while (i < t.len) : (i += 1) {
        if (t[i] == '[') {
            const end = std.mem.indexOfScalarPos(u8, t, i, ']') orelse break;
            try dims.append(arena, std.mem.trim(u8, t[i + 1 .. end], " "));
            i = end;
        } else if (t[i] == ':') {
            // `:24` in vk.xml, `: 1` in video.xml.
            const digits = std.mem.trimStart(u8, t[i + 1 ..], " ");
            var n: usize = 0;
            while (n < digits.len and std.ascii.isDigit(digits[n])) n += 1;
            decl.bitfield = std.fmt.parseInt(u16, digits[0..n], 10) catch null;
            break;
        }
    }
    decl.dims = dims.items;
    return decl;
}

fn textAfterChild(el: *const xml.Element, tag: []const u8) ?[]const u8 {
    var seen = false;
    for (el.children) |node| switch (node) {
        .element => |c| seen = seen or eql(c.tag, tag),
        .text => |t| if (seen) return t,
    };
    return null;
}

fn allText(arena: Allocator, el: *const xml.Element) ![]const u8 {
    var out: std.ArrayList(u8) = .empty;
    for (el.children) |node| switch (node) {
        .text => |t| try out.appendSlice(arena, t),
        .element => |c| try out.appendSlice(arena, try allText(arena, c)),
    };
    return out.items;
}

fn splitList(arena: Allocator, raw: ?[]const u8) ![]const []const u8 {
    const s = raw orelse return &.{};
    var out: std.ArrayList([]const u8) = .empty;
    var it = std.mem.tokenizeScalar(u8, s, ',');
    while (it.next()) |x| try out.append(arena, x);
    return out.items;
}

/// `api` attributes are comma-separated lists; absent means "all APIs".
pub fn apiMatches(attr: ?[]const u8) bool {
    const a = attr orelse return true;
    return listContains(a, api_name);
}

fn listContains(list: []const u8, item: []const u8) bool {
    var it = std.mem.tokenizeScalar(u8, list, ',');
    while (it.next()) |x| if (eql(x, item)) return true;
    return false;
}

fn eql(a: []const u8, b: []const u8) bool {
    return std.mem.eql(u8, a, b);
}

test "parseCInt" {
    try std.testing.expectEqual(@as(?i128, 256), parseCInt("256"));
    try std.testing.expectEqual(@as(?i128, -1), parseCInt("-1"));
    try std.testing.expectEqual(@as(?i128, 0x7FFFFFFF), parseCInt("0x7FFFFFFF"));
    try std.testing.expectEqual(@as(?i128, ~@as(i128, 0)), parseCInt("(~0U)"));
    try std.testing.expectEqual(@as(?i128, ~@as(i128, 1)), parseCInt("(~1U)"));
}

test "parseDecl pointers, arrays and bitfields" {
    var arena_state: std.heap.ArenaAllocator = .init(std.testing.allocator);
    defer arena_state.deinit();
    const arena = arena_state.allocator();
    const root = try xml.parse(arena,
        \\<t>
        \\<member len="enabledLayerCount,null-terminated">const <type>char</type>* const*      <name>ppEnabledLayerNames</name></member>
        \\<member><type>char</type> <name>deviceName</name>[<enum>VK_MAX_PHYSICAL_DEVICE_NAME_SIZE</enum>]</member>
        \\<member><type>float</type> <name>matrix</name>[3][4]</member>
        \\<member><type>uint32_t</type> <name>mask</name>:8</member>
        \\<member><type>void</type>* <name>pNext</name></member>
        \\<member><type>uint32_t</type> <name>vui_flag</name> : 1</member>
        \\</t>
    );
    var it = root.elements("member");
    const pp = try parseDecl(arena, it.next().?);
    try std.testing.expectEqual(@as(usize, 2), pp.pointers.len);
    try std.testing.expect(pp.pointers[0].pointee_const); // const char
    try std.testing.expect(pp.pointers[1].pointee_const); // char* const
    const dn = try parseDecl(arena, it.next().?);
    try std.testing.expectEqualStrings("VK_MAX_PHYSICAL_DEVICE_NAME_SIZE", dn.dims[0]);
    const mx = try parseDecl(arena, it.next().?);
    try std.testing.expectEqual(@as(usize, 2), mx.dims.len);
    const mask = try parseDecl(arena, it.next().?);
    try std.testing.expectEqual(@as(?u16, 8), mask.bitfield);
    const pn = try parseDecl(arena, it.next().?);
    try std.testing.expect(!pn.pointers[0].pointee_const);
    const vui = try parseDecl(arena, it.next().?); // video.xml spacing
    try std.testing.expectEqual(@as(?u16, 1), vui.bitfield);
}
