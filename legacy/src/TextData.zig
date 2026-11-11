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
// ascii
const allocLowerString = std.ascii.allocLowerString;
const lowerString = std.ascii.lowerString;
const toLower = std.ascii.toLower;
const isLower = std.ascii.isLower;
const isUpper = std.ascii.isUpper;
const isDigit = std.ascii.isDigit;
// debug
const print = std.debug.print;
// Text Processing
const modCwd = @import("TextProcessing.zig").modCwd;
const trimLeft = @import("TextProcessing.zig").trimLeft;
const trimRight = @import("TextProcessing.zig").trimRight;
const trimLine = @import("TextProcessing.zig").trimLine;
const varName = @import("TextProcessing.zig").varName;
const varValue = @import("TextProcessing.zig").varValue;
const varType = @import("TextProcessing.zig").varTypePreEql;
const isKeyword = @import("TextProcessing.zig").isKeyword;
// Custom Data Types
const end_str = switch (@import("builtin").os.tag) {
    .windows => "\r\n",
    else => "\n",
};
const VarData = @import("VarData.zig");
const LineTypes = @import("Types.zig").LineTypes;
const write_filenames = std.meta.fieldNames(LineTypes);
const DescTypes = @import("Types.zig").DescTypes;
const EnumField = @import("EnumField.zig");
const Buffer = @import("Buffer.zig");
const BUFFER_SIZE = @import("constants.zig").BUFFER_SIZE;
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
// Flag1
prev_enum1_titles: std.StringHashMap(void),
enum_fields: std.ArrayList(VarData),
enum_field_names: std.StringHashMap(void),
enum_field_values: std.StringHashMap(void),
// Flag2
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
    // flag1
    self.prev_enum1_titles = .init(allo);
    self.enum_fields = try .initCapacity(allo, 8);
    self.enum_field_names = .init(allo);
    self.enum_field_values = .init(allo);
    // flag2
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
    // flag1
    var kit = self.prev_enum1_titles.keyIterator();
    while (kit.next()) |item| allo.free(item.*);
    self.prev_enum1_titles.deinit();
    self.enum_field_names.deinit();
    self.enum_field_values.deinit();
    for (self.enum_fields.items) |item| {
        allo.free(item.name);
        allo.free(item.value);
    }
    self.enum_fields.deinit(allo);
    // flag2
    // field names
    kit = self.enum2_field_names.keyIterator();
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
    try self.writeHeader();
    switch (@import("builtin").os.tag) {
        .windows => try self.writeWindowsFns(),
        .macos => try self.writeMacosFns(),
        .linux => try self.writeLinuxFns(),
        else => unreachable,
    }
    // parse for variables
    while (true) {
        // get line
        const line: []const u8 = self.nextline(&self.buffer) catch |err| switch (err) {
            error.EndOfStream => break,
            else => return err,
        };
        // skips
        // if (skipExcept(line, &.{
        //     "pub const struct_VkRect2D = extern struct {",
        // })) continue;
        // line type
        const line_type = determineLineType(line) orelse continue;
        // close enums
        switch (line_type) {
            .flag1, .flag2 => {
                const desc_type = determineDescType(line, line_type).?;
                switch (desc_type) {
                    .field => {},
                    .title => if (self.is_enum2) try self.writeCloseEnum(allo, .base),
                }
            },
            else => if (self.is_enum2) try self.writeCloseEnum(allo, .base),
        }
        // process line
        switch (line_type) {
            .inline_fn => try self.processInlineFn(line, .base),
            .extern_fn => try self.processExternFn(line, .base),
            .pfn => try self.processPFN(line, .base),
            .flag1 => {
                const desc_type = determineDescType(line, line_type).?;
                // print("Desc Type: {s}\n", .{@tagName(desc_type)});
                switch (desc_type) {
                    .title => try self.processFlag1EnumTitle(allo, line, .base),
                    .field => try self.processFlag1EnumField(allo, line),
                }
            },
            .flag2 => {
                const desc_type = determineDescType(line, line_type).?;
                switch (desc_type) {
                    .field => try self.processFlag2EnumField(allo, line, .base),
                    .title => try self.processFlag2EnumTitle(line, .base),
                }
            },
            ._opaque => try self.processOpaque(.base),
            .extern_struct => try self.processExternStruct(line, .base),
            .extern_union => try self.processExternUnion(line, .base),
            .extension_name => try self.processExtensionName(allo, line),
            .spec_version => try self.processSpecVersion(allo, line),
            ._type => try self.processTypes(line, .base),
            else => continue,
        }
    }
    // write exts + specs
    try self.writeExtensionNames(.base);
    try self.writeSpecVersions(.base);
}

fn determineLineType(line: []const u8) ?LineTypes {
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
    if (isFlag1EnumTitle(newline)) return .flag1;
    if (isFlag1EnumField(newline)) return .flag1;
    if (isFlag2EnumTitle(newline)) return .flag2;
    if (isFlag2EnumField(newline)) return .flag2;
    if (isOpaque(newline)) return ._opaque;
    if (isExternStruct(newline)) return .extern_struct;
    if (isExternUnion(newline)) return .extern_union;
    if (isExtensionName(newline)) return .extension_name;
    if (isSpecVersion(newline)) return .spec_version;
    if (isType(newline)) return ._type;
    // base
    return null;
}

fn determineDescType(line: []const u8, line_type: LineTypes) ?DescTypes {
    switch (line_type) {
        .flag1 => {
            var newline = line;
            newline = trimLeft(newline, &.{ "pub ", "" });
            newline = trimLeft(newline, &.{ "const ", "" });
            if (isFlag1EnumField(newline)) return .field;
            if (isFlag1EnumTitle(newline)) return .title;
            unreachable;
        },
        .flag2 => {
            var newline = line;
            newline = trimLeft(newline, &.{ "pub ", "" });
            newline = trimLeft(newline, &.{ "const ", "" });
            if (isFlag2EnumField(newline)) return .field;
            if (isFlag2EnumTitle(newline)) return .title;
            unreachable;
        },
        else => return null,
    }
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
    // var name
    const var_name = varName(line, &.{}, &.{});
    const vk_start = startsWith(u8, var_name, "enum_Vk");
    const std_start = startsWith(u8, var_name, "enum_Std");
    if (!(vk_start or std_start)) return false;
    if (indexOfScalar(u8, var_name, '2')) |dub_idx| {
        if (!isDigit(var_name[dub_idx - 1]) and !isDigit(var_name[dub_idx + 1])) return false;
    }
    // default
    return true;
}

fn isFlag1EnumField(line: []const u8) bool {
    // var name
    const var_name = varName(line, &.{}, &.{});
    const vk_start = startsWith(u8, var_name, "VK_");
    const std_start = startsWith(u8, var_name, "STD_");
    if (!(vk_start or std_start)) return false;
    if (indexOfScalar(u8, var_name, ':') == null) return false;
    if (indexOfScalar(u8, var_name, '2')) |dub_idx| {
        const dub1 = isDigit(var_name[dub_idx - 1]);
        const dub2 = isDigit(var_name[dub_idx + 1]);
        if (!dub1 and !dub2) return false;
    }
    // var type
    const var_type = varType(line);
    if (eql(u8, var_type, "c_uint")) return true;
    if (eql(u8, var_type, "c_int")) return true;
    // default
    return false;
}

fn isFlag2EnumTitle(line: []const u8) bool {
    const var_name = varName(line, &.{}, &.{});
    return endsWith(u8, var_name, "Flags2");
}

fn isFlag2EnumField(line: []const u8) bool {
    const var_name = varName(line, &.{}, &.{});
    const vk_start = startsWith(u8, var_name, "VK_");
    const std_start = startsWith(u8, var_name, "STD_");
    if (!(vk_start or std_start)) return false;
    if (!endsWith(u8, var_name, ":")) return false;
    const var_type = varType(line);
    if (endsWith(u8, var_type, "2")) return true;
    return false;
}

fn isOpaque(line: []const u8) bool {
    const vk_start = startsWith(u8, line, "struct_Vk");
    const std_start = startsWith(u8, line, "struct_Std");
    if (!vk_start and !std_start) return false;
    if (!endsWith(u8, trimLine(line), "opaque {};")) return false;
    return true;
}

fn isExternStruct(line: []const u8) bool {
    const vk_start = startsWith(u8, line, "struct_Vk");
    const std_start = startsWith(u8, line, "struct_Std");
    if (!vk_start and !std_start) return false;
    if (!endsWith(u8, trimLine(line), "extern struct {")) return false;
    return true;
}

fn isExternUnion(line: []const u8) bool {
    if (!startsWith(u8, line, "union_Vk")) return false;
    if (!endsWith(u8, trimLine(line), "extern union {")) return false;
    return true;
}

fn isExtensionName(line: []const u8) bool {
    const var_name = varName(line, &.{}, &.{});
    if (!startsWith(u8, var_name, "VK_")) return false;
    if (!endsWith(u8, var_name, "EXTENSION_NAME")) return false;
    return true;
}

fn isSpecVersion(line: []const u8) bool {
    const var_name = varName(line, &.{}, &.{});
    if (!startsWith(u8, var_name, "VK_")) return false;
    if (!endsWith(u8, var_name, "SPEC_VERSION")) return false;
    return true;
}

fn isType(line: []const u8) bool {
    const var_name = varName(line, &.{}, &.{});
    const var_value = varValue(line);
    const bad_var_values = [_][]const u8{
        "enum_Vk",
        "struct_Vk",
        "union_Vk",
        // "?*",
        "__",
    };
    for (bad_var_values) |bad_var_value| //
        if (startsWith(u8, var_value, bad_var_value)) return false;
    return startsWith(u8, var_name, "Vk");
}

fn processInlineFn(
    self: *TextData,
    line: []const u8,
    comptime tag: LineTypes,
) !void {
    // Get Old Var Name - No Vk
    const vk_idx = indexOf(u8, line, "VK_").?;
    const open_paren_idx = indexOfScalar(u8, line, '(').?;
    const var_name = line[vk_idx..open_paren_idx];
    var buf1: Buffer = .init(var_name);
    // Create New Var Name
    var buf2: Buffer = .{};
    const var_name1 = buf2.camelFromSnake(var_name[3..var_name.len]);
    // Copy fn
    {
        const prefix = "pub ";
        const line1 = line[prefix.len..line.len];
        try self.writeToFile(tag, line1);
    }
    while (true) {
        const line1: []const u8 = self.nextline(&self.buffer) catch unreachable;
        try self.writeToFile(tag, line1);
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
    try self.writeToFile(tag, line1);
}

fn processExternFn(
    self: *TextData,
    line: []const u8,
    comptime tag: LineTypes,
) !void {
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
    try self.writeToFile(tag, line3);
    try self.writeToFile(tag, line4);
}

fn processPFN(
    self: *TextData,
    line: []const u8,
    comptime tag: LineTypes,
) !void {
    // Replace Vks
    var buf1: Buffer = .{};
    const line1 = buf1.replaceAndExtend(line, "Vk");
    const line2 = buf1.remove("pub ");
    try self.writeToFile(tag, line2);
    // Create custom PFN w/o vk prefix
    var buf2: Buffer = .{};
    const prefix = "pub const PFN_";
    const var_name = varName(line1, &.{ "pub ", "const ", "PFN_", "vk" }, &.{});
    const line3 = buf2.extends(&.{
        prefix,
        var_name,
        " = PFN_vk",
        var_name,
        ";",
        end_str,
    });
    buf2.buf[prefix.len] = toLower(buf2.buf[prefix.len]);
    try self.writeToFile(tag, line3);
}

fn processFlag1EnumTitle(
    self: *TextData,
    allo: Allocator,
    line: []const u8,
    comptime tag: LineTypes,
) !void {
    // get var name
    var var_name: []const u8 = undefined;
    if (indexOf(u8, line, "enum_Vk") != null) {
        var_name = varName(line, &.{ "pub ", "const ", "enum_Vk" }, &.{});
    } else if (indexOf(u8, line, "enum_Std") != null) {
        var_name = varName(line, &.{ "pub ", "const ", "enum_Std" }, &.{});
    } else {
        print("Line: {s}", .{line});
        unreachable;
    }
    // get var value
    var buf1: Buffer = .{};
    const snake_var_name = buf1.snakeFromCamel(var_name);
    const var_value = varValue(line);
    const var_value1 = if (eql(u8, var_value, "c_uint")) "u32" //
        else if (eql(u8, var_value, "c_int")) "i32" //
        else unreachable;
    // Write Title
    var buf2: Buffer = .{};
    const line1 = buf2.extends(&.{
        "pub const ",
        var_name,
        " = enum(",
        var_value1,
        ") {",
        end_str,
    });
    try self.writeToFile(tag, line1);
    // write fields
    for (self.enum_fields.items) |field| {
        var buf3: Buffer = .{};
        const var_name1 = buf3.removeOverlaps(snake_var_name, field.name);
        var buf4: Buffer = .{};
        buf4.extend("    ");
        if (isDigit(var_name1[0]) or isKeyword(var_name1)) {
            _ = buf4.extends(&.{ "@\"", var_name1, "\"" });
        } else {
            _ = buf4.extend(var_name1);
        }
        const line2 = buf4.extends(&.{
            " = ",
            field.value,
            ",",
            end_str,
        });
        try self.writeToFile(tag, line2);
    }
    // close enum
    buf2.reset();
    const line3 = buf2.extends(&.{ "};", end_str });
    try self.writeToFile(tag, line3);
    // write PES
    buf2.reset();
    var has_khr: bool = false;
    const var_name1 = blk: {
        var var_name1: []const u8 = undefined;
        if (endsWith(u8, var_name, "FlagBitsKHR")) {
            has_khr = true;
            var_name1 = varName(var_name, &.{}, &.{"FlagBitsKHR"});
        } else if (endsWith(u8, var_name, "FlagBits")) {
            var_name1 = varName(var_name, &.{}, &.{"FlagBits"});
        } else if (endsWith(u8, var_name, "FlagsKHR")) {
            has_khr = true;
            var_name1 = varName(var_name, &.{}, &.{"FlagsKHR"});
        } else {
            var_name1 = varName(var_name, &.{}, &.{"Flags"});
        }
        break :blk var_name1;
    };
    const var_name2: []const u8 = blk: {
        var var_name2: []const u8 = undefined;
        if (has_khr) {
            var_name2 = buf2.extends(&.{ var_name1, "FlagsKHR" });
        } else {
            var_name2 = buf2.extends(&.{ var_name1, "Flags" });
        }
        break :blk var_name2;
    };
    const dup_var_name2 = try allo.dupe(u8, var_name2);
    try self.prev_enum1_titles.putNoClobber(dup_var_name2, {});
    buf2.reset();
    const line4 = buf2.extends(&.{
        "pub const ",
        dup_var_name2,
        " = PES(",
        var_name,
        ");",
        end_str,
    });
    try self.writeToFile(tag, line4);
    // cleanup mem
    for (self.enum_fields.items) |field| {
        allo.free(field.name);
        allo.free(field.value);
    }
    self.enum_fields.deinit(allo);
    self.enum_fields = try .initCapacity(allo, 8);
    // deinit
    self.enum_field_names.deinit();
    self.enum_field_values.deinit();
    // re-alloc
    self.enum_field_names = .init(allo);
    self.enum_field_values = .init(allo);
}

fn processFlag1EnumField(
    self: *TextData,
    allo: Allocator,
    line: []const u8,
) !void {
    var var_name: []const u8 = undefined;
    if (indexOf(u8, line, "VK_") != null) {
        var_name = varName(line, &.{ "pub ", "const ", "VK_" }, &.{":"});
    } else if (indexOf(u8, line, "STD_") != null) {
        var_name = varName(line, &.{ "pub ", "const ", "STD_" }, &.{":"});
    } else {
        print("Line: {s}", .{line});
        unreachable;
    }
    var buf: Buffer = .init(var_name);
    const var_name1 = buf.lower();
    const var_value = varValue(line);
    // check if it exists
    if (self.enum_field_names.get(var_name1) != null) return;
    if (self.enum_field_values.get(var_value) != null) return;
    // duplicate
    const dup_name = try allo.dupe(u8, var_name1);
    const dup_value = try allo.dupe(u8, var_value);
    // add to string maps
    try self.enum_field_names.put(dup_name, {});
    try self.enum_field_values.put(dup_value, {});
    // add to arraylist
    try self.enum_fields.append(allo, .{
        .name = dup_name,
        .value = dup_value,
    });
}

fn processFlag2EnumTitle(
    self: *TextData,
    line: []const u8,
    comptime tag: LineTypes,
) !void {
    // Parse Flag Name
    const var_name = varName(line, &.{ "pub ", "const ", "Vk" }, &.{"Flags2"});
    // Write Title
    var buf1: Buffer = .{};
    const line1 = buf1.extends(&.{
        "pub const ",
        var_name,
        "FlagBits2 = enum(u64) {",
        end_str,
    });
    try self.writeToFile(tag, line1);
    // Update Flag
    self.is_enum2 = true;
    self.enum2_title.reset();
    _ = self.enum2_title.snakeFromCamel(var_name);
    // Skip Next Line
    _ = try self.nextline(&self.buffer);
}

fn processFlag2EnumField(
    self: *TextData,
    allo: Allocator,
    line: []const u8,
    comptime tag: LineTypes,
) !void {
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
    try self.writeToFile(tag, line1);
}

fn processOpaque(
    self: *TextData,
    comptime tag: LineTypes,
) !void {
    const line1 = self.nextline(&self.buffer) catch unreachable;
    var var_name: []const u8 = undefined;
    if (startsWith(u8, line1, "pub const Vk")) {
        var_name = varName(line1, &.{"pub const Vk"}, &.{});
    } else if (startsWith(u8, line1, "pub const Std")) {
        var_name = varName(line1, &.{"pub const Std"}, &.{});
    }
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
    try self.writeToFile(tag, line2);
}

fn processExternStruct(
    self: *TextData,
    line: []const u8,
    comptime tag: LineTypes,
) !void {
    // Convert name to remove struct_Vk
    var buf1: Buffer = .init(line);
    _ = buf1.remove("struct_Vk");
    const line1 = buf1.remove("struct_Std");
    try self.writeToFile(tag, line1);
    // get var name for s_type
    const var_name = varName(line1, &.{"pub const "}, &.{});
    var buf2: Buffer = .{};
    const snake_name = buf2.snakeFromCamel(var_name);
    while (true) {
        const line2: []const u8 = self.nextline(&self.buffer) catch unreachable;
        if (startsWith(u8, line, "}")) {
            try self.writeToFile(tag, line2);
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
        // this is wrong
        var buf3: Buffer = .{};
        _ = buf3.fieldNameToSnake(line2);
        _ = buf3.removePrefixesFromStructType(&.{
            "union_Vk",
            "struct_Vk",
            "Vk",
            "Std",
        });
        _ = buf3.removePrefixesFromStructValue(&.{ "Vk", "Std" });
        const snake_field_name = buf3.fieldName();
        // If Structure Type - write structure type
        // Else - write what it was
        const line5 = if (eql(u8, snake_field_name, "s_type")) //
            buf3.replaceFieldValue(&.{ " = .", snake_name, ",", end_str })
        else if (eql(u8, snake_field_name, "p_next")) //
            buf3.replaceFieldValue(&.{ " = null,", end_str })
        else //
            buf3.str();
        try self.writeToFile(tag, line5);
    }
}

fn processExternUnion(
    self: *TextData,
    line: []const u8,
    comptime tag: LineTypes,
) !void {
    var buf1: Buffer = .{};
    const var_name = varName(line, &.{ "pub ", "const ", "union_Vk" }, &.{});
    const line1 = buf1.extends(&.{
        "pub const ",
        var_name,
        " = extern union {",
        end_str,
    });
    try self.writeToFile(tag, line1);
    while (true) {
        const line2 = self.nextline(&self.buffer) catch unreachable;
        if (startsWith(u8, line, "}")) {
            try self.writeToFile(tag, line2);
            break;
        }

        var buf2: Buffer = .{};
        _ = buf2.fieldNameToSnake(line2);
        const line4 = buf2.remove("Vk");
        try self.writeToFile(tag, line4);
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
    const var_name = varName(
        line,
        &.{ "pub ", "const ", "VK_", "KHR_" },
        &.{"_SPEC_VERSION"},
    );
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

fn processTypes(
    self: *TextData,
    line: []const u8,
    comptime tag: LineTypes,
) !void {
    // get name + value
    const var_name = varName(line, &.{ "pub ", "const ", "Vk" }, &.{});
    const var_value = varValue(line);
    // create line
    var buf: Buffer = .{};
    var line1: []const u8 = undefined;
    if (!eql(u8, var_name, "Bool32")) { //
        const var_value1 = if (startsWith(u8, var_value, "Vk")) //
            trimLeft(var_value, &.{"Vk"}) //
        else //
            var_value;
        if (self.prev_enum1_titles.get(var_name) != null) return;
        line1 = buf.extends(&.{
            "pub const ",
            var_name,
            " = ",
            var_value1,
            ";",
            end_str,
        });
    } else {
        line1 = buf.extends(&.{
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
    }
    try self.writeToFile(tag, line1);
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

fn writeToFile(
    self: *TextData,
    comptime filename: LineTypes,
    line: []const u8,
) !void {
    const idx: usize = std.meta.fieldIndex(LineTypes, @tagName(filename)).?;
    _ = try self.write_files[idx].write(line);
}

fn writeExtensionNames(
    self: *TextData,
    comptime tag: LineTypes,
) !void {
    try self.writeToFile(tag, "pub const ExtensionName = struct {");
    try self.writeToFile(tag, end_str);
    for (self.extension_names.items) |extension_name| {
        try self.writeToFile(tag, "    "); // spacing
        try self.writeToFile(tag, extension_name);
    }
    try self.writeToFile(tag, "};");
    try self.writeToFile(tag, end_str);
}

fn writeSpecVersions(
    self: *TextData,
    comptime tag: LineTypes,
) !void {
    try self.writeToFile(tag, "pub const SpecVersion = struct {");
    try self.writeToFile(tag, end_str);
    for (self.spec_versions.items) |spec_version| {
        try self.writeToFile(tag, "    ");
        try self.writeToFile(tag, spec_version);
    }
    try self.writeToFile(tag, "};");
    try self.writeToFile(tag, end_str);
}

fn writeCloseEnum(
    self: *TextData,
    allo: Allocator,
    comptime tag: LineTypes,
) !void {
    // close enum
    var buf: Buffer = .{};
    const line1 = buf.extends(&.{ "};", end_str });
    try self.writeToFile(tag, line1);
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
    // extract title
    const title = self.enum2_title.str();
    var buf1: Buffer = .{};
    const title2 = buf1.pascalFromSnake(title);
    var buf2: Buffer = .{};
    // write
    const line2 = buf2.extends(&.{
        "pub const ",
        title2,
        "Flags2 = PES(",
        title2,
        "FlagBits2);",
        end_str,
    });
    try self.writeToFile(tag, line2);
}

fn skipExcept(line: []const u8, args: []const []const u8) bool {
    for (args) |arg| {
        if (startsWith(u8, line, arg)) return false;
    } else return true;
}

fn writeHeader(self: *TextData) !void {
    var buf: Buffer = .{};
    const line = buf.extends(&.{
        "pub const PES = @import(\"PackedEnumStruct\");",
        end_str,
    });
    try self.writeToFile(.base, line);
}

fn writeWindowsFns(self: *TextData) !void {
    var buf: Buffer = .{};
    const lines = [_][]const u8{
        "pub const HINSTANCE = @import(\"windows.zig\").HINSTANCE;",
        "pub const HANDLE = @import(\"windows.zig\").HANDLE;",
        "pub const SECURITY_ATTRIBUTES = @import(\"windows.zig\").SECURITY_ATTRIBUTES;",
        "pub const HMONITOR = @import(\"windows.zig\").HMONITOR;",
        "pub const HWND = @import(\"windows.zig\").HWND;",
        "pub const LPCWSTR = @import(\"windows.zig\").LPCWSTR;",
        "pub const DWORD = @import(\"windows.zig\").DWORD;",
    };
    for (lines) |line| {
        const newline = buf.extends(&.{ line, end_str });
        try self.writeToFile(.base, newline);
        buf.reset();
    }
}

fn writeMacosFns(self: *TextData) !void {
    _ = self;
    // var buf: Buffer = .{};
    // const lines = [_][]const u8 {
    //     "pub const ",
    // };
    // for (lines) |line| {
    //     _ = buf.extends(&.{});
    // }
}

fn writeLinuxFns(self: *TextData) !void {
    _ = self;
}
