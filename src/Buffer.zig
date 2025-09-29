const std = @import("std");
// ascii
const toLower = std.ascii.toLower;
const isUpper = std.ascii.isUpper;
const isLower = std.ascii.isLower;
const isDigit = std.ascii.isDigit;
// mem
const replace = std.mem.replace;
const startsWith = std.mem.startsWith;
const endsWith = std.mem.endsWith;
const eql = std.mem.eql;
const indexOfScalar = std.mem.indexOfScalar;
const indexOf = std.mem.indexOf;
const lastIndexOfScalar = std.mem.lastIndexOfScalar;
const splitScalar = std.mem.splitScalar;
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
    std.debug.assert(line.len < BUFFER_SIZE);
    var self: Buffer = .{};
    self.copy(line);
    return self;
}

pub fn reset(self: *Buffer) void {
    self.buffer = undefined;
    self.start = 0;
    self.end = 0;
}

pub fn str(buf: *Buffer) []const u8 {
    return buf.buf[0..buf.end];
}

pub fn copy(self: *Buffer, phrase: []const u8) void {
    std.debug.assert(self.end + phrase.len < BUFFER_SIZE);
    self.start = self.end;
    self.end += phrase.len;
    @memcpy(self.buf[self.start..self.end], phrase);
}

pub fn remove(
    buf: *Buffer,
    needle: []const u8,
) []const u8 {
    const line = buf.str();
    const n_replaces = replace(u8, line, needle, "", &buf.buf);
    buf.end = line.len - (n_replaces * needle.len);
    return buf.str();
}

pub fn removePrefixes(buf: *Buffer, names: []const []const u8) void {
    for (names) |name| {
        if (startsWith(u8, buf.str(), name)) {
            for (name.len..buf.end) |i| //
                buf.buf[i - name.len] = buf.buf[i];
            buf.end -= name.len;
        }
    }
}

pub fn removeSuffixes(buf: *Buffer, names: []const []const u8) void {
    for (names) |name| {
        if (endsWith(u8, buf.str(), name)) {
            buf.end -= name.len;
        }
    }
}

pub fn toSnake(buf: *Buffer, name: []const u8) []const u8 {
    std.debug.assert(buf.start + name.len < BUFFER_SIZE);
    buf.buf[buf.start] = toLower(name[0]);
    buf.start += 1;
    for (1..name.len) |j| {
        const ch1 = name[j - 1];
        const ch2 = name[j];
        if ((isDigit(ch1) or isLower(ch1)) and isUpper(ch2)) {
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

pub fn argNamesToSnake(buf: *Buffer, line: []const u8) []const u8 {
    // get paren idxs
    const open_paren_idx = indexOfScalar(u8, line, '(').?;
    const close_paren_idx = lastIndexOfScalar(u8, line, ')').?;
    // create idxs
    buf.copy(line);
    buf.start = buf.end + 1;
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
        var buf1: Buffer = undefined;
        const new_snake_name = buf1.toSnake(arg_name);
        buf.extend(new_snake_name);
        // copy rest
        buf.extend(item[colon_idx..item.len]);
        if (n_commas > 0) {
            buf.extend(", ");
            n_commas -= 1;
        }
    }
    // copy rest of buffer
    buf.extend(line[close_paren_idx..line.len]);
    // copy + return
    return buf.str();
}

pub fn removePrefixFromFnName(
    buf: *Buffer,
    line: []const u8,
    prefix: []const u8,
) []const u8 {
    const open_paren_idx = indexOfScalar(u8, line, '(').?;
    const space_idx = indexOfScalar(u8, line[0..open_paren_idx], ' ').?;
    // copy pre-fn name
    buf.copy(line[0 .. space_idx + 1]);
    // get var name
    const var_name = varName(line, &.{ line[0 .. space_idx + 1], prefix }, &.{});
    buf.extend(var_name);
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
    buf.replaceAndExtend(args, prefix);
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
    buf.copy(line[0 .. close_paren_idx + 1]);
    const n_reps = replace(
        u8,
        line[close_paren_idx + 1 .. line.len],
        prefix,
        "",
        buf.buf[close_paren_idx + 1 .. BUFFER_SIZE],
    );
    buf.end = line.len - (n_reps * prefix.len);
    return buf.str();
}
