const std = @import("std");
// mem
const Allocator = std.mem.Allocator;
const count = std.mem.count;
const eql = std.mem.eql;
const endsWith = std.mem.endsWith;
const indexOf = std.mem.indexOf;
const indexOfScalar = std.mem.indexOfScalar;
const lastIndexOf = std.mem.lastIndexOf;
const lastIndexOfScalar = std.mem.lastIndexOfScalar;
const replace = std.mem.replace;
const splitScalar = std.mem.splitScalar;
const startsWith = std.mem.startsWith;
// debug
const print = std.debug.print;
// ascii
const allocLowerString = std.ascii.allocLowerString;
const lowerString = std.ascii.lowerString;
const toLower = std.ascii.toLower;
const isLower = std.ascii.isLower;
const isUpper = std.ascii.isUpper;
const isDigit = std.ascii.isDigit;
// fmt
const bufPrint = std.fmt.bufPrint;
// Custom Data Types
const end_str = switch (@import("builtin").os.tag) {
    .windows => "\r\n",
    else => "\n",
};
const Pair = @import("Pair.zig");
const Types = @import("Types.zig").Types;
const EnumField = @import("EnumField.zig");
const Position = @import("Position.zig");
const BUFFER_SIZE = @import("constants.zig").BUFFER_SIZE;
const write_filenames = std.meta.fieldNames(Types);
const TextData = @This();
// Fields
// Reader
read_buffer: [BUFFER_SIZE]u8 = undefined,
read_file: std.fs.File,
reader: std.fs.File.Reader,
ioreader: *std.Io.Reader,
// Buffer For Next Line
buffer: [BUFFER_SIZE]u8 = undefined,
// Data
// types: std.ArrayList([]const u8),
enum_fields: std.ArrayList(EnumField),
structs: std.ArrayList([]const u8),
// extern fns
extern_fns_imports: std.StringHashMap(void),
extern_fns: std.ArrayList([]const u8),
// previous variable names + their files
prev_var_names: std.ArrayList(Pair),
// Writer
write_files: [write_filenames.len]std.fs.File,
// Enum 2
is_enum2: bool = false,
// methods
pub fn init(allo: Allocator) !TextData {
    var self: TextData = undefined;
    // path
    const abs_path_read = try modCwd(allo, "translated_vulkan.zig");
    defer allo.free(abs_path_read);
    // read
    self.read_file = try std.fs.openFileAbsolute(abs_path_read, .{});
    self.reader = self.read_file.reader(&self.read_buffer);
    self.ioreader = &self.reader.interface;
    // storage
    self.enum_fields = try .initCapacity(allo, 8);
    self.structs = try .initCapacity(allo, 8);
    self.extern_fns_imports = .init(allo);
    self.extern_fns = try .initCapacity(allo, 8);
    self.prev_var_names = try .initCapacity(allo, 8);
    // write files
    inline for (write_filenames, 0..) |write_filename, i| {
        const filename: []const u8 = "vulkan_" ++ write_filename ++ ".zig";
        const abs_path_write = try modCwd(allo, filename);
        defer allo.free(abs_path_write);
        self.write_files[i] = try std.fs.createFileAbsolute(abs_path_write, .{});
    }
    // full struct
    return self;
}

pub fn deinit(self: *TextData, allo: Allocator) void {
    // close reader
    self.read_file.close();
    // deinit storage
    // Enum Fields
    if (self.enum_fields.items.len > 0) //
        for (self.enum_fields.items) |*item| item.deinit(allo);
    self.enum_fields.deinit(allo);
    // Structs
    if (self.structs.items.len > 0) //
        for (self.structs.items) |item| allo.free(item);
    self.structs.deinit(allo);
    // extern fns
    if (self.extern_fns.items.len > 0) //
        for (self.extern_fns.items) |item| allo.free(item);
    self.extern_fns.deinit(allo);
    var it = self.extern_fns_imports.iterator();
    while (it.next()) |item| {
        allo.free(item.key_ptr.*);
    }
    self.extern_fns_imports.deinit();
    // Previous Var Names
    if (self.prev_var_names.items.len > 0) //
        for (self.prev_var_names.items) |item| allo.free(item.var_name);
    self.prev_var_names.deinit(allo);
    // close writers
    for (0..write_filenames.len) |i| self.write_files[i].close();
}

fn nextLine(self: *TextData, buffer: *[BUFFER_SIZE]u8) !usize {
    const line = try self.ioreader.peekDelimiterInclusive('\n');
    const size = line.len;
    @memcpy(buffer[0..line.len], line);
    self.ioreader.toss(line.len);
    return size;
}

pub fn parse(self: *TextData, allo: Allocator) !void {
    _ = allo;
    // parse for variables
    while (true) {
        const size = self.nextLine(&self.buffer) catch |err| switch (err) {
            error.EndOfStream => break,
            else => return err,
        };
        const line: []const u8 = self.buffer[0..size];
        const line_type = determineLineType(line) orelse continue;
        switch (line_type) {
            // .inline_fn => try self.processInlineFn(line),
            // .extern_fn => try self.processExternFn(allo, line),
            // .pfn => try self.processPFN(line),
            // .flag1_enum => {},
            // .flag1_pes => {},
            // .flag2_enum => {},
            // .flag2_pes => {},
            // ._opaque => try self.processOpaque(),
            .extern_struct => try self.processExternStruct(line),
            // .extern_union => try self.processExternUnion(line),
            // .extension_name => try self.processExtensionName(line),
            // .spec_version => try self.processSpecVersion(line),
            // ._type => try self.processTypes(allo, line),
            inline else => |tag| {
                _ = tag;
                // try self.writeToFile(tag, line);
            }
        }
    }
    try self.writeExternFn();
}

fn determineLineType(line: []const u8) ?Types {
    // base
    if (line.len == 0) return null;
    var newline = line;
    // pub
    if (!startsWith(u8, newline, "pub ")) return null;
    newline = trimLeft(newline, &.{ "pub ", "" });
    if (isInlineFn(newline)) return .inline_fn;
    if (isExternFn(newline)) return .extern_fn;
    // const
    if (!startsWith(u8, newline, "const ")) return null;
    newline = trimLeft(newline, &.{ "const ", "" });
    if (isPFN(newline)) return .pfn;
    if (isFlag1PES(newline)) return .flag1_pes;
    if (isFlag1Enum(newline)) return .flag1_enum;
    if (isFlag2PES(newline)) return .flag2_pes;
    if (isFlag2Enum(newline)) return .flag2_enum;
    if (isOpaque(newline)) return ._opaque;
    if (isExternStruct(newline)) return .extern_struct;
    if (isExternUnion(newline)) return .extern_union;
    if (isExtensionName(newline)) return .extension_name;
    if (isSpecVersion(newline)) return .spec_version;
    if (isType(newline)) return ._type;
    // base
    return null;
}

fn isInlineFn(line: []const u8) bool {
    return startsWith(u8, line, "inline fn VK_");
}

fn isExternFn(line: []const u8) bool {
    return startsWith(u8, line, "extern fn vk");
}

fn isPFN(line: []const u8) bool {
    return startsWith(u8, line, "PFN_vk");
}

fn isFlag1PES(line: []const u8) bool {
    const var_name = varName(line, &.{}, &.{});
    const var_value = varValue(line);
    const start = startsWith(u8, var_name, "Vk");
    const end = endsWith(u8, var_value, "VkFlags");
    return start and end;
}

fn isFlag1Enum(line: []const u8) bool {
    const var_name = varName(line, &.{}, &.{});
    return startsWith(u8, var_name, "enum_Vk") and endsWith(u8, var_name, "FlagBits");
}

fn isFlag2PES(line: []const u8) bool {
    const var_name = varName(line, &.{}, &.{});
    return endsWith(u8, var_name, "Flags2");
}

fn isFlag2Enum(line: []const u8) bool {
    const var_name = varName(line, &.{}, &.{});
    return endsWith(u8, var_name, "FlagBits2");
}

fn isOpaque(line: []const u8) bool {
    return startsWith(u8, line, "struct_Vk") and //
        endsWith(u8, trimLine(line), "opaque {};");
}

fn isExternStruct(line: []const u8) bool {
    return startsWith(u8, line, "struct_Vk") and //
        endsWith(u8, trimLine(line), "extern struct {");
}

fn isExternUnion(line: []const u8) bool {
    return startsWith(u8, line, "union_Vk") and //
        endsWith(u8, trimLine(line), "extern union {");
}

fn isExtensionName(line: []const u8) bool {
    const var_name = varName(line, &.{}, &.{});
    return endsWith(u8, var_name, "EXTENSION_NAME");
}

fn isSpecVersion(line: []const u8) bool {
    const var_name = varName(line, &.{}, &.{});
    return endsWith(u8, var_name, "SPEC_VERSION");
}

fn isType(line: []const u8) bool {
    const var_name = varName(line, &.{}, &.{});
    const var_value = varValue(line);
    const bad_var_values = [_][]const u8{
        "enum_Vk",
        "struct_Vk",
        "union_Vk",
        "Vk",
        "?*anyopaque",
        "__",
    };
    for (bad_var_values) |bad_var_value| {
        if (startsWith(u8, var_value, bad_var_value)) return false;
    }
    return startsWith(u8, var_name, "Vk");
}

fn processInlineFn(self: *TextData, line: []const u8) !void {
    // Get Old Var Name - No Vk
    const vk_idx = indexOf(u8, line, "VK_").?;
    const open_paren_idx = indexOfScalar(u8, line, '(').?;
    const var_name = line[vk_idx + 3 .. open_paren_idx];
    var buf1: [BUFFER_SIZE]u8 = undefined;
    // Get Old Var Name - W/ Vk
    const var_name1 = line[vk_idx..open_paren_idx];
    @memcpy(buf1[0..var_name1.len], var_name1);
    const old_var_name = buf1[0..var_name1.len];
    // print("Var Name: {s}\n", .{old_var_name});
    // Create New Var Name
    var buf2: [BUFFER_SIZE]u8 = undefined;
    var i: usize = 0;
    buf2[i] = toLower(var_name[i]);
    i += 1;
    for (
        var_name[0 .. var_name.len - 1],
        var_name[1..var_name.len],
    ) |ch1, ch2| {
        if (ch2 == '_') continue;
        if (ch1 == '_') {
            buf2[i] = ch2;
        } else {
            buf2[i] = toLower(ch2);
        }
        i += 1;
    }
    const new_var_name = buf2[0..i];
    // print("New Var Name: {s}\n", .{new_var_name});
    // Copy fn
    {
        const prefix = "pub ";
        const line1 = line[prefix.len..line.len];
        try self.writeToFile(.inline_fn, line1);
    }
    while (true) {
        const size = self.nextLine(&self.buffer) catch unreachable;
        const line1 = self.buffer[0..size];
        try self.writeToFile(.inline_fn, line1);
        if (startsWith(u8, line1, "}")) break;
    }
    // Create new fn = easier interface
    var buf3: [BUFFER_SIZE]u8 = undefined;
    const line1 = try bufPrint(
        &buf3,
        "pub const {s} = {s};{s}",
        .{ new_var_name, old_var_name, end_str },
    );
    // print("Line 1: {s}\n", .{line1});
    try self.writeToFile(.inline_fn, line1);
}

fn processExternFn(self: *TextData, allo: Allocator, line: []const u8) !void {
    // _ = self;
    // _ = allo;
    var buf1: [BUFFER_SIZE]u8 = undefined;
    var buf2: [BUFFER_SIZE]u8 = undefined;
    // convert args - 1
    const line1 = argNamesToSnake(&buf1, line);
    //   print("Line 1: {s}", .{line1});
    // remove vk from args - 2
    const line2 = removeVkFromArgs(&buf2, line1);
    //   print("Line 2: {s}\n", .{line2});
    // remove vk from result - 1
    const line3 = removeVkFromResult(&buf1, line2);
    //   print("Line 3: {s}\n", .{line3});
    // remove pub - 1
    const prefix = "pub ";
    removePrefix(&buf1, prefix);
    const line4 = buf1[0 .. line3.len - prefix.len];
    //   print("Line 4: {s}\n", .{line4});
    // extract var name - 2
    const var_name = varName(line4, &.{ "extern ", "fn ", "vk" }, &.{});
    const prefix1 = "pub const ";
    const line5 = try bufPrint(
        &buf2,
        "{s}{s} = vk{s};{s}",
        .{ prefix1, var_name, var_name, end_str },
    );
    buf2[prefix1.len] = toLower(buf2[prefix1.len]);
    //   print("Line 5: {s}\n", .{line5});
    // Store both lines
    const dup_line = try allo.dupe(u8, line4);
    try self.extern_fns.append(allo, dup_line);
    const dup_line1 = try allo.dupe(u8, line5);
    try self.extern_fns.append(allo, dup_line1);
}

fn processPFN(self: *TextData, line: []const u8) !void {
    // _ = self;
    // print("Line: {s}", .{line});
    // Replace Vks
    var buf1: [BUFFER_SIZE]u8 = undefined;
    const n_reps = replace(u8, line, "Vk", "", &buf1);
    const end = line.len - (n_reps * 2);
    var line1 = buf1[0..end];
    const prefix = "pub ";
    line1 = if (startsWith(u8, line1, prefix)) line1[prefix.len..line1.len] else line1;
    // print("Line 1: {s}", .{line1});
    try self.writeToFile(.pfn, line1);
    // Create custom PFN w/o vk prefix
    const var_name = varName(line1, &.{ "pub ", "const ", "PFN_vk" }, &.{});
    var buf2: [BUFFER_SIZE]u8 = undefined;
    const line2 = try bufPrint(
        &buf2,
        "pub const PFN_{s} = PFN_vk{s};{s}",
        .{ var_name, var_name, end_str },
    );
    // print("Line 2: {s}\n", .{line2});
    try self.writeToFile(.pfn, line2);
}

fn processFlag1PES(self: *TextData, allo: Allocator, line: []const u8) !void {
    _ = self;
    _ = allo;
    const var_name = varName(line, &.{ "pub ", "const ", "Vk" }, &.{});
    const var_value = varValue(line);

    var buf: [BUFFER_SIZE]u8 = undefined;
    try bufPrint(
        &buf,
        "pub const {s} = PES({s});{s}",
        .{ var_name, var_value, end_str },
    );
    // try self.writeToFile(.flag1_pes, line);
}

fn processFlag1Enum(self: *TextData, allo: Allocator, line: []const u8) !void {
    _ = self;
    _ = allo;
    const var_name = varName(line, &.{ "pub ", "const ", "enum_Vk" }, &.{});
    const var_value = varValue(line);

    var buf: [BUFFER_SIZE]u8 = undefined;
    const line1 = try bufPrint(
        &buf,
        "pub const {s} = enum({s}){{{s}",
        .{ var_name, var_value, end_str },
    );
    _ = line1;
    // try self.writeToFile(.flag1_enum, line1);
}

fn processFlag2PES() void {}

fn processFlag2Enum() void {}

fn processOpaque(self: *TextData) !void {
    const size = try self.nextLine(&self.buffer);
    const line1: []const u8 = self.buffer[0..size];
    const var_name = varName(line1, &.{ "pub const Vk", "" }, &.{});
    var buffer: [1024]u8 = undefined;
    const line2 = try bufPrint(
        &buffer,
        "pub const {s} = enum(isize) {s}{s}    null = 0,{s}    _,{s}{s}{s}",
        .{ var_name, "{", end_str, end_str, end_str, "};", end_str },
    );
    try self.writeToFile(._opaque, line2);
}

fn processExternStruct(self: *TextData, line: []const u8) !void {
    // Convert name to remove struct_Vk
    var buf1: [BUFFER_SIZE]u8 = undefined;
    const line1 = removeBuf(&buf1, line, "struct_Vk");
    print("Line 1: {s}", .{line1});
    // try self.writeToFile(.extern_struct, line1);
    // get var name for s_type
    const var_name = varName(line1, &.{ "pub ", "const " }, &.{});
    print("Var Name: {s}\n", .{var_name});
    var buf2: [BUFFER_SIZE]u8 = undefined;
    const snake_name = toSnake(&buf2, var_name);
    print("Snake Name: {s}\n", .{snake_name});

    while (true) {
        const size = self.nextLine(&self.buffer) catch unreachable;
        const line2 = self.buffer[0..size];
        if (startsWith(u8, line, "}")) break;
        // print("Line 2: {s}", .{line2});
        // field line to modify
        // idxs
        const colon_idx = indexOfScalar(u8, line2, ':').?;
        const name_idx = lastIndexOfScalar(u8, line2[0..colon_idx], ' ').? + 1;
        const eql_idx = indexOfScalar(u8, line2, '=').?;
        // assertions
        std.debug.assert(name_idx < colon_idx);
        std.debug.assert(colon_idx < eql_idx);
        // posiitons
        // copy field line spacing
        var bp: Position = .{ .start = 0, .end = 0 }; // buffer position
        var buf3: [BUFFER_SIZE]u8 = undefined;
        const spacing = line2[0..name_idx];
        copy(&buf3, &bp, spacing);
        // convert field name to snake
        const field_name = line2[name_idx..colon_idx];
        // print("Field Name: {s}\n", .{field_name});
        buf1 = undefined;
        const snake_name1 = toSnake(&buf1, field_name);
        // print("Snake Name: {s}\n", .{snake_name1});
        copy(&buf3, &bp, snake_name1);
        copy(&buf3, &bp, ": ");
        // copy type
        const var_type = line2[colon_idx + 2 .. eql_idx];
        // print("Var Type: {s}\n", .{var_type});
        buf1 = undefined;
        const var_type1 = removeBuf(&buf1, var_type, "Vk");
        // print("Var Type: {s}\n", .{var_type1});
        bp.start = bp.end;
        bp.end += var_type1.len;
        @memcpy(buf3[bp.start..bp.end], var_type1);
        const line3 = buf3[0..bp.end];
        print("Line 3: {s}\n", .{line3});
        // If Structure Type - write structure type
        // Else - write what it was
        if (startsWith(u8, var_type1, "StructureType")) {
            // prefix
            const prefix1 = "= .";
            bp.start = bp.end;
            bp.end += prefix1.len;
            @memcpy(buf3[bp.start..bp.end], prefix1);
            bp.start = bp.end;
            bp.end += snake_name.len;
            @memcpy(buf3[bp.start..bp.end], snake_name);
            buf3[bp.end] = ',';
            bp.end += 1;
        } else {
            bp.start = bp.end;
            bp.end += line2.len - eql_idx;
            const old_line = line2[eql_idx..line2.len];
            var buf4: [BUFFER_SIZE]u8 = undefined;
            const line4 = removeBuf(&buf4, old_line, "Vk");
            bp.start = bp.end;
            bp.end += line4.len;
            @memcpy(buf3[bp.start..bp.end], line4);
        }
        const line4 = buf3[0..bp.end];
        print("Line: {s}\n", .{line4});
        // Replace Vks
        // print("Line 4: {s}", .{line4});
        // convert s_types to specific value rather than random value
        // try self.writeToFile(.inline_fn, line2);
    }
}

fn processExternUnion(self: *TextData, line: []const u8) !void {
    _ = self;
    print("Line: {s}", .{line});
    // try self.writeToFile(.extern_union, line);
}

fn processExtensionName(self: *TextData, line: []const u8) !void {
    // print("Line: {s}", .{line});
    // Grab name + value
    const var_name = varName(
        line,
        &.{ "pub ", "const ", "VK_", "KHR_" },
        &.{"_EXTENSION_NAME"},
    );
    const var_value = varValue(line);
    // Skip if value is not a string
    if (!startsWith(u8, var_value, "\"")) return;
    // convert to lower
    var buf1: [BUFFER_SIZE]u8 = undefined;
    const new_var_name = lowerString(&buf1, var_name);
    // Convert to line
    var buf: [1024]u8 = undefined;
    const line1 = if (!isDigit(new_var_name[0])) try bufPrint(
        &buf,
        "pub const {s}: [*:0]const u8 = {s};{s}",
        .{ new_var_name, var_value, end_str },
    ) //
        else try bufPrint(
            &buf,
            "pub const @\"{s}\": [*:0]const u8 = {s};{s}",
            .{ new_var_name, var_value, end_str },
        );
    // print("Line 1: {s}", .{line1});
    try self.writeToFile(.extension_name, line1);
}

fn processSpecVersion(self: *TextData, line: []const u8) !void {
    // print("Line: {s}", .{line});
    // Grab name + value + type
    const var_name = varName(line, &.{ "pub ", "const ", "VK_", "KHR_" }, &.{"_SPEC_VERSION"});
    const var_value = varValue(line);
    if (lastIndexOf(u8, line, "@as") == null) return;
    const var_type = varTypePostEql(line);
    // print("Name: {s}\n", .{var_name});
    // print("Value: {s}\n", .{var_value});
    // print("Type: {s}\n", .{var_type});
    // convert to lower
    var buf1: [BUFFER_SIZE]u8 = undefined;
    const new_var_name = lowerString(&buf1, var_name);
    // convert to line
    var buf: [1024]u8 = undefined;
    const line1 = try bufPrint(
        &buf,
        "pub const {s}: {s} = {s};{s}",
        .{ new_var_name, var_type, var_value, end_str },
    );
    // print("Line 1: {s}\n", .{line1});
    try self.writeToFile(.spec_version, line1);
}

fn processTypes(self: *TextData, allo: Allocator, line: []const u8) !void {
    // print("Line: {s}", .{line});
    // get name + value
    const var_name = varName(line, &.{ "pub ", "const ", "Vk" }, &.{});
    const var_value = varValue(line);
    // create line
    var buf: [1024]u8 = undefined;
    const line1 = if (!eql(u8, var_name, "Bool32")) try bufPrint(
        &buf,
        "pub const {s} = {s};{s}",
        .{ var_name, var_value, end_str },
    ) //
        else //
        try bufPrint(
            &buf,
            "pub const {s} = enum(u32) {s}{s}    false = 0,{s}    true = 1,{s}{s}{s}",
            .{ var_name, "{", end_str, end_str, end_str, "};", end_str },
        );
    // print("Line 1: {s}", .{line1});
    try self.writeToFile(._type, line1);
    // Add name to list of var names
    const new_var_name = try allo.dupe(u8, var_name);
    try self.prev_var_names.append(
        allo,
        .{ .var_name = new_var_name, .var_type = ._type },
    );
}

fn bsEF(self: *TextData) void {
    // bubble sort enum fields
    const len = self.enum_fields.items.len;
    for (0..len - 1) |i| {
        const ef1 = self.enum_fields.items[i];
        for (i + 1..len) |j| {
            const ef2 = self.enum_fields.items[j];
            if (ef1.value > ef2.value) {
                self.enum_fields.items[i] = ef2;
                self.enum_fields.items[j] = ef1;
            }
        }
    }
}

fn writeToFile(self: *TextData, comptime filename: Types, line: []const u8) !void {
    const idx: usize = std.meta.fieldIndex(Types, @tagName(filename)).?;
    _ = try self.write_files[idx].write(line);
}

fn writeExternFn(self: *TextData) !void {
    if (self.extern_fns.items.len > 0) {
        // imports
        var it = self.extern_fns_imports.iterator();
        var it_buf: [1024]u8 = undefined;
        while (it.next()) |item| {
            const line = try bufPrint(
                &it_buf,
                "const {s} = @import(\"{s}\").{s};{s}",
                .{ item.key_ptr.*, "vulkan_types.zig", item.key_ptr.*, end_str },
            );
            try self.writeToFile(.extern_fn, line);
        }
        // extern fns
        for (self.extern_fns.items) |item| {
            try self.writeToFile(.extern_fn, item);
        }
    }
}

fn splitTitle(allo: Allocator, name: []const u8) !std.ArrayList([]const u8) {
    const len = name.len;
    var n_splits: usize = 1;
    var split_idxs: [64]usize = undefined;
    var idx: usize = 0;
    for (0..len - 1, 1..len) |i, j| {
        if ((isLower(name[i]) or isDigit(name[i])) and isUpper(name[j])) {
            split_idxs[idx] = j;
            n_splits += 1;
            idx += 1;
        }
    }
    split_idxs[n_splits - 1] = name.len;
    var splits: std.ArrayList([]const u8) = try .initCapacity(allo, n_splits);
    var start: usize = 0;
    var end: usize = split_idxs[0];
    {
        const lowered_name = try allocLowerString(allo, name[start..end]);
        splits.appendAssumeCapacity(lowered_name);
    }
    for (1..n_splits) |i| {
        start = end;
        end = split_idxs[i];
        const lowered_name = try allocLowerString(allo, name[start..end]);
        splits.appendAssumeCapacity(lowered_name);
    }
    return splits;
}

fn splitFields(allo: Allocator, name: []const u8) !std.ArrayList([]const u8) {
    var n_splits: usize = 1;
    for (name) |ch| {
        switch (ch) {
            '_' => n_splits += 1,
            else => continue,
        }
    }
    var arr: std.ArrayList([]const u8) = try .initCapacity(allo, n_splits);
    var start: usize = 0;
    for (name, 0..) |ch, i| {
        switch (ch) {
            '_' => {
                const split_name = try allocLowerString(allo, name[start..i]);
                arr.appendAssumeCapacity(split_name);
                start = i + 1;
            },
            else => continue,
        }
    }
    const split_name = try allocLowerString(allo, name[start..name.len]);
    arr.appendAssumeCapacity(split_name);
    return arr;
}

fn removeMatches(
    allo: Allocator,
    arr1: *const std.ArrayList([]const u8),
    arr2: *std.ArrayList([]const u8),
) void {
    const limit: usize = 64;
    std.debug.assert(arr1.items.len < limit);
    var matches1 = [_]bool{false} ** limit;
    var matches2 = [_]bool{false} ** limit;
    outer: for (arr2.items, 0..) |item2, j| {
        inner: for (arr1.items, 0..) |item1, i| {
            if (matches1[i]) continue :inner;
            if (eql(u8, item2, item1)) {
                matches2[j] = true;
                matches1[i] = true;
                continue :outer;
            }
        }
    }
    const len = arr2.items.len;
    for (0..len) |i| {
        const j = len - i - 1;
        if (matches2[j]) {
            const data = arr2.orderedRemove(j);
            allo.free(data);
        }
    }
}

fn reconstructEnumFieldName(
    allo: Allocator,
    arr: *const std.ArrayList([]const u8),
) ![]const u8 {
    std.debug.assert(arr.items.len > 0);

    var new_len: usize = arr.items[0].len;
    for (arr.items[1..arr.items.len]) |item| {
        new_len += item.len + 1;
    }

    var new_word = try allo.alloc(u8, new_len);
    var start: usize = 0;
    var end: usize = arr.items[0].len;
    @memcpy(new_word[start..end], arr.items[0]);
    for (arr.items[1..arr.items.len]) |item| {
        start = end;
        new_word[start] = '_';
        start += 1;
        end = start + item.len;
        @memcpy(new_word[start..end], item);
    }

    return new_word;
}

fn varName(
    line: []const u8,
    prefixes: []const []const u8,
    suffixes: []const []const u8,
) []const u8 {
    var name = trimLeft(line, prefixes);
    const space_idx = indexOfScalar(u8, name, ' ') orelse name.len;
    const open_paren_idx = indexOfScalar(u8, name, '(') orelse name.len;
    const end = @min(space_idx, open_paren_idx);
    name = name[0..end];
    name = trimRight(name, suffixes);
    return name;
}

fn varValue(line: []const u8) []const u8 {
    const start = lastIndexOfScalar(u8, line, ' ').? + 1;
    if (lastIndexOfScalar(u8, line, ')')) |close_paren_idx| {
        if (close_paren_idx > start) {
            return line[start..close_paren_idx];
        }
    }
    const end = lastIndexOfScalar(u8, line, ';') orelse line.len;
    std.debug.assert(start < end);
    return line[start..end];
}

fn varTypePreEql(line: []const u8) []const u8 {
    const eql_idx = indexOfScalar(u8, line, '=').?;
    const colon_idx = lastIndexOfScalar(u8, line, ':').?;
    return line[colon_idx + 1 .. eql_idx - 1];
}

fn varTypePostEql(line: []const u8) []const u8 {
    const open_paren_idx = lastIndexOfScalar(u8, line, '(').?;
    const comma_idx = lastIndexOfScalar(u8, line, ',').?;
    std.debug.assert(open_paren_idx < comma_idx);
    return line[open_paren_idx + 1 .. comma_idx];
}

fn modCwd(allo: Allocator, filename: []const u8) ![]const u8 {
    if (!endsWith(u8, filename, ".zig")) return error.MustHaveZigExt;
    const cwd = try std.fs.cwd().realpathAlloc(allo, ".");
    defer allo.free(cwd);
    if (endsWith(u8, cwd, "src")) {
        return try std.fs.path.join(allo, &.{ cwd, filename });
    } else if (endsWith(u8, cwd, "TranslateVulkan")) {
        return try std.fs.path.join(allo, &.{ cwd, "src", filename });
    }
    unreachable;
}

fn trimLeft(
    name: []const u8,
    prefixes: []const []const u8,
) []const u8 {
    var start: usize = 0;
    for (prefixes) |prefix| {
        if (prefix.len == 0) continue;
        start += @intFromBool(startsWith(u8, name[start..name.len], prefix)) * prefix.len;
    }
    return name[start..name.len];
}

fn trimRight(
    name: []const u8,
    suffixes: []const []const u8,
) []const u8 {
    var end: usize = name.len;
    for (suffixes) |suffix| {
        if (suffix.len == 0) continue;
        end -= @intFromBool(endsWith(u8, name[0..end], suffix)) * suffix.len;
    }
    return name[0..end];
}

fn trimLine(line: []const u8) []const u8 {
    return std.mem.trimRight(u8, line, end_str);
}

fn hasType(type_name: []const u8) bool {
    for ([_][]const u8{
        "c_uint",
        "c_int",
        "u8",
        "u16",
        "u32",
        "u64",
        "i8",
        "i16",
        "i32",
        "i64",
        "f8",
        "f16",
        "f32",
        "f64",
        "usize",
        "isize",
        "anyopaque",
        "?*anyopaque",
    }) |type_name1| {
        if (eql(u8, type_name1, type_name)) return true;
    } else return false;
}

fn toSnake(buf: *[BUFFER_SIZE]u8, name: []const u8) []const u8 {
    std.debug.assert(name.len < BUFFER_SIZE);
    buf[0] = toLower(name[0]);
    var i: usize = 1;
    for (1..name.len) |j| {
        const ch1 = name[j - 1];
        const ch2 = name[j];
        if ((isDigit(ch1) or isLower(ch1)) and isUpper(ch2)) {
            buf[i] = '_';
            i += 1;
        }
        buf[i] = toLower(ch2);
        i += 1;
    }
    return buf[0..i];
}

fn argNamesToSnake(buf: *[BUFFER_SIZE]u8, line: []const u8) []const u8 {
    // get paren idxs
    const open_paren_idx = indexOfScalar(u8, line, '(').?;
    const close_paren_idx = lastIndexOfScalar(u8, line, ')').?;
    // create idxs
    var start: usize = 0;
    var end: usize = open_paren_idx;
    // copy start
    @memcpy(buf[start .. end + 1], line[start .. end + 1]);
    start = end + 1;
    // count commas
    var n_commas: usize = 0;
    for (line[open_paren_idx + 1 .. close_paren_idx - 1]) |ch| {
        n_commas += @intFromBool(ch == ',');
    }
    // iterator
    var it = splitScalar(u8, line[open_paren_idx..close_paren_idx], ',');
    while (it.next()) |item| {
        // get arg name
        const colon_idx = indexOfScalar(u8, item, ':').?;
        const arg_name = item[0..colon_idx];
        // convert to snake
        var buf1: [BUFFER_SIZE]u8 = undefined;
        const new_name = toSnake(&buf1, arg_name);
        @memcpy(buf[start .. start + new_name.len], new_name);
        // copy rest
        end = start + item.len - colon_idx;
        @memcpy(buf[start..end], item[colon_idx..item.len]);
        start = end;
        if (n_commas > 0) {
            buf[start] = ',';
            start += 1;
            buf[start] = ' ';
            start += 1;
            n_commas -= 1;
        }
    }
    // copy rest of buffer
    end = start + line.len - close_paren_idx;
    @memcpy(buf[start..end], line[close_paren_idx..line.len]);
    // copy + return
    return buf[0..end];
}

fn removeVkFromExternFnName(buf: *[BUFFER_SIZE]u8, line: []const u8) []const u8 {
    // create new var name
    var name_buf: [BUFFER_SIZE]u8 = undefined;
    var var_name = varName(line, &.{ "pub ", "extern ", "fn ", "vk" }, &.{});
    @memcpy(name_buf[0..var_name.len], var_name);
    name_buf[0] = toLower(name_buf[0]);
    var_name = name_buf[0..var_name.len];
    // get old name pos
    const vk_idx = indexOf(u8, line, "vk").?;
    // replace with new name
    var start: usize, var end: usize = .{ 0, vk_idx };
    @memcpy(buf[start..end], line[0..vk_idx]);
    start = end;
    end += var_name.len;
    @memcpy(buf[start..end], var_name);
    start = end;
    const open_paren_idx = indexOfScalar(u8, line, '(').?;
    end += line.len - open_paren_idx;
    @memcpy(buf[start..end], line[open_paren_idx..line.len]);
    return buf[0..end];
}

fn removeVkFromArgs(buf: *[BUFFER_SIZE]u8, line: []const u8) []const u8 {
    // idxs
    const open_paren_idx = indexOfScalar(u8, line, '(').?;
    const close_paren_idx = lastIndexOfScalar(u8, line, ')').?;
    // copy before parens
    const before_paren = line[0 .. open_paren_idx + 1];
    @memcpy(buf[0..before_paren.len], before_paren);
    // replace middle
    const args = line[open_paren_idx + 1 .. close_paren_idx];
    const rep_sz = replace(u8, args, "Vk", "", buf[before_paren.len..BUFFER_SIZE]);
    // copy after pares
    const after_paren = line[close_paren_idx..line.len];
    var bp: Position = undefined;
    bp.start = before_paren.len + args.len - (rep_sz * 2);
    bp.end = bp.start + after_paren.len;
    @memcpy(buf[bp.start..bp.end], after_paren);
    // return
    return buf[0..bp.end];
}

fn removeVkFromResult(buf: *[BUFFER_SIZE]u8, line: []const u8) []const u8 {
    const close_paren_idx = lastIndexOfScalar(u8, line, ')').?;
    @memcpy(buf[0 .. close_paren_idx + 1], line[0 .. close_paren_idx + 1]);
    const rep_str = "Vk";
    const n_reps = replace(
        u8,
        line[close_paren_idx + 1 .. line.len],
        rep_str,
        "",
        buf[close_paren_idx + 1 .. BUFFER_SIZE],
    );
    const end = line.len - (n_reps * rep_str.len);
    return buf[0..end];
}

fn removePrefix(buf: *[BUFFER_SIZE]u8, name: []const u8) void {
    std.debug.assert(name.len < BUFFER_SIZE);
    if (startsWith(u8, buf[0..name.len], name)) {
        const len = name.len;
        for (0..BUFFER_SIZE - len) |i| {
            buf[i] = buf[i + name.len];
        }
    }
}

fn removeBuf(
    buf: *[BUFFER_SIZE]u8,
    line: []const u8,
    needle: []const u8,
) []const u8 {
    const n_replaces = replace(u8, line, needle, "", buf);
    const end = line.len - (n_replaces * needle.len);
    return buf[0..end];
}
