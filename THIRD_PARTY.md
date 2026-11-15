# Third-party material

TranslateVulkan's own code (the generator in `src/`, the example) is under the
MIT licence in [LICENSE](LICENSE).

## Khronos Vulkan registry and headers

- What: the Vulkan API registry (`registry/vk.xml`, `registry/video.xml`) and
  the C headers from Khronos' Vulkan-Headers
  (<https://github.com/KhronosGroup/Vulkan-Headers>), Copyright (c) The
  Khronos Group Inc., licensed `Apache-2.0 OR MIT` (see that repository's
  LICENSE.md and the SPDX lines in the files).
- How it is used: fetched at build time (pinned in `build.zig.zon`, dependency
  `vulkan_headers`); nothing from it is vendored. `vkgen` reads the registry
  to generate `vk.zig`, and `zig build test` compiles the C headers to check
  the generated bindings against them.
- Generated files in this repository: `generated/vk.zig`,
  `generated/vk-<version>.zig` and `examples/hello/src/vk.zig` are produced
  from the Khronos registry (type, command, enum and constant names, values
  and layouts). Treat them as derived from the registry: when redistributing
  them, keep the Khronos copyright and the `Apache-2.0 OR MIT` notice with
  them (this file serves as that notice here).

## Vulkan loader and MoltenVK

`vk.loadLibrary()` opens the system's Vulkan loader (`vulkan-1.dll`,
`libvulkan.so.1`, `libvulkan.1.dylib`) or MoltenVK at run time. None of them
is vendored or linked. The Khronos loader is Apache-2.0; MoltenVK is
Apache-2.0; an application that bundles MoltenVK (e.g. on iOS) carries its
licence.
