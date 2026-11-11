//! The naming schema: how every C identifier in vk.xml / video.xml becomes a
//! Zig identifier. Everything here is a pure function so it can be unit
//! tested in isolation (`zig build test`).
//!
//!   C                                   Zig
//!   ----------------------------------  ---------------------------------
//!   VkInstanceCreateInfo                vk.InstanceCreateInfo      (types: TitleCase, drop `Vk`)
//!   PFN_vkDebugUtilsMessengerCallbackEXT vk.PfnDebugUtilsMessengerCallbackEXT
//!   vkCreateInstance                    vk.createInstance          (functions: camelCase, drop `vk`)
//!   pApplicationInfo                    .p_application_info        (fields/params: snake_case)
//!   VK_FORMAT_R8G8B8A8_UNORM            vk.Format.r8g8b8a8_unorm   (enum values: drop the type prefix)
//!   VK_SHADER_STAGE_VERTEX_BIT          vk.ShaderStageFlagBits.vertex_bit
//!   VK_MAX_EXTENSION_NAME_SIZE          vk.max_extension_name_size (constants: snake_case)
//!   VK_ERROR_OUT_OF_DATE_KHR            error.OutOfDateKHR         (errors: TitleCase, vendor tag kept)
const std = @import("std");
const Allocator = std.mem.Allocator;

/// Vendor tags used when a registry does not provide `<tags>` (video.xml).
pub const default_tags = [_][]const u8{
    "KHR",  "EXT",    "NV",      "NVX",     "AMD", "AMDX", "ARM", "INTEL", "QCOM", "HUAWEI", "VALVE",
    "MESA", "GOOGLE", "ANDROID", "FUCHSIA", "GGP", "MVK",  "NN",  "QNX",   "SEC",  "LUNARG", "IMG",
    "MSFT", "NZXT",   "OHOS",    "SAMSUNG",
};

fn isUpper(c: u8) bool {
    return c >= 'A' and c <= 'Z';
}
fn isLower(c: u8) bool {
    return c >= 'a' and c <= 'z';
}
fn isDigit(c: u8) bool {
    return c >= '0' and c <= '9';
}

/// True when a word boundary sits between `s[i-1]` and `s[i]`.
///   lowerUpper      shaderFloat   -> shader|Float
///   ACRONYMWord     LUIDValid     -> LUID|Valid
///   digitWord       16BitAccess   -> 16|Bit       (but 2DView -> 2D|View)
fn isBoundary(s: []const u8, i: usize) bool {
    if (i == 0 or !isUpper(s[i])) return false;
    const prev = s[i - 1];
    const next: u8 = if (i + 1 < s.len) s[i + 1] else 0;
    if (isLower(prev)) return true;
    if (isUpper(prev) and isLower(next)) return true;
    if (isDigit(prev) and isLower(next)) return true;
    return false;
}

/// camelCase / PascalCase -> snake_case. Idempotent on snake_case input.
///   deviceLUIDValid        -> device_luid_valid
///   image2DViewOf3DSparse  -> image2d_view_of3d_sparse
///   storageBuffer16BitAccess -> storage_buffer16_bit_access
pub fn snakeCase(gpa: Allocator, s: []const u8) Allocator.Error![]const u8 {
    var out: std.ArrayList(u8) = .empty;
    try out.ensureTotalCapacity(gpa, s.len + 8);
    for (s, 0..) |c, i| {
        if (c == '_') {
            if (out.items.len > 0 and out.items[out.items.len - 1] != '_') try out.append(gpa, '_');
            continue;
        }
        if (isBoundary(s, i) and out.items.len > 0 and out.items[out.items.len - 1] != '_') {
            try out.append(gpa, '_');
        }
        try out.append(gpa, std.ascii.toLower(c));
    }
    return out.toOwnedSlice(gpa);
}

/// PascalCase -> SCREAMING_SNAKE (used to derive enum value prefixes).
pub fn screamingSnake(gpa: Allocator, s: []const u8) Allocator.Error![]const u8 {
    const snake = try snakeCase(gpa, s);
    const out = try gpa.dupe(u8, snake);
    for (out) |*c| c.* = std.ascii.toUpper(c.*);
    gpa.free(snake);
    return out;
}

/// Type names: `VkFoo` -> `Foo`, `PFN_vkFoo` -> `PfnFoo`, others unchanged
/// (`StdVideoH264SpsFlags`, `HWND`, `wl_display`, ...).
pub fn typeName(gpa: Allocator, c_name: []const u8) Allocator.Error![]const u8 {
    if (std.mem.startsWith(u8, c_name, "PFN_vk")) {
        return std.mem.concat(gpa, u8, &.{ "Pfn", c_name["PFN_vk".len..] });
    }
    if (c_name.len > 2 and std.mem.startsWith(u8, c_name, "Vk") and isUpper(c_name[2])) {
        return gpa.dupe(u8, c_name[2..]);
    }
    return gpa.dupe(u8, c_name);
}

/// Command names: `vkCreateInstance` -> `createInstance`.
pub fn commandName(gpa: Allocator, c_name: []const u8) Allocator.Error![]const u8 {
    std.debug.assert(std.mem.startsWith(u8, c_name, "vk"));
    const out = try gpa.dupe(u8, c_name[2..]);
    out[0] = std.ascii.toLower(out[0]);
    return out;
}

/// Constants: `VK_MAX_EXTENSION_NAME_SIZE` -> `max_extension_name_size`,
/// `STD_VIDEO_H264_CPB_CNT_LIST_SIZE` -> `std_video_h264_cpb_cnt_list_size`.
pub fn constantName(gpa: Allocator, c_name: []const u8) Allocator.Error![]const u8 {
    const rest = if (std.mem.startsWith(u8, c_name, "VK_")) c_name[3..] else c_name;
    const out = try gpa.dupe(u8, rest);
    for (out) |*c| c.* = std.ascii.toLower(c.*);
    return out;
}

/// Returns the vendor tag `name` ends with (e.g. "KHR" for `VkSurfaceKHR`), if any.
pub fn vendorTag(name: []const u8, tags: []const []const u8) ?[]const u8 {
    var best: ?[]const u8 = null;
    for (tags) |tag| {
        if (name.len <= tag.len or !std.mem.endsWith(u8, name, tag)) continue;
        const before = name[name.len - tag.len - 1];
        if (isUpper(before)) continue; // e.g. the "NV" in "...ENV" is not a tag
        if (best == null or tag.len > best.?.len) best = tag;
    }
    return best;
}

/// Derives the prefix shared by an enum's values from the enum's type name:
///   VkFormat                  -> VK_FORMAT_
///   VkShaderStageFlagBits     -> VK_SHADER_STAGE_
///   VkPipelineStageFlagBits2  -> VK_PIPELINE_STAGE_2_
///   VkPresentModeKHR          -> VK_PRESENT_MODE_
///   StdVideoH264ProfileIdc    -> STD_VIDEO_H264_PROFILE_IDC_
pub fn enumValuePrefix(gpa: Allocator, type_name: []const u8, tags: []const []const u8) Allocator.Error![]const u8 {
    var name = type_name;
    var lead: []const u8 = "";
    if (std.mem.startsWith(u8, name, "Vk")) {
        name = name[2..];
        lead = "VK_";
    }
    if (vendorTag(name, tags)) |tag| name = name[0 .. name.len - tag.len];

    var version_suffix: []const u8 = "";
    if (std.mem.indexOf(u8, name, "FlagBits")) |idx| {
        version_suffix = name[idx + "FlagBits".len ..]; // "" or "2" / "3"
        name = name[0..idx];
    }
    const scream = try screamingSnake(gpa, name);
    defer gpa.free(scream);
    if (version_suffix.len > 0) {
        return std.mem.concat(gpa, u8, &.{ lead, scream, "_", version_suffix, "_" });
    }
    return std.mem.concat(gpa, u8, &.{ lead, scream, "_" });
}

/// Enum value names: strip the type prefix and lowercase.
///   (VK_FORMAT_, VK_FORMAT_R8G8B8A8_UNORM) -> r8g8b8a8_unorm
///   (VK_RESULT_, VK_SUCCESS)               -> success       (falls back to the
///                                             longest shared `_`-separated prefix)
pub fn enumFieldName(gpa: Allocator, n: EnumNaming, value_name: []const u8) Allocator.Error![]const u8 {
    var rest: []const u8 = undefined;
    if (std.mem.startsWith(u8, value_name, n.prefix) and value_name.len > n.prefix.len) {
        rest = value_name[n.prefix.len..];
    } else {
        // Longest word-aligned common prefix, keeping at least one word.
        var cut: usize = 0;
        var i: usize = 0;
        while (i < value_name.len and i < n.prefix.len and value_name[i] == n.prefix[i]) : (i += 1) {
            if (value_name[i] == '_' and i + 1 < value_name.len) cut = i + 1;
        }
        rest = value_name[cut..];
    }
    // `VkPresentModeKHR`'s VK_PRESENT_MODE_MAILBOX_KHR is just `.mailbox`; a tag
    // that differs from the type's (VK_PRESENT_MODE_FIFO_LATEST_READY_EXT) stays.
    if (n.tag) |tag| {
        if (rest.len > tag.len + 1 and std.mem.endsWith(u8, rest, tag) and rest[rest.len - tag.len - 1] == '_') {
            rest = rest[0 .. rest.len - tag.len - 1];
        }
    }
    const out = try gpa.dupe(u8, rest);
    for (out) |*c| c.* = std.ascii.toLower(c.*);
    return out;
}

/// How one enum type names its values: the shared prefix to strip and the
/// type's own vendor tag (also stripped from its values).
pub const EnumNaming = struct {
    prefix: []const u8,
    tag: ?[]const u8,
};

pub fn enumNaming(gpa: Allocator, type_name: []const u8, tags: []const []const u8) Allocator.Error!EnumNaming {
    return .{ .prefix = try enumValuePrefix(gpa, type_name, tags), .tag = vendorTag(type_name, tags) };
}

/// `VK_ERROR_OUT_OF_DATE_KHR` -> `OutOfDateKHR`.
pub fn errorName(gpa: Allocator, value_name: []const u8, tags: []const []const u8) Allocator.Error![]const u8 {
    const prefix = "VK_ERROR_";
    const rest = if (std.mem.startsWith(u8, value_name, prefix)) value_name[prefix.len..] else value_name;
    var out: std.ArrayList(u8) = .empty;
    var it = std.mem.tokenizeScalar(u8, rest, '_');
    while (it.next()) |word| {
        const is_tag = for (tags) |t| {
            if (std.mem.eql(u8, t, word)) break true;
        } else false;
        if (is_tag) {
            try out.appendSlice(gpa, word);
        } else {
            try out.append(gpa, std.ascii.toUpper(word[0]));
            for (word[1..]) |c| try out.append(gpa, std.ascii.toLower(c));
        }
    }
    return out.toOwnedSlice(gpa);
}

/// True if `name` can be written bare; otherwise it must be written `@"name"`.
pub fn isPlainIdentifier(name: []const u8) bool {
    if (!std.zig.isValidId(name)) return false;
    if (std.zig.primitives.isPrimitive(name)) return false;
    return true;
}

/// Formatter that writes `name` or `@"name"` as needed.
pub fn fmtId(name: []const u8) std.fmt.Alt([]const u8, formatId) {
    return .{ .data = name };
}

fn formatId(name: []const u8, w: *std.Io.Writer) std.Io.Writer.Error!void {
    if (isPlainIdentifier(name)) {
        try w.writeAll(name);
    } else {
        try w.print("@\"{s}\"", .{name});
    }
}

// ---------------------------------------------------------------------------
// Tests: these pin down the naming schema. If you change a rule, a test here
// should change with it.

const testing = std.testing;

fn expectSnake(expected: []const u8, input: []const u8) !void {
    const got = try snakeCase(testing.allocator, input);
    defer testing.allocator.free(got);
    try testing.expectEqualStrings(expected, got);
}

test "snake_case for fields and parameters" {
    try expectSnake("s_type", "sType");
    try expectSnake("p_next", "pNext");
    try expectSnake("pp_enabled_layer_names", "ppEnabledLayerNames");
    try expectSnake("p_application_info", "pApplicationInfo");
    try expectSnake("device_id", "deviceID");
    try expectSnake("device_uuid", "deviceUUID");
    // The old translator produced `device_luidvalid` and `image2_dview_of3_dsparse`.
    try expectSnake("device_luid_valid", "deviceLUIDValid");
    try expectSnake("image2d_view_of3d_sparse", "image2DViewOf3DSparse");
    try expectSnake("sparse_residency_image2d", "sparseResidencyImage2D");
    try expectSnake("max_image_dimension1d", "maxImageDimension1D");
    try expectSnake("storage_buffer16_bit_access", "storageBuffer16BitAccess");
    try expectSnake("shader_float16", "shaderFloat16");
    try expectSnake("shader_int64", "shaderInt64");
    try expectSnake("shader_sm_builtins", "shaderSMBuiltins");
    try expectSnake("texture_compression_astc_ldr", "textureCompressionASTC_LDR");
    try expectSnake("format_a4r4g4b4", "formatA4R4G4B4");
    try expectSnake("pfn_user_callback", "pfnUserCallback");
    // Already snake_case (video.xml) stays as-is.
    try expectSnake("constraint_set0_flag", "constraint_set0_flag");
    try expectSnake("x", "x");
}

test "type and command names" {
    const a = testing.allocator;
    const cases = [_][2][]const u8{
        .{ "InstanceCreateInfo", "VkInstanceCreateInfo" },
        .{ "SurfaceKHR", "VkSurfaceKHR" },
        .{ "PfnDebugUtilsMessengerCallbackEXT", "PFN_vkDebugUtilsMessengerCallbackEXT" },
        .{ "StdVideoH264SpsFlags", "StdVideoH264SpsFlags" },
        .{ "HWND", "HWND" },
    };
    for (cases) |c| {
        const got = try typeName(a, c[1]);
        defer a.free(got);
        try testing.expectEqualStrings(c[0], got);
    }
    const cmds = [_][2][]const u8{
        .{ "createInstance", "vkCreateInstance" },
        .{ "cmdDraw", "vkCmdDraw" },
        .{ "getPhysicalDeviceSurfaceSupportKHR", "vkGetPhysicalDeviceSurfaceSupportKHR" },
    };
    for (cmds) |c| {
        const got = try commandName(a, c[1]);
        defer a.free(got);
        try testing.expectEqualStrings(c[0], got);
    }
}

test "enum value prefixes and names" {
    const a = testing.allocator;
    const tags = &default_tags;
    const cases = [_][3][]const u8{
        // type, value, expected zig name
        .{ "VkFormat", "VK_FORMAT_R8G8B8A8_UNORM", "r8g8b8a8_unorm" },
        .{ "VkFormat", "VK_FORMAT_UNDEFINED", "undefined" },
        .{ "VkStructureType", "VK_STRUCTURE_TYPE_INSTANCE_CREATE_INFO", "instance_create_info" },
        .{ "VkShaderStageFlagBits", "VK_SHADER_STAGE_VERTEX_BIT", "vertex_bit" },
        .{ "VkPipelineStageFlagBits2", "VK_PIPELINE_STAGE_2_TOP_OF_PIPE_BIT", "top_of_pipe_bit" },
        // The type's own vendor tag is dropped; a different tag is kept.
        .{ "VkPresentModeKHR", "VK_PRESENT_MODE_MAILBOX_KHR", "mailbox" },
        .{ "VkPresentModeKHR", "VK_PRESENT_MODE_FIFO_LATEST_READY_EXT", "fifo_latest_ready_ext" },
        .{ "VkCompositeAlphaFlagBitsKHR", "VK_COMPOSITE_ALPHA_OPAQUE_BIT_KHR", "opaque_bit" },
        .{ "VkResult", "VK_SUBOPTIMAL_KHR", "suboptimal_khr" },
        .{ "VkImageType", "VK_IMAGE_TYPE_2D", "2d" },
        .{ "VkSampleCountFlagBits", "VK_SAMPLE_COUNT_1_BIT", "1_bit" },
        .{ "VkResult", "VK_SUCCESS", "success" },
        .{ "VkResult", "VK_ERROR_OUT_OF_DATE_KHR", "error_out_of_date_khr" },
        .{ "VkColorSpaceKHR", "VK_COLOR_SPACE_SRGB_NONLINEAR_KHR", "srgb_nonlinear" },
        .{ "VkVideoEncodeH264CapabilityFlagBitsKHR", "VK_VIDEO_ENCODE_H264_CAPABILITY_HRD_COMPLIANCE_BIT_KHR", "hrd_compliance_bit" },
        .{ "StdVideoH264ChromaFormatIdc", "STD_VIDEO_H264_CHROMA_FORMAT_IDC_MONOCHROME", "monochrome" },
        .{ "StdVideoAV1Profile", "STD_VIDEO_AV1_PROFILE_MAIN", "main" },
    };
    for (cases) |c| {
        const n = try enumNaming(a, c[0], tags);
        defer a.free(n.prefix);
        const got = try enumFieldName(a, n, c[1]);
        defer a.free(got);
        try testing.expectEqualStrings(c[2], got);
    }
}

test "constants, errors and identifier escaping" {
    const a = testing.allocator;
    const k = try constantName(a, "VK_MAX_EXTENSION_NAME_SIZE");
    defer a.free(k);
    try testing.expectEqualStrings("max_extension_name_size", k);

    const e1 = try errorName(a, "VK_ERROR_OUT_OF_HOST_MEMORY", &default_tags);
    defer a.free(e1);
    try testing.expectEqualStrings("OutOfHostMemory", e1);
    const e2 = try errorName(a, "VK_ERROR_SURFACE_LOST_KHR", &default_tags);
    defer a.free(e2);
    try testing.expectEqualStrings("SurfaceLostKHR", e2);

    try testing.expect(isPlainIdentifier("s_type"));
    try testing.expect(!isPlainIdentifier("type"));
    try testing.expect(!isPlainIdentifier("2d"));
    try testing.expect(!isPlainIdentifier("undefined"));
    try testing.expect(!isPlainIdentifier("u8"));

    var buf: [32]u8 = undefined;
    const s = try std.fmt.bufPrint(&buf, "{f}", .{fmtId("2d")});
    try testing.expectEqualStrings("@\"2d\"", s);
}

test "vendor tags" {
    try testing.expectEqualStrings("KHR", vendorTag("SurfaceKHR", &default_tags).?);
    try testing.expectEqualStrings("AMDX", vendorTag("ExecutionGraphPipelineCreateInfoAMDX", &default_tags).?);
    try testing.expect(vendorTag("Format", &default_tags) == null);
}
