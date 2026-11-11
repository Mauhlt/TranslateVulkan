//! TranslateVulkan: generates vk.zig from the Khronos registry (vk.xml + video.xml).
//!
//!   zig build                  generate zig-out/vk.zig (also exported as module "vulkan")
//!   zig build test             naming unit tests + compare vk.zig against the C headers
//!   zig build snapshot         write generated/vk-<version>.zig and generated/vk.zig
//!   zig build compat           build the repos in consumers.zon against the new vk.zig, log to compat/log.md
//!   zig build update           re-pin Vulkan-Headers to the latest commit on main
//!   zig build run-example      create an instance and list GPUs with the fresh vk.zig
//!
//! Options:
//!   -Dregistry=<dir>           use <dir>/vk.xml and <dir>/video.xml (e.g. a Vulkan SDK's
//!                              share/vulkan/registry) instead of the pinned dependency
const std = @import("std");
const LazyPath = std.Build.LazyPath;

const headers_url = "git+https://github.com/KhronosGroup/Vulkan-Headers#main";

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});
    const registry_dir = b.option([]const u8, "registry", "Directory with vk.xml and video.xml (default: pinned Vulkan-Headers)");

    const headers = b.dependency("vulkan_headers", .{});
    const xml: Registry = if (registry_dir) |dir| .{
        .vk = b.graph.cwdRelativePath(b.pathJoin(&.{ dir, "vk.xml" })),
        .video = b.graph.cwdRelativePath(b.pathJoin(&.{ dir, "video.xml" })),
    } else .{
        .vk = headers.path("registry/vk.xml"),
        .video = headers.path("registry/video.xml"),
    };

    // The generator runs on the host, optimized (it parses ~3.5 MB of XML).
    const vkgen = b.addExecutable(.{
        .name = "vkgen",
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/main.zig"),
            .target = b.graph.host,
            .optimize = .ReleaseSafe,
        }),
    });

    // zig build: zig-out/vk.zig + module "vulkan" for downstream build.zig files.
    const generated = generate(b, vkgen, xml);
    const vk_zig = generated.path(b, "vk.zig");
    const vk_module = b.addModule("vulkan", .{ .root_source_file = vk_zig, .target = target, .optimize = optimize });
    b.getInstallStep().dependOn(&b.addInstallFile(vk_zig, "vk.zig").step);

    // zig build snapshot
    const snapshot = b.addRunArtifact(vkgen);
    snapshot.addFileArg(xml.vk);
    snapshot.addFileArg(xml.video);
    _ = snapshot.addOutputDirectoryArg("vk");
    snapshot.addArg("--snapshot-dir");
    snapshot.addDirectoryArg(b.path("generated"));
    snapshot.has_side_effects = true;
    b.step("snapshot", "Write generated/vk-<version>.zig and generated/vk.zig").dependOn(&snapshot.step);

    // zig build test
    const test_step = b.step("test", "Run naming unit tests and compare vk.zig with the C headers");
    const unit_tests = b.addTest(.{ .root_module = b.createModule(.{
        .root_source_file = b.path("src/main.zig"),
        .target = b.graph.host,
    }) });
    test_step.dependOn(&b.addRunArtifact(unit_tests).step);

    const translate_c = b.addTranslateC(.{
        .root_source_file = headers.path("include/vulkan/vulkan_core.h"),
        .target = target,
        .optimize = optimize,
    });
    translate_c.addIncludePath(headers.path("include"));
    const c_test_module = b.createModule(.{
        .root_source_file = generated.path(b, "vk_c_test.zig"),
        .target = target,
        .optimize = optimize,
        .link_libc = true,
        .imports = &.{
            .{ .name = "vk", .module = vk_module },
            .{ .name = "c", .module = translate_c.createModule() },
        },
    });
    c_test_module.addCSourceFile(.{ .file = generated.path(b, "vk_layout.c") });
    c_test_module.addIncludePath(headers.path("include"));
    test_step.dependOn(&b.addRunArtifact(b.addTest(.{ .root_module = c_test_module })).step);

    // zig build run-example
    const example = b.addExecutable(.{
        .name = "hello",
        .root_module = b.createModule(.{
            .root_source_file = b.path("examples/hello/src/main.zig"),
            .target = target,
            .optimize = optimize,
            .imports = &.{.{ .name = "vk", .module = vk_module }},
        }),
    });
    b.step("run-example", "Create a Vulkan instance and list GPUs").dependOn(&b.addRunArtifact(example).step);

    // zig build compat
    const compat_exe = b.addExecutable(.{
        .name = "compat",
        .root_module = b.createModule(.{ .root_source_file = b.path("src/compat.zig"), .target = b.graph.host }),
    });
    const compat = b.addRunArtifact(compat_exe);
    compat.addFileArg(vk_zig);
    compat.addFileArg(b.path("consumers.zon"));
    compat.addDirectoryArg(b.path("compat")); // log.md is written here
    compat.addDirectoryArg(.cache_root); // scratch copies of consumer repos
    compat.addArg(b.graph.zig_exe);
    compat.setCwd(b.path("."));
    compat.has_side_effects = true;
    b.step("compat", "Build the repos in consumers.zon against the new vk.zig and log results").dependOn(&compat.step);

    // zig build update
    const update = b.addSystemCommand(&.{ b.graph.zig_exe, "fetch", "--save=vulkan_headers", headers_url });
    update.setCwd(b.path("."));
    b.step("update", "Re-pin Vulkan-Headers (vk.xml, video.xml) to the latest commit").dependOn(&update.step);
}

const Registry = struct { vk: LazyPath, video: LazyPath };

/// Runs vkgen; the returned directory holds vk.zig, vk_c_test.zig and vk_layout.c.
fn generate(b: *std.Build, vkgen: *std.Build.Step.Compile, xml: Registry) LazyPath {
    const run = b.addRunArtifact(vkgen);
    run.addFileArg(xml.vk);
    run.addFileArg(xml.video);
    return run.addOutputDirectoryArg("vk");
}
