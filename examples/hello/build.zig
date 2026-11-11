//! A standalone consumer of vk.zig, built the way your own projects would be:
//! it keeps its own copy of vk.zig in src/ (refresh with `zig build snapshot`
//! in TranslateVulkan, then copy generated/vk.zig, or a pinned vk-<version>.zig).
const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});
    const vk = b.createModule(.{ .root_source_file = b.path("src/vk.zig"), .target = target, .optimize = optimize });
    const exe = b.addExecutable(.{
        .name = "hello",
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/main.zig"),
            .target = target,
            .optimize = optimize,
            .imports = &.{.{ .name = "vk", .module = vk }},
        }),
    });
    b.installArtifact(exe);
    b.step("run", "Run hello").dependOn(&b.addRunArtifact(exe).step);
}
