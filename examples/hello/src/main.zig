//! Smallest useful vk.zig program: load the loader, create an instance,
//! list GPUs and their queue families. No vulkan-1.lib, no headers.
const std = @import("std");
const vk = @import("vk");

pub fn main() !void {
    try vk.loadLibrary();
    defer vk.unloadLibrary();

    var loader_version: u32 = vk.api_version_1_0;
    try vk.enumerateInstanceVersion(&loader_version);
    std.debug.print("vk.zig {s}, loader supports Vulkan {d}.{d}.{d}\n", .{
        vk.version_string,
        vk.apiVersionMajor(loader_version),
        vk.apiVersionMinor(loader_version),
        vk.apiVersionPatch(loader_version),
    });

    const app_info: vk.ApplicationInfo = .{
        .p_application_name = "hello",
        .p_engine_name = "none",
        .api_version = vk.api_version_1_3,
    };
    const create_info: vk.InstanceCreateInfo = .{ .p_application_info = &app_info };

    var instance: vk.Instance = .null;
    vk.createInstance(&create_info, null, &instance) catch |err| switch (err) {
        error.IncompatibleDriver => return std.debug.print("no Vulkan 1.3 driver\n", .{}),
        else => return err,
    };
    vk.loadInstance(instance);
    defer vk.destroyInstance(instance, null);

    var count: u32 = 0;
    _ = try vk.enumeratePhysicalDevices(instance, &count, null);
    var devices: [16]vk.PhysicalDevice = undefined;
    count = @min(count, devices.len);
    _ = try vk.enumeratePhysicalDevices(instance, &count, &devices);

    for (devices[0..count]) |device| {
        var props: vk.PhysicalDeviceProperties = .{};
        vk.getPhysicalDeviceProperties(device, &props);
        std.debug.print("GPU: {s} ({t}), Vulkan {d}.{d}\n", .{
            std.mem.sliceTo(&props.device_name, 0),
            props.device_type,
            vk.apiVersionMajor(props.api_version),
            vk.apiVersionMinor(props.api_version),
        });

        var family_count: u32 = 0;
        vk.getPhysicalDeviceQueueFamilyProperties(device, &family_count, null);
        var families: [32]vk.QueueFamilyProperties = undefined;
        family_count = @min(family_count, families.len);
        vk.getPhysicalDeviceQueueFamilyProperties(device, &family_count, &families);
        for (families[0..family_count], 0..) |family, i| {
            std.debug.print("  queue family {d}: {d} queues, graphics={}, compute={}, transfer={}\n", .{
                i,
                family.queue_count,
                family.queue_flags.contains(.graphics_bit),
                family.queue_flags.contains(.compute_bit),
                family.queue_flags.contains(.transfer_bit),
            });
        }
    }
}
