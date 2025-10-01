inline fn VK_MAKE_API_VERSION(variant: anytype, major: anytype, minor: anytype, patch: anytype) @TypeOf((((@import("std").zig.c_translation.cast(u32, variant) << @as(c_uint, 29)) | (@import("std").zig.c_translation.cast(u32, major) << @as(c_uint, 22))) | (@import("std").zig.c_translation.cast(u32, minor) << @as(c_uint, 12))) | @import("std").zig.c_translation.cast(u32, patch)) {
    _ = &variant;
    _ = &major;
    _ = &minor;
    _ = &patch;
    return (((@import("std").zig.c_translation.cast(u32, variant) << @as(c_uint, 29)) | (@import("std").zig.c_translation.cast(u32, major) << @as(c_uint, 22))) | (@import("std").zig.c_translation.cast(u32, minor) << @as(c_uint, 12))) | @import("std").zig.c_translation.cast(u32, patch);
}
pub const makeApiVersion = VK_MAKE_API_VERSION;
inline fn VK_MAKE_VERSION(major: anytype, minor: anytype, patch: anytype) @TypeOf(((@import("std").zig.c_translation.cast(u32, major) << @as(c_uint, 22)) | (@import("std").zig.c_translation.cast(u32, minor) << @as(c_uint, 12))) | @import("std").zig.c_translation.cast(u32, patch)) {
    _ = &major;
    _ = &minor;
    _ = &patch;
    return ((@import("std").zig.c_translation.cast(u32, major) << @as(c_uint, 22)) | (@import("std").zig.c_translation.cast(u32, minor) << @as(c_uint, 12))) | @import("std").zig.c_translation.cast(u32, patch);
}
pub const makeVersion = VK_MAKE_VERSION;
inline fn VK_VERSION_MAJOR(version: anytype) @TypeOf(@import("std").zig.c_translation.cast(u32, version) >> @as(c_uint, 22)) {
    _ = &version;
    return @import("std").zig.c_translation.cast(u32, version) >> @as(c_uint, 22);
}
pub const versionMajor = VK_VERSION_MAJOR;
inline fn VK_VERSION_MINOR(version: anytype) @TypeOf((@import("std").zig.c_translation.cast(u32, version) >> @as(c_uint, 12)) & @as(c_uint, 0x3FF)) {
    _ = &version;
    return (@import("std").zig.c_translation.cast(u32, version) >> @as(c_uint, 12)) & @as(c_uint, 0x3FF);
}
pub const versionMinor = VK_VERSION_MINOR;
inline fn VK_VERSION_PATCH(version: anytype) @TypeOf(@import("std").zig.c_translation.cast(u32, version) & @as(c_uint, 0xFFF)) {
    _ = &version;
    return @import("std").zig.c_translation.cast(u32, version) & @as(c_uint, 0xFFF);
}
pub const versionPatch = VK_VERSION_PATCH;
inline fn VK_API_VERSION_VARIANT(version: anytype) @TypeOf(@import("std").zig.c_translation.cast(u32, version) >> @as(c_uint, 29)) {
    _ = &version;
    return @import("std").zig.c_translation.cast(u32, version) >> @as(c_uint, 29);
}
pub const apiVersionVariant = VK_API_VERSION_VARIANT;
inline fn VK_API_VERSION_MAJOR(version: anytype) @TypeOf((@import("std").zig.c_translation.cast(u32, version) >> @as(c_uint, 22)) & @as(c_uint, 0x7F)) {
    _ = &version;
    return (@import("std").zig.c_translation.cast(u32, version) >> @as(c_uint, 22)) & @as(c_uint, 0x7F);
}
pub const apiVersionMajor = VK_API_VERSION_MAJOR;
inline fn VK_API_VERSION_MINOR(version: anytype) @TypeOf((@import("std").zig.c_translation.cast(u32, version) >> @as(c_uint, 12)) & @as(c_uint, 0x3FF)) {
    _ = &version;
    return (@import("std").zig.c_translation.cast(u32, version) >> @as(c_uint, 12)) & @as(c_uint, 0x3FF);
}
pub const apiVersionMinor = VK_API_VERSION_MINOR;
inline fn VK_API_VERSION_PATCH(version: anytype) @TypeOf(@import("std").zig.c_translation.cast(u32, version) & @as(c_uint, 0xFFF)) {
    _ = &version;
    return @import("std").zig.c_translation.cast(u32, version) & @as(c_uint, 0xFFF);
}
pub const apiVersionPatch = VK_API_VERSION_PATCH;
inline fn VK_MAKE_VIDEO_STD_VERSION(major: anytype, minor: anytype, patch: anytype) @TypeOf(((@import("std").zig.c_translation.cast(u32, major) << @as(c_int, 22)) | (@import("std").zig.c_translation.cast(u32, minor) << @as(c_int, 12))) | @import("std").zig.c_translation.cast(u32, patch)) {
    _ = &major;
    _ = &minor;
    _ = &patch;
    return ((@import("std").zig.c_translation.cast(u32, major) << @as(c_int, 22)) | (@import("std").zig.c_translation.cast(u32, minor) << @as(c_int, 12))) | @import("std").zig.c_translation.cast(u32, patch);
}
pub const makeVideoStdVersion = VK_MAKE_VIDEO_STD_VERSION;
