# Consumer compatibility log

Appended by `zig build compat`. Newest entries at the bottom.

## 2026-11-11 05:59 UTC: vk.zig 1.4.368

| consumer | result | pin | action |
|---|---|---|---|
| hello-example | pass | latest | ok |

## 2026-11-11 06:17 UTC: vk.zig 1.4.368

| consumer | result | pin | action |
|---|---|---|---|
| hello-example | pass | latest | ok |

## 2026-11-11 06:41 UTC: vk.zig 1.4.368

| consumer | result | pin | action |
|---|---|---|---|
| hello-example | pass | latest | ok |
| Image | pass | latest | ok |
| Renderer | already failing | latest | fails without the new vk.zig too: not caused by it |

<details><summary>Renderer: zig build</summary>

```
install
+- install Renderer
   +- compile exe Renderer debug native 1 errors
src\Renderer2D.zig:165:12: error: root source file struct 'vk' has no member named 'ExtensionName'
        vk.ExtensionName.win32_surface,
           ^~~~~~~~~~~~~
_vk_package\src\vk.zig:1:1: note: struct declared here
//! Vulkan 1.4.368 bindings for Zig.
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
referenced by:
    run: src\Renderer2D.zig:133:24
    main: src\main.zig:14:16
    4 reference(s) hidden; use '-freference-trace=6' to see all references
error: 1 compilation errors
failed command: "C:\\Users\\bphil\\Code\\Zig\\ZVC\\.zvc\\versions\\0.18.0-dev.4+5a23bf4b2\\zig-x86_64-windows-0.18.0-dev.4+5a23bf4b2\\zig.exe" build-exe -lvulkan-1 -lkernel32 -luser32 -Odebug -I "Vulkan\\Include" -L "Vulkan\\Lib" --dep Windows --dep Vulkan --dep Image "-Mroot=src\\main.zig" -Odebug "-MWindows=../../../../Windows\\src\\root.zig" --dep Windows "-MVulkan=_vk_package\\src\\vk.zig" --dep Vulkan --dep Windows "-MImage=../../../../Image\\src\\root.zig" -lc --cache-dir .zig-cache --global-cache-dir "C:\\Users\\bphil\\AppData\\Local\\zig" --build-root . --name Renderer --zig-lib-dir "C:\\Users\\bphil\\Code\\Zig\\ZVC\\.zvc\\versions\\0.18.0-dev.4+5a23bf4b2\\zig-x86_64-windows-0.18.0-dev.4+5a23bf4b2\\lib\\" --listen=-

Build Summary: 5/8 steps succeeded (1 failed)
install transitive failure
+- install Renderer transitive failure
   +- compile exe Renderer debug native 1 errors

error: the following build command exited with code 1:
C:\Users\bphil\AppData\Local\zig\o\377017191b11177bb48c6a4d07eef27d\maker.exe build --zig-lib=C:\Users\bphil\Code\Zig\ZVC\.zvc\versions\0.18.0-dev.4+5a23bf4b2\zig-x86_64-windows-0.18.0-dev.4+5a23bf4b2\lib --zig=C:\Users\bphil\Code\Zig\ZVC\.zvc\versions\0.18.0-dev.4+5a23bf4b2\zig-x86_64-windows-0.18.0-dev.4+5a23bf4b2\zig.exe --global-cache=C:\Users\bphil\AppData\Local\zig --seed=0x3611223a
```
</details>

## 2026-11-11 07:10 UTC: vk.zig 1.4.368

| consumer | result | pin | action |
|---|---|---|---|
| hello-example | pass | latest | ok |
| Image | pass | latest | ok |
| Renderer | pass | latest | ok |

## 2026-11-11 07:22 UTC: vk.zig 1.4.368

| consumer | result | pin | action |
|---|---|---|---|
| hello-example | pass | latest | ok |
| Image | pass | latest | ok |
| Renderer | pass | latest | ok |
