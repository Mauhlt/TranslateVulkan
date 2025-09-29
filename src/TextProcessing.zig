const std = @import("std");
const end_str = if (@import("builtin").os.tag == .windows) "\r\n" else "\n";
// mem
const Allocator = std.mem.Allocator;
const eql = std.mem.eql;
const startsWith = std.mem.startsWith;
const endsWith = std.mem.endsWith;
const indexOfScalar = std.mem.indexOfScalar;
const lastIndexOfScalar = std.mem.lastIndexOfScalar;

pub fn varName(
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

pub fn varValue(line: []const u8) []const u8 {
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

pub fn varTypePreEql(line: []const u8) []const u8 {
    const eql_idx = indexOfScalar(u8, line, '=').?;
    const colon_idx = lastIndexOfScalar(u8, line, ':').?;
    return line[colon_idx + 1 .. eql_idx - 1];
}

pub fn varTypePostEql(line: []const u8) []const u8 {
    const open_paren_idx = lastIndexOfScalar(u8, line, '(').?;
    const comma_idx = lastIndexOfScalar(u8, line, ',').?;
    std.debug.assert(open_paren_idx < comma_idx);
    return line[open_paren_idx + 1 .. comma_idx];
}

pub fn modCwd(allo: Allocator, filename: []const u8) ![]const u8 {
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

pub fn trimLeft(
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

pub fn trimRight(
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

pub fn trimLine(line: []const u8) []const u8 {
    return std.mem.trimRight(u8, line, end_str);
}

pub fn hasType(type_name: []const u8) bool {
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
