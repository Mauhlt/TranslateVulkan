# TranslateVulkan

Generates a single `vk.zig` from the Khronos registry (`vk.xml` + `video.xml`),
so every Vulkan version is one command away instead of a hand-maintained port.

```sh
zig build                 # -> zig-out/vk.zig (also exported as module "vulkan")
zig build test            # naming unit tests + vk.zig checked against the C headers
zig build run-example     # create an instance and list your GPUs
zig build update          # re-pin Vulkan-Headers to the latest commit on main
zig build snapshot        # -> generated/vk-<version>.zig and generated/vk.zig
zig build compat          # rebuild consumers.zon repos against the new vk.zig, log to compat/log.md
```

Upgrading Vulkan is: `zig build update && zig build test snapshot compat`.

## Using vk.zig

Copy `generated/vk.zig` into your project, or depend on this package and import
the `vulkan` module. No `vulkan-1.lib`, no C headers: `vk.loadLibrary()` opens the
system loader at runtime.

```zig
const vk = @import("vk");

try vk.loadLibrary();
const app: vk.ApplicationInfo = .{ .p_application_name = "demo", .api_version = vk.api_version_1_3 };
var instance: vk.Instance = .null;
try vk.createInstance(&.{ .p_application_info = &app }, null, &instance);
vk.loadInstance(instance);
defer vk.destroyInstance(instance, null);
```

## Naming schema

| C                                     | Zig                                     |
|---------------------------------------|-----------------------------------------|
| `VkInstanceCreateInfo`                | `vk.InstanceCreateInfo`                 |
| `vkCreateInstance`                    | `vk.createInstance`                     |
| `pApplicationInfo`, `deviceLUIDValid` | `.p_application_info`, `.device_luid_valid` |
| `VK_FORMAT_R8G8B8A8_UNORM`            | `vk.Format.r8g8b8a8_unorm`              |
| `VK_SHADER_STAGE_VERTEX_BIT`          | `vk.ShaderStageFlagBits.vertex_bit`     |
| `VkShaderStageFlags`                  | `vk.ShaderStageFlags` = `FlagSet(ShaderStageFlagBits)` |
| `VK_MAX_EXTENSION_NAME_SIZE`          | `vk.max_extension_name_size`            |
| `VK_KHR_SWAPCHAIN_EXTENSION_NAME`     | `vk.khr_swapchain_extension_name`       |
| `VK_ERROR_OUT_OF_DATE_KHR`            | `error.OutOfDateKHR` (in `vk.Error`)    |
| `PFN_vkDebugUtilsMessengerCallbackEXT`| `vk.PfnDebugUtilsMessengerCallbackEXT`  |

The rules live in `src/naming.zig` with unit tests. `zig build test` also checks
every enum value, constant, struct layout and command signature against the C
headers, so a naming or layout mistake fails the build.

Other conventions:

- **Handles** are `enum(usize)` (dispatchable) or `enum(u64)` (non-dispatchable)
  with a `.null` value.
- **Enums** are non-exhaustive, so values from newer drivers are not illegal behavior.
- **Flags** are `FlagSet(Bits)`, with the same interface as ExternEnumSet
  (`.initMany(&.{ .a, .b })`, `.contains(.a)`, `.empty`, ...).
- **Struct fields** all have defaults (`sType` is preset), so `.{}` works.
- **Commands** return `Error!void`, or `Error!Result` when they have status codes
  such as `.suboptimal_khr`.

## Keeping consumers working

`consumers.zon` lists repos that use vk.zig. `zig build compat` copies each one to
`.zig-cache/compat/`, builds it untouched (the baseline), swaps in the new vk.zig,
builds again, and appends the outcome to `compat/log.md`:

- `pass`: it works.
- `**FAIL**`: this version broke it. Pin it with `.pin = "<old version>"` and keep
  using `generated/vk-<old version>.zig`.
- `already failing`: it fails without the new vk.zig too.

Your repos are never modified.

## Layout

| file                     | role                                                  |
|--------------------------|-------------------------------------------------------|
| `src/xml.zig`            | minimal XML DOM parser                                 |
| `src/registry.zig`       | XML → typed model; selects what the `vulkan` API needs |
| `src/naming.zig`         | the naming schema (+ tests)                            |
| `src/render.zig`         | model → vk.zig + test files                            |
| `src/preamble.zig`       | hand-written part of vk.zig (FlagSet, loader, Bool32)  |
| `src/test_preamble.zig`  | hand-written part of the generated C-comparison test   |
| `src/compat.zig`         | consumer compatibility checker                         |
| `src/main.zig`           | `vkgen` CLI                                            |
| `legacy/`                | the previous translate-c based translator (history kept) |
