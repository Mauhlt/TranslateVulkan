const std = @import("std");
const Allocator = std.mem.Allocator;
const EnumField = @This();

name: []const u8,
value: i64,

pub fn init(
    allo: Allocator,
    name: []const u8,
    value: i64,
) !EnumField {
    return .{
        .name = try allo.dupe(u8, name),
        .value = value,
    };
}

pub fn deinit(self: *EnumField, allo: Allocator) void {
    allo.free(self.name);
}
