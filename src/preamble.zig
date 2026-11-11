// ---------------------------------------------------------------------------
// Hand-written support code. This text (src/preamble.zig in TranslateVulkan) is
// spliced verbatim into the generated vk.zig; it is not compiled on its own.
// ---------------------------------------------------------------------------

pub fn makeApiVersion(variant: u3, major: u7, minor: u10, patch: u12) u32 {
    return (@as(u32, variant) << 29) | (@as(u32, major) << 22) | (@as(u32, minor) << 12) | @as(u32, patch);
}
pub fn apiVersionVariant(version: u32) u3 {
    return @truncate(version >> 29);
}
pub fn apiVersionMajor(version: u32) u7 {
    return @truncate(version >> 22);
}
pub fn apiVersionMinor(version: u32) u10 {
    return @truncate(version >> 12);
}
pub fn apiVersionPatch(version: u32) u12 {
    return @truncate(version);
}

/// A set of `Bits` flags with the exact ABI of the C `VkFlags`/`VkFlags64`
/// integer. Same interface as ExternEnumSet:
///     const usage: vk.ImageUsageFlags = .initMany(&.{ .color_attachment_bit, .transfer_dst_bit });
///     if (usage.contains(.transfer_dst_bit)) ...
pub fn FlagSet(comptime Bits: type) type {
    const Int = @typeInfo(Bits).@"enum".tag_type;
    return extern struct {
        const Self = @This();
        pub const Key = Bits;

        bits: Int = 0,

        pub const empty: Self = .{};
        pub const full: Self = .{ .bits = ~@as(Int, 0) };

        pub fn init(key: Key) Self {
            return .{ .bits = @backingInt(key) };
        }
        pub fn initMany(keys: []const Key) Self {
            var self: Self = .empty;
            for (keys) |key| self.set(key);
            return self;
        }
        pub fn fromInt(bits: Int) Self {
            return .{ .bits = bits };
        }
        pub fn toInt(self: Self) Int {
            return self.bits;
        }
        pub fn count(self: Self) usize {
            return @popCount(self.bits);
        }
        pub fn isEmpty(self: Self) bool {
            return self.bits == 0;
        }
        /// True if every bit of `key` is set (multi-bit keys such as `all_graphics` work too).
        pub fn contains(self: Self, key: Key) bool {
            return (self.bits & @backingInt(key)) == @backingInt(key);
        }
        pub fn contain(self: Self, keys: []const Key) bool {
            for (keys) |key| if (!self.contains(key)) return false;
            return true;
        }
        pub fn set(self: *Self, key: Key) void {
            self.bits |= @backingInt(key);
        }
        pub fn unset(self: *Self, key: Key) void {
            self.bits &= ~@backingInt(key);
        }
        /// Non-mutating `set`, handy in initializers: `.init(.a).with(.b)`.
        pub fn with(self: Self, key: Key) Self {
            return .{ .bits = self.bits | @backingInt(key) };
        }
        pub fn eql(self: Self, other: Self) bool {
            return self.bits == other.bits;
        }
        pub fn isSubsetOf(self: Self, other: Self) bool {
            return (self.bits & other.bits) == self.bits;
        }
        pub fn isSupersetOf(self: Self, other: Self) bool {
            return other.isSubsetOf(self);
        }
        pub fn intersectsWith(self: Self, other: Self) Self {
            return .{ .bits = self.bits & other.bits };
        }
        pub fn unionWith(self: Self, other: Self) Self {
            return .{ .bits = self.bits | other.bits };
        }
        pub fn setUnion(self: *Self, other: Self) void {
            self.bits |= other.bits;
        }
        pub fn setIntersection(self: *Self, other: Self) void {
            self.bits &= other.bits;
        }
    };
}

/// Every command has a slot here. Slots start null and are filled by
/// `loadLibrary`/`loadBase`, `loadInstance` and `loadDevice`.
pub var dispatch: Dispatch = .{};

pub const CommandEntry = struct {
    name: [:0]const u8,
    /// Older (usually extension) entry point names tried if `name` is not found.
    aliases: []const [:0]const u8 = &.{},
};

fn unloaded(comptime name: []const u8) noreturn {
    @panic("Vulkan command " ++ name ++ " is not loaded: call vk.loadLibrary()/loadInstance()/loadDevice(), " ++
        "and make sure the extension or API version that provides it is enabled.");
}

fn checkSuccess(result: Result) Error!void {
    _ = try result.check();
}

pub const LoadLibraryError = error{ VulkanLibraryNotFound, MissingGetInstanceProcAddr };

/// Minimal cross-platform shared-library loader (std.DynLib has no Windows
/// backend in every Zig version).
const Library = if (builtin.os.tag == .windows) struct {
    handle: *anyopaque,

    extern "kernel32" fn LoadLibraryA(name: [*:0]const u8) callconv(.winapi) ?*anyopaque;
    extern "kernel32" fn GetProcAddress(module: *anyopaque, name: [*:0]const u8) callconv(.winapi) ?*anyopaque;
    extern "kernel32" fn FreeLibrary(module: *anyopaque) callconv(.winapi) c_int;

    fn open(name: [:0]const u8) ?@This() {
        return .{ .handle = LoadLibraryA(name) orelse return null };
    }
    fn lookup(self: @This(), comptime T: type, name: [:0]const u8) ?T {
        return @ptrCast(GetProcAddress(self.handle, name) orelse return null);
    }
    fn close(self: @This()) void {
        _ = FreeLibrary(self.handle);
    }
} else struct {
    lib: std.DynLib,

    fn open(name: [:0]const u8) ?@This() {
        return .{ .lib = std.DynLib.open(name) catch return null };
    }
    fn lookup(self: *@This(), comptime T: type, name: [:0]const u8) ?T {
        return self.lib.lookup(T, name);
    }
    fn close(self: *@This()) void {
        self.lib.close();
    }
};

var library: ?Library = null;

/// Opens the system Vulkan loader (vulkan-1.dll / libvulkan.so.1 /
/// libvulkan.1.dylib) and loads the global commands. No link step needed.
pub fn loadLibrary() LoadLibraryError!void {
    const names: []const [:0]const u8 = switch (builtin.os.tag) {
        .windows => &.{"vulkan-1.dll"},
        .macos, .ios, .tvos, .visionos => &.{ "libvulkan.1.dylib", "libvulkan.dylib", "libMoltenVK.dylib" },
        else => &.{ "libvulkan.so.1", "libvulkan.so" },
    };
    for (names) |name| {
        var lib = Library.open(name) orelse continue;
        const gipa = lib.lookup(PfnGetInstanceProcAddr, "vkGetInstanceProcAddr") orelse {
            lib.close();
            return error.MissingGetInstanceProcAddr;
        };
        library = lib;
        loadBase(gipa);
        return;
    }
    return error.VulkanLibraryNotFound;
}

pub fn unloadLibrary() void {
    if (library) |*lib| lib.close();
    library = null;
    dispatch = .{};
}

/// Loads the global commands (createInstance, enumerateInstance*...) through
/// `get_instance_proc_addr`, e.g. `glfwGetInstanceProcAddress` or the loader's.
pub fn loadBase(get_instance_proc_addr: PfnGetInstanceProcAddr) void {
    dispatch.vkGetInstanceProcAddr = get_instance_proc_addr;
    inline for (global_commands) |entry| loadEntry(entry, get_instance_proc_addr, .null);
}

/// Loads instance-level commands, and device-level commands as loader
/// trampolines (so device calls work even before `loadDevice`).
pub fn loadInstance(instance: Instance) void {
    const gipa = dispatch.vkGetInstanceProcAddr orelse unloaded("vkGetInstanceProcAddr");
    inline for (instance_commands) |entry| loadEntry(entry, gipa, instance);
    inline for (device_commands) |entry| loadEntry(entry, gipa, instance);
}

/// Reloads device-level commands straight from the driver for `device`
/// (skips the loader trampoline). With several devices, prefer one
/// `Dispatch` per device and call through it directly.
pub fn loadDevice(device: Device) void {
    const gdpa = dispatch.vkGetDeviceProcAddr orelse unloaded("vkGetDeviceProcAddr");
    inline for (device_commands) |entry| {
        var ptr = gdpa(device, entry.name.ptr);
        inline for (entry.aliases) |alias| {
            if (ptr == null) ptr = gdpa(device, alias.ptr);
        }
        if (ptr != null) @field(dispatch, entry.name) = @ptrCast(ptr);
    }
}

fn loadEntry(comptime entry: CommandEntry, gipa: PfnGetInstanceProcAddr, instance: Instance) void {
    var ptr = gipa(instance, entry.name.ptr);
    inline for (entry.aliases) |alias| {
        if (ptr == null) ptr = gipa(instance, alias.ptr);
    }
    @field(dispatch, entry.name) = @ptrCast(ptr);
}

pub const Bool32 = enum(u32) {
    false = 0,
    true = 1,
    _,

    pub fn from(value: bool) Bool32 {
        return if (value) .true else .false;
    }
    pub fn toBool(self: Bool32) bool {
        return self != .false;
    }
};

// ---------------------------------------------------------------------------
// Generated from the registry below.
// ---------------------------------------------------------------------------
