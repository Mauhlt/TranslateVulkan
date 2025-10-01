const std = @import("std");
// ascii
const toUpper = std.ascii.toUpper;
const toLower = std.ascii.toLower;
const isUpper = std.ascii.isUpper;
const isLower = std.ascii.isLower;
const isDigit = std.ascii.isDigit;
const lowerString = std.ascii.lowerString;
// mem
const replace = std.mem.replace;
const startsWith = std.mem.startsWith;
const endsWith = std.mem.endsWith;
const eql = std.mem.eql;
const indexOfScalar = std.mem.indexOfScalar;
const indexOf = std.mem.indexOf;
const lastIndexOfScalar = std.mem.lastIndexOfScalar;
const splitScalar = std.mem.splitScalar;
// fmt
const bufPrint = std.fmt.bufPrint;
// debug
const assert = std.debug.assert;
const print = std.debug.print;
//
const varName = @import("TextProcessing.zig").varName;
// constants
const BUFFER_SIZE: u16 = 2048;
const Buffer = @This();
// fields
buf: [BUFFER_SIZE]u8 = undefined,
start: usize = 0,
end: usize = 0,
// methods
pub fn init(line: []const u8) Buffer {
    assert(line.len < BUFFER_SIZE);
    var self: Buffer = .{};
    self.copy(line);
    return self;
}

pub fn reset(self: *Buffer) void {
    self.start = 0;
    self.end = 0;
}

pub fn str(buf: *const Buffer) []const u8 {
    return buf.buf[0..buf.end];
}

pub fn copy(self: *Buffer, phrase: []const u8) void {
    assert(self.end + phrase.len < BUFFER_SIZE);
    self.start = self.end;
    self.end += phrase.len;
    @memcpy(self.buf[self.start..self.end], phrase);
}

pub fn remove(
    buf: *Buffer,
    needle: []const u8,
) []const u8 {
    const line = buf.str();
    const len = line.len;
    const n_replaces = replace(u8, line, needle, "", &buf.buf);
    buf.end = len - (n_replaces * needle.len);
    return buf.str();
}

pub fn removePrefixes(buf: *Buffer, names: []const []const u8) []const u8 {
    for (names) |name| {
        if (startsWith(u8, buf.str(), name)) {
            for (name.len..buf.end) |i| //
                buf.buf[i - name.len] = buf.buf[i];
            buf.end -= name.len;
        }
    }
    return buf.str();
}

pub fn removeSuffixes(buf: *Buffer, names: []const []const u8) []const u8 {
    for (names) |name| {
        if (endsWith(u8, buf.str(), name)) {
            buf.end -= name.len;
        }
    }
    return buf.str();
}

pub fn pascalFromSnake(buf: *Buffer, name: []const u8) []const u8 {
    assert(buf.end + name.len < BUFFER_SIZE);
    var i: usize = buf.end;
    buf.buf[i] = toLower(name[i]);
    i += 1;
    for (
        name[0 .. name.len - 1],
        name[1..name.len],
    ) |ch1, ch2| {
        switch (ch2) {
            '_' => continue,
            else => {},
        }
        buf.buf[i] = switch (ch1) {
            '_' => toUpper(ch2),
            else => toLower(ch2),
        };
        i += 1;
    }
    buf.end = i;
    return buf.str();
}

pub fn snakeFromCamel(buf: *Buffer, name: []const u8) []const u8 {
    std.debug.assert(buf.start + name.len < BUFFER_SIZE);
    buf.buf[buf.start] = toLower(name[0]);
    buf.start += 1;
    var n_nums: usize = 0;
    for (1..name.len) |j| {
        const ch1 = name[j - 1];
        const ch2 = name[j];
        n_nums += @intFromBool(isDigit(ch1));
        n_nums -= @intFromBool(!isDigit(ch1)) * @intFromBool(n_nums > 1);
        const is_lower_upper = isLower(ch1) and isUpper(ch2);
        const is_2d = ch1 == '2' and ch2 == 'D';
        const is_3d = ch1 == '3' and ch2 == 'D';
        const is_multi_num = n_nums > 1 and isUpper(ch2);
        if (is_lower_upper or is_2d or is_3d or is_multi_num) {
            buf.buf[buf.start] = '_';
            buf.start += 1;
        }
        buf.buf[buf.start] = toLower(ch2);
        buf.start += 1;
    }
    buf.end = buf.start;
    buf.start = 0;
    return buf.str();
}

pub fn extend(buf: *Buffer, line: []const u8) void {
    std.debug.assert(buf.end + line.len < BUFFER_SIZE);
    buf.start = buf.end;
    buf.end += line.len;
    @memcpy(buf.buf[buf.start..buf.end], line);
}

pub fn extends(buf: *Buffer, lines: []const []const u8) []const u8 {
    for (lines) |line| buf.extend(line);
    return buf.str();
}

pub fn fieldNameToSnake(buf: *Buffer, line: []const u8) []const u8 {
    // idxs
    const colon_idx = indexOfScalar(u8, line, ':').?;
    const space_idx = lastIndexOfScalar(u8, line[0..colon_idx], ' ').? + 1;
    // add spacing
    const spacing = line[0..space_idx];
    buf.copy(spacing);
    // convert field name to snake
    const field_name = line[space_idx..colon_idx];
    var buf1: Buffer = .{};
    const snake_name = buf1.snakeFromCamel(field_name);
    buf.extend(snake_name);
    // field value
    const field_value = line[colon_idx..line.len];
    buf.extend(field_value);
    // return new field line
    return buf.str();
}

pub fn argNamesToSnake(buf: *Buffer, line: []const u8) []const u8 {
    // get paren idxs
    const open_paren_idx = indexOfScalar(u8, line, '(').?;
    const close_paren_idx = lastIndexOfScalar(u8, line, ')').?;
    // pre paren
    const pre_paren_line = line[0 .. open_paren_idx + 1];
    buf.copy(pre_paren_line);
    buf.start = buf.end + 1;
    // paren
    const paren_line = line[open_paren_idx + 1 .. close_paren_idx];
    var n_commas: usize = std.mem.count(u8, paren_line, ",");
    var it = splitScalar(u8, paren_line, ',');
    while (it.next()) |item| {
        // get arg name
        const colon_idx = indexOfScalar(u8, item, ':').?;
        const arg_name = item[0..colon_idx];
        const arg_type = item[colon_idx..item.len];
        // convert to snake
        var buf1: Buffer = .{};
        const arg_name_snake = buf1.snakeFromCamel(arg_name);
        _ = buf.extends(&.{ arg_name_snake, arg_type });
        if (n_commas > 0) {
            buf.extend(", ");
            n_commas -= 1;
        }
    }
    // post paren
    const post_paren_line = line[close_paren_idx..line.len];
    buf.extend(post_paren_line);
    // return new line
    return buf.str();
}

pub fn removePrefixFromFnName(
    buf: *Buffer,
    line: []const u8,
    prefix: []const u8,
) []const u8 {
    const open_paren_idx = indexOfScalar(u8, line, '(').?;
    const space_idx = lastIndexOfScalar(u8, line[0..open_paren_idx], ' ').?;
    // copy pre-fn name
    const line1 = line[0 .. space_idx + 1];
    buf.copy(line1);
    // get var name
    const var_name = varName(line, &.{ line1, prefix }, &.{});
    buf.extend(var_name);
    buf.buf[buf.end - var_name.len] = toLower(buf.buf[buf.end - var_name.len]);
    // replace with new name
    const rest = line[open_paren_idx..line.len];
    buf.extend(rest);
    // return rest
    return buf.str();
}

pub fn replaceAndExtend(
    buf: *Buffer,
    line: []const u8,
    prefix: []const u8,
) []const u8 {
    const rep_sz = replace(u8, line, prefix, "", buf.buf[buf.end..BUFFER_SIZE]);
    buf.end = line.len - (rep_sz * prefix.len);
    return buf.str();
}

pub fn removePrefixFromArgs(
    buf: *Buffer,
    line: []const u8,
    prefix: []const u8,
) []const u8 {
    // idxs
    const open_paren_idx = indexOfScalar(u8, line, '(').?;
    const close_paren_idx = lastIndexOfScalar(u8, line, ')').?;
    // copy before parens
    buf.copy(line[0 .. open_paren_idx + 1]);
    // replace middle
    const args = line[open_paren_idx + 1 .. close_paren_idx];
    _ = buf.replaceAndExtend(args, prefix);
    // copy after pares
    buf.extend(line[close_paren_idx..line.len]);
    // return
    return buf.str();
}

pub fn removePrefixFromResult(
    buf: *Buffer,
    line: []const u8,
    prefix: []const u8,
) []const u8 {
    const close_paren_idx = lastIndexOfScalar(u8, line, ')').?;
    const line1 = line[0 .. close_paren_idx + 1];
    const line2 = line[close_paren_idx + 1 .. line.len];
    print("Buf: {s}\n", .{buf.str()});
    buf.copy(line1);
    const n_reps = replace(
        u8,
        line2,
        prefix,
        "",
        buf.buf[close_paren_idx + 1 .. BUFFER_SIZE],
    );
    buf.end = line.len - (n_reps * prefix.len);
    return buf.str();
}

pub fn fieldName(buf: *const Buffer) []const u8 {
    const line = buf.str();
    const colon = indexOfScalar(u8, line, ':').?;
    const space = lastIndexOfScalar(u8, line[0..colon], ' ').? + 1;
    return line[space..colon];
}

pub fn fieldType(buf: *const Buffer) []const u8 {
    const line = buf.str();
    const colon_idx = indexOfScalar(u8, line, ':').?;
    const eql_idx = indexOfScalar(u8, line, '=').?;
    return line[colon_idx + 2 .. eql_idx - 1];
}

pub fn fieldValue(buf: *const Buffer) []const u8 {
    const line = buf.str();
    const eql_idx = indexOfScalar(u8, line, '=').?;
    const comma_idx = indexOfScalar(u8, line, ',').?;
    return line[eql_idx + 2 .. comma_idx - 1];
}

pub fn replaceFieldName(buf: *Buffer, new_field_names: []const []const u8) []const u8 {
    const line = buf.str();
    // parse field sections
    const old_field_name = buf.fieldName();
    const old_field_type = buf.fieldType();
    const old_field_value = buf.fieldValue();
    // total
    var total_len: usize = line.len - old_field_name.len;
    for (new_field_names) |new_field_name| total_len += new_field_name.len;
    std.debug.assert(total_len < BUFFER_SIZE);
    // extend
    var buf1: Buffer = .{};
    _ = buf1.extends(new_field_names);
    const newline = buf1.extends(&.{ old_field_type, old_field_value });
    // copy
    buf.reset();
    buf.copy(newline);
    // return
    return buf.str();
}

pub fn replaceFieldType(buf: *Buffer, new_field_types: []const []const u8) []const u8 {
    const line = buf.str();
    // parse field sections
    const old_field_name = buf.fieldName();
    const old_field_type = buf.fieldType();
    const old_field_value = buf.fieldValue();
    // total
    var total_len: usize = line.len - old_field_type.len;
    for (new_field_types) |new_field_type| total_len += new_field_type.len;
    // extend
    var buf1: Buffer = .{};
    buf1.extends(&.{ "    ", old_field_name, ": " });
    _ = buf1.extends(new_field_types);
    buf1.extend(old_field_value);
    // copy
    const newline = buf1.str();
    buf.reset();
    buf.copy(newline);
    // return
    return buf.str();
}

pub fn replaceFieldValue(buf: *Buffer, new_field_values: []const []const u8) []const u8 {
    const line = buf.str();
    // parse field sections
    const old_field_name = buf.fieldName();
    const old_field_type = buf.fieldType();
    const old_field_value = buf.fieldValue();
    // total
    var total_len: usize = line.len - old_field_value.len;
    for (new_field_values) |new_field_value| total_len += new_field_value.len;
    // extend
    var buf1: Buffer = .{};
    _ = buf1.extends(&.{ "    ", old_field_name, ": ", old_field_type });
    _ = buf1.extends(new_field_values);
    // copy
    const newline = buf1.str();
    buf.reset();
    buf.copy(newline);
    // return
    return buf.str();
}

pub fn lower(buf: *Buffer) []const u8 {
    const line = buf.str();
    return lowerString(&buf.buf, line);
}
