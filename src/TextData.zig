const std = @import("std");
// mem
const Allocator = std.mem.Allocator;
const indexOf = std.mem.indexOf;
const indexOfScalar = std.mem.indexOfScalar;
const lastIndexOf = std.mem.lastIndexOf;
const lastIndexOfScalar = std.mem.lastIndexOfScalar;
const replace = std.mem.replace;
const splitScalar = std.mem.splitScalar;
const count = std.mem.count;
const eql = std.mem.eql;
const startsWith = std.mem.startsWith;
const endsWith = std.mem.endsWith;
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
// Text Processing
const modCwd = @import("TextProcessing.zig").modCwd;
const trimLeft = @import("TextProcessing.zig").trimLeft;
const trimRight = @import("TextProcessing.zig").trimRight;
const trimLine = @import("TextProcessing.zig").trimLine;
const varName = @import("TextProcessing.zig").varName;
const varValue = @import("TextProcessing.zig").varValue;
const varType = @import("TextProcessing.zig").varType;
// Custom Data Types
const end_str = switch (@import("builtin").os.tag) {
    .windows => "\r\n",
    else => "\n",
};
const Pair = @import("Pair.zig");
const Types = @import("Types.zig").Types;
const EnumField = @import("EnumField.zig");
const Buffer = @import("Buffer.zig");
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
extension_names: std.ArrayList([]const u8),
spec_versions: std.ArrayList([]const u8),
// Writer
write_files: [write_filenames.len]std.fs.File,
// Flags
is_enum2: bool = false,
enum2_title: Buffer = .{},
enum2_field_names: std.StringHashMap(void),
enum2_field_values: std.StringHashMap(void),
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
    self.extension_names = try .initCapacity(allo, 8);
    self.spec_versions = try .initCapacity(allo, 8);
    self.enum2_field_names = .init(allo);
    self.enum2_field_values = .init(allo);
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
    // extension names
    for (self.extension_names.items) |extension_name| allo.free(extension_name);
    self.extension_names.deinit(allo);
    // spec versions
    for (self.spec_versions.items) |spec_version| allo.free(spec_version);
    self.spec_versions.deinit(allo);
    // field names
    var kit = self.enum2_field_names.keyIterator();
    while (kit.next()) |item| allo.free(item.*);
    self.enum2_field_names.deinit();
    // field values
    kit = self.enum2_field_values.keyIterator();
    while (kit.next()) |item| allo.free(item.*);
    self.enum2_field_values.deinit();
    // close writers
    for (0..write_filenames.len) |i| self.write_files[i].close();
}

fn nextline(self: *TextData, buffer: *[BUFFER_SIZE]u8) ![]const u8 {
    const line = try self.ioreader.peekDelimiterInclusive('\n');
    const size = line.len;
    @memcpy(buffer[0..line.len], line);
    self.ioreader.toss(line.len);
    return self.buffer[0..size];
}

pub fn parse(self: *TextData, allo: Allocator) !void {
    // parse for variables
    while (true) {
        const line: []const u8 = self.nextline(&self.buffer) catch |err| switch (err) {
            error.EndOfStream => break,
            else => return err,
        };
        const line_type = self.determineLineType(line) orelse continue;
        switch (line_type) {
            .flag2_enum_field => {},
            else => {
                if (self.is_enum2) {
                    // close enum
                    var buf: Buffer = .{};
                    const line1 = buf.extends(&.{ "};", end_str });
                    try self.writeToFile(.flag2, line1);
                    self.is_enum2 = false;
                    // remove enum field names
                    var kit = self.enum2_field_names.keyIterator();
                    while (kit.next()) |item| allo.free(item.*);
                    self.enum2_field_names.deinit();
                    self.enum2_field_names = .init(allo);
                    // remove enum field values
                    kit = self.enum2_field_values.keyIterator();
                    while (kit.next()) |item| allo.free(item.*);
                    self.enum2_field_values.deinit();
                    self.enum2_field_values = .init(allo);
                    // write PES
                    const title = self.enum2_title.str();
                    print("Title: {s}\n", .{title});
                    // var buf1: Buffer = .{};
                    // const line2 = buf1.extends(&.{
                    //     "pub const ",
                    //     title,
                    //     "PES = PackedEnumStruct(",
                    //     title,
                    //     ");",
                    //     end_str,
                    // });
                    // try self.writeToFile(.flag2, line2);
                }
            },
        }
        switch (line_type) {
            .inline_fn => try self.processInlineFn(line),
            .extern_fn => try self.processExternFn(line),
            .pfn => try self.processPFN(line),
            // .flag1_enum => {},
            // .flag1_pes => {},
            .flag2_enum_field => try self.processFlag2EnumField(allo, line),
            .flag2_enum_title => try self.processFlag2EnumTitle(line),
            ._opaque => try self.processOpaque(),
            .extern_struct => try self.processExternStruct(line),
            .extern_union => try self.processExternUnion(line),
            .extension_name => try self.processExtensionName(allo, line),
            .spec_version => try self.processSpecVersion(allo, line),
            ._type => try self.processTypes(line),
            inline else => |tag| {
                _ = tag;
                // try self.writeToFile(tag, line);
            }
        }
    }
    try self.writeExtensionNames();
    try self.writeSpecVersions();
}

fn determineLineType(self: *const TextData, line: []const u8) ?Types {
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
    if (isFlag1EnumTitle(newline)) return .flag1_enum_title;
    if (isFlag1EnumField(newline)) return .flag1_enum_field;
    if (isFlag2EnumTitle(newline)) return .flag2_enum_title;
    if (self.isFlag2EnumField(newline)) return .flag2_enum_field;
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

fn isFlag1EnumTitle(line: []const u8) bool {
    const var_name = varName(line, &.{}, &.{});
    const var_value = varValue(line);
    const start = startsWith(u8, var_name, "Vk");
    const end = endsWith(u8, var_value, "VkFlags");
    return start and end;
}

fn isFlag1EnumField(line: []const u8) bool {
    const var_name = varName(line, &.{}, &.{});
    return startsWith(u8, var_name, "enum_Vk") and endsWith(u8, var_name, "FlagBits");
}

fn isFlag2EnumTitle(line: []const u8) bool {
    const var_name = varName(line, &.{}, &.{});
    return endsWith(u8, var_name, "Flags2");
}

fn isFlag2EnumField(self: *const TextData, line: []const u8) bool {
    const var_name = varName(line, &.{}, &.{});
    const vk = startsWith(u8, var_name, "VK_");
    const colon = endsWith(u8, var_name, ":");
    const has_double = indexOf(u8, var_name, "_2_") != null;
    return self.is_enum2 and vk and colon and has_double;
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
    const var_name = line[vk_idx..open_paren_idx];
    var buf1: Buffer = .init(var_name);
    // Create New Var Name
    var buf2: Buffer = .{};
    const var_name1 = buf2.pascalFromSnake(var_name[3..var_name.len]);
    // Copy fn
    {
        const prefix = "pub ";
        const line1 = line[prefix.len..line.len];
        try self.writeToFile(.inline_fn, line1);
    }
    while (true) {
        const line1: []const u8 = self.nextline(&self.buffer) catch unreachable;
        try self.writeToFile(.inline_fn, line1);
        if (startsWith(u8, line1, "}")) break;
    }
    // Create new fn = easier interface
    var buf3: Buffer = .{};
    const line1 = buf3.extends(&.{
        "pub const ",
        var_name1,
        " = ",
        buf1.str(),
        ";",
        end_str,
    });
    try self.writeToFile(.inline_fn, line1);
}

fn processExternFn(self: *TextData, line: []const u8) !void {
    // Remove vk from args + result
    var buf1: Buffer = .init(line);
    const line1 = buf1.remove("Vk");
    // convert arg names to snake
    var buf2: Buffer = .{};
    _ = buf2.argNamesToSnake(line1);
    // remove pub - 1
    const line3 = buf2.removePrefixes(&.{"pub "});
    // extract var name - 2
    var buf3: Buffer = .{};
    const var_name = varName(line3, &.{ "extern ", "fn ", "vk" }, &.{});
    const prefix = "pub const ";
    const line4 = buf3.extends(&.{ prefix, var_name, " = vk", var_name, ";", end_str });
    buf3.buf[prefix.len] = toLower(buf3.buf[prefix.len]);
    // Store both lines
    try self.writeToFile(.extern_fn, line3);
    try self.writeToFile(.extern_fn, line4);
}

fn processPFN(self: *TextData, line: []const u8) !void {
    // Replace Vks
    var buf1: Buffer = .{};
    const line1 = buf1.replaceAndExtend(line, "Vk");
    const line2 = buf1.remove("pub ");
    try self.writeToFile(.pfn, line2);
    // Create custom PFN w/o vk prefix
    var buf2: Buffer = .{};
    const prefix = "pub const PFN_";
    const var_name = varName(line1, &.{ "pub ", "const ", "PFN_", "vk" }, &.{});
    const line3 = buf2.extends(&.{ prefix, var_name, " = PFN_vk", var_name, ";", end_str });
    buf2.buf[prefix.len] = toLower(buf2.buf[prefix.len]);
    try self.writeToFile(.pfn, line3);
}

// fn processFlag1PES(self: *TextData, allo: Allocator, line: []const u8) !void {
//     _ = self;
//     _ = allo;
//     const var_name = varName(line, &.{ "pub ", "const ", "Vk" }, &.{});
//     const var_value = varValue(line);
//
//     var buf: [BUFFER_SIZE]u8 = undefined;
//     try bufPrint(
//         &buf,
//         "pub const {s} = PES({s});{s}",
//         .{ var_name, var_value, end_str },
//     );
//     // try self.writeToFile(.flag1_pes, line);
// }
//
// fn processFlag1Enum(self: *TextData, allo: Allocator, line: []const u8) !void {
//     _ = self;
//     _ = allo;
//     const var_name = varName(line, &.{ "pub ", "const ", "enum_Vk" }, &.{});
//     const var_value = varValue(line);
//
//     var buf: [BUFFER_SIZE]u8 = undefined;
//     const line1 = try bufPrint(
//         &buf,
//         "pub const {s} = enum({s}){{{s}",
//         .{ var_name, var_value, end_str },
//     );
//     _ = line1;
//     // try self.writeToFile(.flag1_enum, line1);
// }

fn processFlag2EnumTitle(self: *TextData, line: []const u8) !void {
    // Parse Flag Name
    const var_name = varName(line, &.{ "pub ", "const ", "Vk" }, &.{"Flags2"});
    // Write Title
    var buf1: Buffer = .{};
    const line1 = buf1.extends(&.{
        "pub const ",
        var_name,
        "2 = enum(u64) {",
        end_str,
    });
    try self.writeToFile(.flag2, line1);
    // Update Flag
    self.is_enum2 = true;
    self.enum2_title.reset();
    _ = self.enum2_title.pascalFromSnake(var_name);
    // Skip Next Line
    _ = try self.nextline(&self.buffer);
}

fn processFlag2EnumField(self: *TextData, allo: Allocator, line: []const u8) !void {
    // get var name
    const var_name = varName(line, &.{ "pub ", "const ", "VK_" }, &.{":"});
    var buf1: Buffer = .init(var_name);
    const lower_var_name = buf1.lower();
    const enum_title = self.enum2_title.str();
    const var_name1 = varName(lower_var_name, &.{ enum_title, "_2_" }, &.{});
    // check if dup
    if (self.enum2_field_names.get(var_name1) != null) {
        return;
    }
    const var_value = varValue(line);
    // check if dup
    if (self.enum2_field_values.get(var_value) != null) {
        return;
    }
    // add to maps
    const dup_var_name = try allo.dupe(u8, var_name1);
    const dup_var_value = try allo.dupe(u8, var_value);
    try self.enum2_field_names.put(dup_var_name, {});
    try self.enum2_field_values.put(dup_var_value, {});
    // write field
    var buf2: Buffer = .{};
    const line1 = buf2.extends(&.{
        "    ",
        var_name1,
        " = ",
        var_value,
        ",",
        end_str,
    });
    try self.writeToFile(.flag2, line1);
}

fn processOpaque(self: *TextData) !void {
    const line1 = self.nextline(&self.buffer) catch unreachable;
    const var_name = varName(line1, &.{ "pub const Vk", "" }, &.{});
    var buf: Buffer = .{};
    const line2 = buf.extends(&.{
        "pub const ",
        var_name,
        " = enum(isize) {",
        end_str,
        "    null = 0,",
        end_str,
        "    _,",
        end_str,
        "};",
        end_str,
    });
    try self.writeToFile(._opaque, line2);
}

fn processExternStruct(self: *TextData, line: []const u8) !void {
    // Convert name to remove struct_Vk
    var buf1: Buffer = .init(line);
    const line1 = buf1.remove("struct_Vk");
    try self.writeToFile(.extern_struct, line1);
    // get var name for s_type
    const var_name = varName(line1, &.{"pub const "}, &.{});
    var buf2: Buffer = .{};
    const snake_name = buf2.snakeFromCamel(var_name);
    while (true) {
        const line2: []const u8 = self.nextline(&self.buffer) catch unreachable;
        if (startsWith(u8, line, "}")) {
            try self.writeToFile(.extern_struct, line2);
            break;
        }
        // idxs
        const colon_idx = indexOfScalar(u8, line2, ':').?;
        const name_idx = lastIndexOfScalar(u8, line2[0..colon_idx], ' ').? + 1;
        const eql_idx = indexOfScalar(u8, line2, '=').?;
        // assertions
        std.debug.assert(name_idx < colon_idx);
        std.debug.assert(colon_idx < eql_idx);
        // posiitons
        // copy field line spacing
        var buf3: Buffer = .{};
        _ = buf3.fieldNameToSnake(line2);
        _ = buf3.remove("struct_Vk");
        _ = buf3.remove("union_Vk");
        _ = buf3.remove("Vk");
        const snake_field_name = buf3.fieldName();
        // If Structure Type - write structure type
        // Else - write what it was
        const line5 = if (eql(u8, snake_field_name, "s_type")) //
            buf3.replaceFieldValue(&.{ " = .", snake_name, ",", end_str })
        else if (eql(u8, snake_field_name, "p_next")) //
            buf3.replaceFieldValue(&.{ " = null,", end_str })
        else //
            buf3.str();
        try self.writeToFile(.extern_struct, line5);
    }
}

fn processExternUnion(self: *TextData, line: []const u8) !void {
    var buf1: Buffer = .{};
    const var_name = varName(line, &.{ "pub ", "const ", "union_Vk" }, &.{});
    const line1 = buf1.extends(&.{ "pub const ", var_name, " = extern union {", end_str });
    try self.writeToFile(.extern_union, line1);
    while (true) {
        const line2 = self.nextline(&self.buffer) catch unreachable;
        if (startsWith(u8, line, "}")) {
            try self.writeToFile(.extern_union, line2);
            break;
        }

        var buf2: Buffer = .{};
        _ = buf2.fieldNameToSnake(line2);
        const line4 = buf2.remove("Vk");
        try self.writeToFile(.extern_union, line4);
    }
}

fn processExtensionName(
    self: *TextData,
    allo: Allocator,
    line: []const u8,
) !void {
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
    var buf: Buffer = .{};
    const line1 = if (!isDigit(new_var_name[0])) //
        buf.extends(&.{
            "pub const ",
            new_var_name,
            ": [*:0]const u8 = ",
            var_value,
            ";",
            end_str,
        })
    else //
        buf.extends(&.{
            "pub const @\"",
            new_var_name,
            "\": [*:0]const u8 = ",
            var_value,
            ";",
            end_str,
        });
    const line2 = try allo.dupe(u8, line1);
    try self.extension_names.append(allo, line2);
}

fn processSpecVersion(
    self: *TextData,
    allo: Allocator,
    line: []const u8,
) !void {
    // Grab name + value + type
    const var_name = varName(line, &.{ "pub ", "const ", "VK_", "KHR_" }, &.{"_SPEC_VERSION"});
    const var_value = varValue(line);
    if (lastIndexOf(u8, line, "@as") == null) return;
    const last_open_paren_idx = lastIndexOfScalar(u8, line, '(').?;
    const comma_idx = lastIndexOfScalar(u8, line, ',').?;
    const var_type = line[last_open_paren_idx + 1 .. comma_idx];
    // convert to lower
    var buf1: [BUFFER_SIZE]u8 = undefined;
    const new_var_name = lowerString(&buf1, var_name);
    // convert to line
    var buf: Buffer = .{};
    const line1 = if (!isDigit(new_var_name[0])) //
        buf.extends(&.{
            "pub const ",
            new_var_name,
            ": ",
            var_type,
            " = ",
            var_value,
            ";",
            end_str,
        })
    else //
        buf.extends(&.{
            "pub const @\"",
            new_var_name,
            "\": ",
            var_type,
            " = ",
            var_value,
            ";",
            end_str,
        });
    const line2 = try allo.dupe(u8, line1);
    try self.spec_versions.append(allo, line2);
}

fn processTypes(self: *TextData, line: []const u8) !void {
    // get name + value
    const var_name = varName(line, &.{ "pub ", "const ", "Vk" }, &.{});
    const var_value = varValue(line);
    // create line
    var buf: Buffer = .{};
    const line1 = if (!eql(u8, var_name, "Bool32")) //
        buf.extends(&.{
            "pub const ",
            var_name,
            " = ",
            var_value,
            ";",
            end_str,
        })
    else
        buf.extends(&.{
            "pub const ",
            var_name,
            " = enum(u32) {",
            end_str,
            "    false = 0,",
            end_str,
            "    true = 1,",
            end_str,
            "};",
            end_str,
        });
    try self.writeToFile(._type, line1);
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

fn writeExtensionNames(self: *TextData) !void {
    try self.writeToFile(.extension_name, "pub const ExtensionName = struct {");
    try self.writeToFile(.extension_name, end_str);
    for (self.extension_names.items) |extension_name| {
        try self.writeToFile(.extension_name, extension_name);
    }
    try self.writeToFile(.extension_name, "};");
    try self.writeToFile(.extension_name, end_str);
}

fn writeSpecVersions(self: *TextData) !void {
    try self.writeToFile(.spec_version, "pub const SpecVersion = struct {");
    try self.writeToFile(.spec_version, end_str);
    for (self.spec_versions.items) |spec_version| {
        try self.writeToFile(.spec_version, spec_version);
    }
    try self.writeToFile(.spec_version, "};");
    try self.writeToFile(.spec_version, end_str);
}
