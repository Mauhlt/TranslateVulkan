const std = @import("std");
const BUFFER_SIZE = @import("constants.zig");
const Position = @This();

buf: [BUFFER_SIZE]u8 = undefined,
start: usize = 0,
end: usize = 0,

fn reset(self: *@This()) void {
    self.buffer = undefined;
    self.start = 0;
    self.end = 0;
}

fn copy(self: *Position, phrase: []const u8) void {
    std.debug.assert(self.end + phrase.len < BUFFER_SIZE);
    self.start = self.end;
    self.end += phrase.len;
    @memcpy(self.buf[self.start..self.end], phrase);
}
