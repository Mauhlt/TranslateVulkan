//! compat: checks whether a freshly generated vk.zig breaks the repos that use it.
//!
//! usage: compat <vk.zig> <consumers.zon> <log dir> <scratch dir> <zig exe>
//!
//! For each consumer in consumers.zon it:
//!   1. copies the repo into <scratch dir>/compat/<name> (skipping .zig-cache, zig-out, .git),
//!   2. replaces the consumer's own copy of vk.zig with the new one,
//!   3. runs `zig <args>` there (default: `zig build`),
//!   4. appends the outcome to <log dir>/log.md.
//! The real repos are never modified. A consumer with `.pin = "1.4.360"` is
//! still tested (so you know when the pin can be lifted) but is reported as
//! held at its pinned version.
const std = @import("std");
const Io = std.Io;
const Allocator = std.mem.Allocator;

const Consumer = struct {
    name: []const u8,
    /// Repo root, absolute or relative to this project.
    path: []const u8,
    /// Where the consumer keeps its copy of vk.zig, relative to its root.
    vk_file: []const u8 = "src/vk.zig",
    /// Alternatively: the build.zig.zon dependency that provides Vulkan
    /// (e.g. "Vulkan" for `.Vulkan = .{ .path = "../Vulkan" }`). It is replaced
    /// by a package exposing the new vk.zig as module `vk_module`.
    vk_dependency: ?[]const u8 = null,
    vk_module: []const u8 = "vulkan",
    /// Arguments passed to `zig`.
    args: []const []const u8 = &.{"build"},
    /// Hold this consumer at a specific generated version (see generated/vk-<version>.zig).
    pin: ?[]const u8 = null,
};

const Config = struct {
    consumers: []const Consumer = &.{},
};

const Status = enum {
    pass,
    /// Built before the swap, fails after: this vk.zig broke it.
    broken,
    /// Fails even untouched, so the failure says nothing about vk.zig.
    already_failing,
    /// compat itself could not copy or run the consumer.
    compat_error,

    fn label(s: Status) []const u8 {
        return switch (s) {
            .pass => "pass",
            .broken => "**FAIL**",
            .already_failing => "already failing",
            .compat_error => "compat error",
        };
    }
};

const Outcome = struct {
    consumer: Consumer,
    status: Status,
    output: []const u8,
};

const skipped_dirs = [_][]const u8{ ".zig-cache", "zig-out", ".git" };

pub fn main(init: std.process.Init) !void {
    const arena = init.arena.allocator();
    const io = init.io;
    const args = try init.minimal.args.toSlice(arena);
    if (args.len != 6) {
        std.debug.print("usage: {s} <vk.zig> <consumers.zon> <log dir> <scratch dir> <zig exe>\n", .{args[0]});
        std.process.exit(2);
    }
    const vk_path, const config_path, const log_dir, const scratch_dir, const zig_exe =
        .{ args[1], args[2], args[3], args[4], args[5] };
    const cwd = Io.Dir.cwd();

    const vk_zig = try cwd.readFileAlloc(io, vk_path, arena, .unlimited);
    const version = versionOf(vk_zig) orelse "unknown";

    const config_src = try cwd.readFileAllocOptions(io, config_path, arena, .unlimited, .of(u8), 0);
    var diag: std.zon.parse.Diagnostics = undefined; // initialized by fromSlice
    const config = std.zon.parse.fromSlice(Config, .{
        .gpa = init.gpa,
        .arena = arena,
        .source = config_src,
        .diagnostics = &diag,
    }) catch {
        diag.log(config_path);
        std.process.exit(1);
    };

    var outcomes: std.ArrayList(Outcome) = .empty;
    for (config.consumers) |consumer| {
        std.debug.print("compat: {s} ... ", .{consumer.name});
        const outcome = check(arena, io, consumer, vk_zig, scratch_dir, zig_exe) catch |err| Outcome{
            .consumer = consumer,
            .status = .compat_error,
            .output = try std.fmt.allocPrint(arena, "compat could not run this consumer: {t}", .{err}),
        };
        std.debug.print("{s}\n", .{outcome.status.label()});
        try outcomes.append(arena, outcome);
    }

    const entry = try formatLog(arena, io, version, outcomes.items);
    try appendLog(arena, io, log_dir, entry);
    std.debug.print("compat: results for vk.zig {s} appended to {s}/log.md\n", .{ version, log_dir });
}

fn check(arena: Allocator, io: Io, consumer: Consumer, vk_zig: []const u8, scratch_dir: []const u8, zig_exe: []const u8) !Outcome {
    const cwd = Io.Dir.cwd();
    const work = try std.fs.path.join(arena, &.{ scratch_dir, "compat", consumer.name });
    cwd.deleteTree(io, work) catch {};
    try cwd.createDirPath(io, work);

    var src = try cwd.openDir(io, consumer.path, .{ .iterate = true });
    defer src.close(io);
    var dst = try cwd.openDir(io, work, .{});
    defer dst.close(io);
    try copyTree(arena, io, src, dst);
    try fixPathDependencies(arena, io, dst, consumer.path, work);

    const baseline = try runZig(arena, io, zig_exe, consumer.args, work);

    if (consumer.vk_dependency) |dep| {
        try writeVkPackage(arena, io, dst, consumer.vk_module, vk_zig);
        try redirectDependency(arena, io, dst, dep);
    } else {
        if (std.fs.path.dirname(consumer.vk_file)) |d| try dst.createDirPath(io, d);
        try dst.writeFile(io, .{ .sub_path = consumer.vk_file, .data = vk_zig });
    }
    const swapped = try runZig(arena, io, zig_exe, consumer.args, work);
    const status: Status = if (swapped.passed) .pass else if (baseline.passed) .broken else .already_failing;
    return .{ .consumer = consumer, .status = status, .output = swapped.output };
}

fn runZig(arena: Allocator, io: Io, zig_exe: []const u8, args: []const []const u8, cwd: []const u8) !struct { passed: bool, output: []const u8 } {
    var argv: std.ArrayList([]const u8) = .empty;
    try argv.append(arena, zig_exe);
    try argv.appendSlice(arena, args);
    const result = try std.process.run(arena, io, .{
        .argv = argv.items,
        .cwd = .{ .path = cwd },
        .stderr_limit = .limited(1 << 20),
        .stdout_limit = .limited(1 << 20),
    });
    return .{
        .passed = result.term.success(),
        .output = if (result.stderr.len > 0) result.stderr else result.stdout,
    };
}

fn copyTree(arena: Allocator, io: Io, src: Io.Dir, dst: Io.Dir) !void {
    var walker = try src.walkSelectively(arena);
    defer walker.deinit();
    while (try walker.next(io)) |entry| {
        switch (entry.kind) {
            .directory => {
                const skip = for (skipped_dirs) |s| {
                    if (std.mem.eql(u8, entry.basename, s)) break true;
                } else false;
                if (skip) continue;
                try dst.createDirPath(io, entry.path);
                try walker.enter(io, entry);
            },
            .file => try src.copyFile(entry.path, dst, entry.path, io, .{}),
            else => {},
        }
    }
}

/// The copy lives somewhere else, so `.path = "../Windows"` dependencies in
/// its build.zig.zon are re-pointed at the original locations.
fn fixPathDependencies(arena: Allocator, io: Io, dst: Io.Dir, original_root: []const u8, work: []const u8) !void {
    const zon = dst.readFileAlloc(io, "build.zig.zon", arena, .unlimited) catch |err| switch (err) {
        error.FileNotFound => return,
        else => return err,
    };
    const cwd = try std.process.currentPathAlloc(io, arena);
    const key = ".path = \"";
    var out: std.ArrayList(u8) = .empty;
    var rest = zon;
    while (std.mem.indexOf(u8, rest, key)) |idx| {
        const start = idx + key.len;
        const end = std.mem.indexOfScalarPos(u8, rest, start, '"') orelse break;
        const dep = rest[start..end];
        const target = try std.fs.path.join(arena, &.{ original_root, dep });
        const rel = try std.fs.path.relativeAlloc(arena, cwd, null, work, target);
        try out.appendSlice(arena, rest[0..start]);
        // Zig string literal: forward slashes avoid escaping backslashes.
        for (rel) |c| try out.append(arena, if (c == '\\') '/' else c);
        rest = rest[end..];
    }
    try out.appendSlice(arena, rest);
    try dst.writeFile(io, .{ .sub_path = "build.zig.zon", .data = out.items });
}

const vk_package_dir = "_vk_package";

/// A throwaway package that exposes vk.zig as module `module_name`.
fn writeVkPackage(arena: Allocator, io: Io, dst: Io.Dir, module_name: []const u8, vk_zig: []const u8) !void {
    try dst.createDirPath(io, vk_package_dir ++ "/src");
    try dst.writeFile(io, .{ .sub_path = vk_package_dir ++ "/src/vk.zig", .data = vk_zig });
    try dst.writeFile(io, .{ .sub_path = vk_package_dir ++ "/build.zig", .data = try std.fmt.allocPrint(arena,
        \\const std = @import("std");
        \\pub fn build(b: *std.Build) void {{
        \\    _ = b.addModule("{s}", .{{ .root_source_file = b.path("src/vk.zig") }});
        \\}}
        \\
    , .{module_name}) });
    try dst.writeFile(io, .{ .sub_path = vk_package_dir ++ "/build.zig.zon", .data =
        \\.{
        \\    .name = .vk_package,
        \\    .version = "0.0.0",
        \\    .fingerprint = 0x9e9db51f32ee7d0,
        \\    .paths = .{ "build.zig", "build.zig.zon", "src" },
        \\}
        \\
    });
}

/// Points dependency `.name = .{ .path = "..." }` (or `.url`) at the vk package.
fn redirectDependency(arena: Allocator, io: Io, dst: Io.Dir, name: []const u8) !void {
    const zon = try dst.readFileAlloc(io, "build.zig.zon", arena, .unlimited);
    const plain = try std.fmt.allocPrint(arena, ".{s} = .{{", .{name});
    const quoted = try std.fmt.allocPrint(arena, ".@\"{s}\" = .{{", .{name});
    const start = std.mem.indexOf(u8, zon, plain) orelse std.mem.indexOf(u8, zon, quoted) orelse
        return error.DependencyNotFound;
    const end = std.mem.indexOfScalarPos(u8, zon, start, '}') orelse return error.InvalidZon;
    const replacement = try std.fmt.allocPrint(arena, ".{s} = .{{ .path = \"{s}\" }}", .{ name, vk_package_dir });
    try dst.writeFile(io, .{
        .sub_path = "build.zig.zon",
        .data = try std.mem.concat(arena, u8, &.{ zon[0..start], replacement, zon[end + 1 ..] }),
    });
}

/// Reads `pub const version_string = "1.4.368";` from a generated vk.zig.
fn versionOf(vk_zig: []const u8) ?[]const u8 {
    const key = "pub const version_string = \"";
    const start = (std.mem.indexOf(u8, vk_zig, key) orelse return null) + key.len;
    const end = std.mem.indexOfScalarPos(u8, vk_zig, start, '"') orelse return null;
    return vk_zig[start..end];
}

fn formatLog(arena: Allocator, io: Io, version: []const u8, outcomes: []const Outcome) ![]const u8 {
    var out: Io.Writer.Allocating = .init(arena);
    const w = &out.writer;

    const now = Io.Clock.real.now(io).toSeconds();
    const es: std.time.epoch.EpochSeconds = .{ .secs = @intCast(now) };
    const day = es.getEpochDay().calculateYearDay();
    const md = day.calculateMonthDay();
    const secs = es.getDaySeconds();
    try w.print("\n## {d}-{d:0>2}-{d:0>2} {d:0>2}:{d:0>2} UTC: vk.zig {s}\n\n", .{
        day.year, md.month.numeric(), md.day_index + 1, secs.getHoursIntoDay(), secs.getMinutesIntoHour(), version,
    });
    try w.writeAll("| consumer | result | pin | action |\n|---|---|---|---|\n");
    for (outcomes) |o| {
        const pinned = o.consumer.pin != null;
        const action: []const u8 = switch (o.status) {
            .pass => if (pinned) "pin can be lifted" else "ok",
            .broken => if (pinned) "keep pin" else "BROKEN by this version: pin to an earlier generated/vk-<version>.zig",
            .already_failing => "fails without the new vk.zig too: not caused by it",
            .compat_error => "see details",
        };
        try w.print("| {s} | {s} | {s} | {s} |\n", .{ o.consumer.name, o.status.label(), o.consumer.pin orelse "latest", action });
    }
    for (outcomes) |o| {
        if (o.status == .pass) continue;
        try w.print("\n<details><summary>{s}: zig", .{o.consumer.name});
        for (o.consumer.args) |a| try w.print(" {s}", .{a});
        try w.writeAll("</summary>\n\n```\n");
        try w.writeAll(lastLines(o.output, 40));
        try w.writeAll("\n```\n</details>\n");
    }
    return out.written();
}

fn lastLines(text: []const u8, n: usize) []const u8 {
    const trimmed = std.mem.trimEnd(u8, text, "\r\n");
    var count: usize = 0;
    var i = trimmed.len;
    while (i > 0) : (i -= 1) {
        if (trimmed[i - 1] == '\n') {
            count += 1;
            if (count == n) return trimmed[i..];
        }
    }
    return trimmed;
}

fn appendLog(arena: Allocator, io: Io, log_dir: []const u8, entry: []const u8) !void {
    const cwd = Io.Dir.cwd();
    try cwd.createDirPath(io, log_dir);
    const path = try std.fs.path.join(arena, &.{ log_dir, "log.md" });
    const existing = cwd.readFileAlloc(io, path, arena, .unlimited) catch |err| switch (err) {
        error.FileNotFound => "# Consumer compatibility log\n\nAppended by `zig build compat`. Newest entries at the bottom.\n",
        else => return err,
    };
    try cwd.writeFile(io, .{ .sub_path = path, .data = try std.mem.concat(arena, u8, &.{ existing, entry }) });
}

test lastLines {
    try std.testing.expectEqualStrings("c\nd", lastLines("a\nb\nc\nd\n", 2));
    try std.testing.expectEqualStrings("a", lastLines("a", 5));
}

test versionOf {
    try std.testing.expectEqualStrings("1.4.368", versionOf("x\npub const version_string = \"1.4.368\";\n").?);
}
