const std = @import("std");
pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});
    // const mod = b.addModule("TranslateVulkan2", .{
    //    .root_source_file = b.path("src/root.zig"),
    //    .target = target,
    // });
    const exe = b.addExecutable(.{
        .name = "TranslateVulkan2",
        .root_module = b.createModule(.{
           .root_source_file = b.path("src/main.zig"),
           .target = target,
            .optimize = optimize,
           .imports = &.{
               // .{ .name = "TranslateVulkan2", .module = mod },
            },
        }),
    });

    b.installArtifact(exe);
    const run_step = b.step("run", "Run the app");
    const run_cmd = b.addRunArtifact(exe);
    run_step.dependOn(&run_cmd.step);
    run_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }
    // const run_mod_tests = b.addRunArtifact(mod_tests);
    // test_step.dependOn(&run_exe_tests.step);
}
