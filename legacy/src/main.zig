const std = @import("std");
const TextData = @import("TextData.zig");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allo = gpa.allocator();
    defer std.debug.assert(.ok == gpa.deinit());

    var text_data = try TextData.init(allo);
    defer text_data.deinit(allo);
    try text_data.parse(allo);
}
