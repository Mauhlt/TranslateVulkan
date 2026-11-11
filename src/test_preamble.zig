//! GENERATED alongside vk.zig (the helpers below are src/test_preamble.zig in
//! TranslateVulkan; the test bodies after them are generated). Checks every
//! generated declaration against the official C headers:
//!   * enum values      vk.Format.r8g8b8a8_unorm == VK_FORMAT_R8G8B8A8_UNORM, for every
//!                      value: proves the naming schema maps each C name correctly
//!   * constants, handle/flag/enum sizes, command signatures (via translate-c)
//!   * struct size, alignment and field offsets, measured by a real C compiler
//!     (vk_layout.c), so bitfield structs are covered too
//! Checks are plain statements (no big comptime loops) to keep compile time and
//! memory low. Names missing from vulkan_core.h (platform types) are skipped.
const std = @import("std");
const vk = @import("vk");
const c = @import("c");

var failures: usize = 0;

fn expectEq(what: []const u8, zig_value: i128, c_value: i128) void {
    if (zig_value == c_value) return;
    failures += 1;
    if (failures <= 50) std.debug.print("{s}: zig {d}, C {d}\n", .{ what, zig_value, c_value });
}

/// Same parameter count and parameter/return sizes as the C function pointer.
fn expectSignature(comptime Z: type, comptime C: type, name: []const u8) void {
    const z, const cf = .{ fnInfo(Z), fnInfo(C) };
    expectEq(name, z.param_types.len, cf.param_types.len);
    if (z.param_types.len != cf.param_types.len) return;
    inline for (z.param_types, cf.param_types) |zp, cp| expectEq(name, @sizeOf(zp.?), @sizeOf(cp.?));
    expectEq(name, @sizeOf(z.return_type.?), @sizeOf(cf.return_type.?));
}

fn fnInfo(comptime P: type) std.builtin.Type.Fn {
    const Ptr = if (@typeInfo(P) == .optional) @typeInfo(P).optional.child else P;
    return @typeInfo(@typeInfo(Ptr).pointer.child).@"fn";
}

fn finish(what: []const u8) !void {
    if (failures == 0) return;
    std.debug.print("{d} {s} mismatches\n", .{ failures, what });
    failures = 0;
    return error.Mismatch;
}

test "every declaration compiles" {
    @setEvalBranchQuota(100_000);
    std.testing.refAllDecls(vk);
}
