# Translate Vulkan
- Translates vulkan.h into vulkan directory
- Each folder in vulkan directory contains a specific vulkan type
- vulkan/vulkan.zig = main fn with list of all variables = public interface 

- Extern fns not found:
- need to copy them as is?

- Position:
    - contains buffer + position - may want to rename to buffer
    - added reset + init + copy methods
    - need to fix the call inside extern struct - leads to undefined behavior outside
    - need to finish extern struct + extern union -> store the files -> create the engine next
