//! vkgen: vk.xml + video.xml -> vk.zig
//!
//! usage: vkgen <vk.xml> <video.xml> <out dir> [--snapshot-dir <dir>]
//!
//! Writes into <out dir>:
//!   vk.zig          the bindings
//!   vk_c_test.zig   tests comparing vk.zig with the C headers
//!   vk_layout.c     struct layouts from a C compiler, used by vk_c_test.zig
//! With --snapshot-dir, also writes <dir>/vk-<version>.zig and <dir>/vk.zig so
//! older versions stay available for consumers that must be held back.
const std = @import("std");
const Io = std.Io;
const xml = @import("xml.zig");
const Registry = @import("registry.zig").Registry;
const render = @import("render.zig");

pub fn main(init: std.process.Init) !void {
    const arena = init.arena.allocator();
    const io = init.io;
    const args = try init.minimal.args.toSlice(arena);
    const snapshot_dir: ?[]const u8 = switch (args.len) {
        4 => null,
        6 => if (std.mem.eql(u8, args[4], "--snapshot-dir")) args[5] else usage(args[0]),
        else => usage(args[0]),
    };
    const vk_xml_path, const video_xml_path, const out_dir = .{ args[1], args[2], args[3] };

    const cwd = Io.Dir.cwd();
    var reg: Registry = .init(arena);
    // video.xml first: its real StdVideo* definitions win over vk.xml's stubs.
    for ([_][]const u8{ video_xml_path, vk_xml_path }) |path| {
        const source = try cwd.readFileAlloc(io, path, arena, .unlimited);
        try reg.load(try xml.parse(arena, source));
    }
    try reg.computeClosure();
    const out = try render.render(arena, &reg);
    const vk_zig = try zigFmt(arena, "vk.zig", out.vk_zig);

    try writeFile(io, arena, out_dir, "vk.zig", vk_zig);
    try writeFile(io, arena, out_dir, "vk_c_test.zig", try zigFmt(arena, "vk_c_test.zig", out.c_test_zig));
    try writeFile(io, arena, out_dir, "vk_layout.c", out.layout_c);

    if (snapshot_dir) |dir| {
        const versioned = try std.fmt.allocPrint(arena, "vk-{s}.zig", .{out.version});
        try writeFile(io, arena, dir, versioned, vk_zig);
        try writeFile(io, arena, dir, "vk.zig", vk_zig);
        std.debug.print("vkgen: Vulkan {s} -> {s}\n", .{ out.version, try std.fs.path.join(arena, &.{ dir, versioned }) });
    }
}

/// Runs the output through Zig's own formatter: canonical layout, and any
/// syntax error in generated code is reported here rather than in a consumer.
fn zigFmt(arena: std.mem.Allocator, name: []const u8, source: []const u8) ![]const u8 {
    var tree = try std.zig.Ast.parse(arena, try arena.dupeSentinel(u8, source, 0), .{});
    if (tree.errors.len > 0) {
        var buf: [256]u8 = undefined;
        var w = std.Io.Writer.fixed(&buf);
        tree.renderError(tree.errors[0], &w) catch {};
        std.debug.print("vkgen: generated {s} does not parse: {s}\n", .{ name, w.buffered() });
        return error.InvalidGeneratedCode;
    }
    return tree.renderAlloc(arena);
}

fn usage(exe: []const u8) noreturn {
    std.debug.print("usage: {s} <vk.xml> <video.xml> <out dir> [--snapshot-dir <dir>]\n", .{exe});
    std.process.exit(2);
}

fn writeFile(io: Io, arena: std.mem.Allocator, dir: []const u8, name: []const u8, data: []const u8) !void {
    const cwd = Io.Dir.cwd();
    try cwd.createDirPath(io, dir);
    try cwd.writeFile(io, .{ .sub_path = try std.fs.path.join(arena, &.{ dir, name }), .data = data });
}

test {
    _ = @import("xml.zig");
    _ = @import("naming.zig");
    _ = @import("registry.zig");
    _ = @import("render.zig");
}
