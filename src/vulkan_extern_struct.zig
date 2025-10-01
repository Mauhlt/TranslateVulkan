pub const Extent2D = extern struct {
    width: u32 = @import("std").mem.zeroes(u32),
    height: u32 = @import("std").mem.zeroes(u32),
};
pub const Extent3D = extern struct {
    width: u32 = @import("std").mem.zeroes(u32),
    height: u32 = @import("std").mem.zeroes(u32),
    depth: u32 = @import("std").mem.zeroes(u32),
};
pub const Offset2D = extern struct {
    x: i32 = @import("std").mem.zeroes(i32),
    y: i32 = @import("std").mem.zeroes(i32),
};
pub const Offset3D = extern struct {
    x: i32 = @import("std").mem.zeroes(i32),
    y: i32 = @import("std").mem.zeroes(i32),
    z: i32 = @import("std").mem.zeroes(i32),
};
pub const Rect2D = extern struct {
    offset: Offset2D = @import("std").mem.zeroes(Offset2D),
    extent: Extent2D = @import("std").mem.zeroes(Extent2D),
};
pub const BaseInStructure = extern struct {
    s_type: StructureType = .base_in_structure,
    p_next: [*c]const BaseInStructure = null,
};
pub const BaseOutStructure = extern struct {
    s_type: StructureType = .base_out_structure,
    p_next: [*c]BaseOutStructure = null,
};
pub const BufferMemoryBarrier = extern struct {
    s_type: StructureType = .buffer_memory_barrier,
    p_next: ?*const anyopaque = null,
    src_access_mask: AccessFlags = @import("std").mem.zeroes(AccessFlags),
    dst_access_mask: AccessFlags = @import("std").mem.zeroes(AccessFlags),
    src_queue_family_index: u32 = @import("std").mem.zeroes(u32),
    dst_queue_family_index: u32 = @import("std").mem.zeroes(u32),
    buffer: Buffer = @import("std").mem.zeroes(Buffer),
    offset: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    size: DeviceSize = @import("std").mem.zeroes(DeviceSize),
};
pub const DispatchIndirectCommand = extern struct {
    x: u32 = @import("std").mem.zeroes(u32),
    y: u32 = @import("std").mem.zeroes(u32),
    z: u32 = @import("std").mem.zeroes(u32),
};
pub const DrawIndexedIndirectCommand = extern struct {
    index_count: u32 = @import("std").mem.zeroes(u32),
    instance_count: u32 = @import("std").mem.zeroes(u32),
    first_index: u32 = @import("std").mem.zeroes(u32),
    vertex_offset: i32 = @import("std").mem.zeroes(i32),
    first_instance: u32 = @import("std").mem.zeroes(u32),
};
pub const DrawIndirectCommand = extern struct {
    vertex_count: u32 = @import("std").mem.zeroes(u32),
    instance_count: u32 = @import("std").mem.zeroes(u32),
    first_vertex: u32 = @import("std").mem.zeroes(u32),
    first_instance: u32 = @import("std").mem.zeroes(u32),
};
pub const ImageSubresourceRange = extern struct {
    aspect_mask: ImageAspectFlags = @import("std").mem.zeroes(ImageAspectFlags),
    base_mip_level: u32 = @import("std").mem.zeroes(u32),
    level_count: u32 = @import("std").mem.zeroes(u32),
    base_array_layer: u32 = @import("std").mem.zeroes(u32),
    layer_count: u32 = @import("std").mem.zeroes(u32),
};
pub const ImageMemoryBarrier = extern struct {
    s_type: StructureType = .image_memory_barrier,
    p_next: ?*const anyopaque = null,
    src_access_mask: AccessFlags = @import("std").mem.zeroes(AccessFlags),
    dst_access_mask: AccessFlags = @import("std").mem.zeroes(AccessFlags),
    old_layout: ImageLayout = @import("std").mem.zeroes(ImageLayout),
    new_layout: ImageLayout = @import("std").mem.zeroes(ImageLayout),
    src_queue_family_index: u32 = @import("std").mem.zeroes(u32),
    dst_queue_family_index: u32 = @import("std").mem.zeroes(u32),
    image: Image = @import("std").mem.zeroes(Image),
    subresource_range: ImageSubresourceRange = @import("std").mem.zeroes(ImageSubresourceRange),
};
pub const MemoryBarrier = extern struct {
    s_type: StructureType = .memory_barrier,
    p_next: ?*const anyopaque = null,
    src_access_mask: AccessFlags = @import("std").mem.zeroes(AccessFlags),
    dst_access_mask: AccessFlags = @import("std").mem.zeroes(AccessFlags),
};
pub const PipelineCacheHeaderVersionOne = extern struct {
    header_size: u32 = @import("std").mem.zeroes(u32),
    header_version: PipelineCacheHeaderVersion = @import("std").mem.zeroes(PipelineCacheHeaderVersion),
    vendor_id: u32 = @import("std").mem.zeroes(u32),
    device_id: u32 = @import("std").mem.zeroes(u32),
    pipeline_cache_uuid: [16]u8 = @import("std").mem.zeroes([16]u8),
};
pub const AllocationCallbacks = extern struct {
    p_user_data: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
    pfn_allocation: PFN_vkAllocationFunction = @import("std").mem.zeroes(PFN_vkAllocationFunction),
    pfn_reallocation: PFN_vkReallocationFunction = @import("std").mem.zeroes(PFN_vkReallocationFunction),
    pfn_free: PFN_vkFreeFunction = @import("std").mem.zeroes(PFN_vkFreeFunction),
    pfn_internal_allocation: PFN_vkInternalAllocationNotification = @import("std").mem.zeroes(PFN_vkInternalAllocationNotification),
    pfn_internal_free: PFN_vkInternalFreeNotification = @import("std").mem.zeroes(PFN_vkInternalFreeNotification),
};
pub const ApplicationInfo = extern struct {
    s_type: StructureType = .application_info,
    p_next: ?*const anyopaque = null,
    p_application_name: [*c]const u8 = @import("std").mem.zeroes([*c]const u8),
    application_version: u32 = @import("std").mem.zeroes(u32),
    p_engine_name: [*c]const u8 = @import("std").mem.zeroes([*c]const u8),
    engine_version: u32 = @import("std").mem.zeroes(u32),
    api_version: u32 = @import("std").mem.zeroes(u32),
};
pub const FormatProperties = extern struct {
    linear_tiling_features: FormatFeatureFlags = @import("std").mem.zeroes(FormatFeatureFlags),
    optimal_tiling_features: FormatFeatureFlags = @import("std").mem.zeroes(FormatFeatureFlags),
    buffer_features: FormatFeatureFlags = @import("std").mem.zeroes(FormatFeatureFlags),
};
pub const ImageFormatProperties = extern struct {
    max_extent: Extent3D = @import("std").mem.zeroes(Extent3D),
    max_mip_levels: u32 = @import("std").mem.zeroes(u32),
    max_array_layers: u32 = @import("std").mem.zeroes(u32),
    sample_counts: SampleCountFlags = @import("std").mem.zeroes(SampleCountFlags),
    max_resource_size: DeviceSize = @import("std").mem.zeroes(DeviceSize),
};
pub const InstanceCreateInfo = extern struct {
    s_type: StructureType = .instance_create_info,
    p_next: ?*const anyopaque = null,
    flags: InstanceCreateFlags = @import("std").mem.zeroes(InstanceCreateFlags),
    p_application_info: [*c]const ApplicationInfo = @import("std").mem.zeroes([*c]const ApplicationInfo),
    enabled_layer_count: u32 = @import("std").mem.zeroes(u32),
    pp_enabled_layer_names: [*c]const [*c]const u8 = @import("std").mem.zeroes([*c]const [*c]const u8),
    enabled_extension_count: u32 = @import("std").mem.zeroes(u32),
    pp_enabled_extension_names: [*c]const [*c]const u8 = @import("std").mem.zeroes([*c]const [*c]const u8),
};
pub const MemoryHeap = extern struct {
    size: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    flags: MemoryHeapFlags = @import("std").mem.zeroes(MemoryHeapFlags),
};
pub const MemoryType = extern struct {
    property_flags: MemoryPropertyFlags = @import("std").mem.zeroes(MemoryPropertyFlags),
    heap_index: u32 = @import("std").mem.zeroes(u32),
};
pub const PhysicalDeviceFeatures = extern struct {
    robust_buffer_access: Bool32 = @import("std").mem.zeroes(Bool32),
    full_draw_index_uint32: Bool32 = @import("std").mem.zeroes(Bool32),
    image_cube_array: Bool32 = @import("std").mem.zeroes(Bool32),
    independent_blend: Bool32 = @import("std").mem.zeroes(Bool32),
    geometry_shader: Bool32 = @import("std").mem.zeroes(Bool32),
    tessellation_shader: Bool32 = @import("std").mem.zeroes(Bool32),
    sample_rate_shading: Bool32 = @import("std").mem.zeroes(Bool32),
    dual_src_blend: Bool32 = @import("std").mem.zeroes(Bool32),
    logic_op: Bool32 = @import("std").mem.zeroes(Bool32),
    multi_draw_indirect: Bool32 = @import("std").mem.zeroes(Bool32),
    draw_indirect_first_instance: Bool32 = @import("std").mem.zeroes(Bool32),
    depth_clamp: Bool32 = @import("std").mem.zeroes(Bool32),
    depth_bias_clamp: Bool32 = @import("std").mem.zeroes(Bool32),
    fill_mode_non_solid: Bool32 = @import("std").mem.zeroes(Bool32),
    depth_bounds: Bool32 = @import("std").mem.zeroes(Bool32),
    wide_lines: Bool32 = @import("std").mem.zeroes(Bool32),
    large_points: Bool32 = @import("std").mem.zeroes(Bool32),
    alpha_to_one: Bool32 = @import("std").mem.zeroes(Bool32),
    multi_viewport: Bool32 = @import("std").mem.zeroes(Bool32),
    sampler_anisotropy: Bool32 = @import("std").mem.zeroes(Bool32),
    texture_compression_etc2: Bool32 = @import("std").mem.zeroes(Bool32),
    texture_compression_astc_ldr: Bool32 = @import("std").mem.zeroes(Bool32),
    texture_compression_bc: Bool32 = @import("std").mem.zeroes(Bool32),
    occlusion_query_precise: Bool32 = @import("std").mem.zeroes(Bool32),
    pipeline_statistics_query: Bool32 = @import("std").mem.zeroes(Bool32),
    vertex_pipeline_stores_and_atomics: Bool32 = @import("std").mem.zeroes(Bool32),
    fragment_stores_and_atomics: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_tessellation_and_geometry_point_size: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_image_gather_extended: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_storage_image_extended_formats: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_storage_image_multisample: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_storage_image_read_without_format: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_storage_image_write_without_format: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_uniform_buffer_array_dynamic_indexing: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_sampled_image_array_dynamic_indexing: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_storage_buffer_array_dynamic_indexing: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_storage_image_array_dynamic_indexing: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_clip_distance: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_cull_distance: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_float64: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_int64: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_int16: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_resource_residency: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_resource_min_lod: Bool32 = @import("std").mem.zeroes(Bool32),
    sparse_binding: Bool32 = @import("std").mem.zeroes(Bool32),
    sparse_residency_buffer: Bool32 = @import("std").mem.zeroes(Bool32),
    sparse_residency_image2_d: Bool32 = @import("std").mem.zeroes(Bool32),
    sparse_residency_image3_d: Bool32 = @import("std").mem.zeroes(Bool32),
    sparse_residency2samples: Bool32 = @import("std").mem.zeroes(Bool32),
    sparse_residency4samples: Bool32 = @import("std").mem.zeroes(Bool32),
    sparse_residency8samples: Bool32 = @import("std").mem.zeroes(Bool32),
    sparse_residency16_samples: Bool32 = @import("std").mem.zeroes(Bool32),
    sparse_residency_aliased: Bool32 = @import("std").mem.zeroes(Bool32),
    variable_multisample_rate: Bool32 = @import("std").mem.zeroes(Bool32),
    inherited_queries: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceLimits = extern struct {
    max_image_dimension1d: u32 = @import("std").mem.zeroes(u32),
    max_image_dimension2_d: u32 = @import("std").mem.zeroes(u32),
    max_image_dimension3_d: u32 = @import("std").mem.zeroes(u32),
    max_image_dimension_cube: u32 = @import("std").mem.zeroes(u32),
    max_image_array_layers: u32 = @import("std").mem.zeroes(u32),
    max_texel_buffer_elements: u32 = @import("std").mem.zeroes(u32),
    max_uniform_buffer_range: u32 = @import("std").mem.zeroes(u32),
    max_storage_buffer_range: u32 = @import("std").mem.zeroes(u32),
    max_push_constants_size: u32 = @import("std").mem.zeroes(u32),
    max_memory_allocation_count: u32 = @import("std").mem.zeroes(u32),
    max_sampler_allocation_count: u32 = @import("std").mem.zeroes(u32),
    buffer_image_granularity: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    sparse_address_space_size: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    max_bound_descriptor_sets: u32 = @import("std").mem.zeroes(u32),
    max_per_stage_descriptor_samplers: u32 = @import("std").mem.zeroes(u32),
    max_per_stage_descriptor_uniform_buffers: u32 = @import("std").mem.zeroes(u32),
    max_per_stage_descriptor_storage_buffers: u32 = @import("std").mem.zeroes(u32),
    max_per_stage_descriptor_sampled_images: u32 = @import("std").mem.zeroes(u32),
    max_per_stage_descriptor_storage_images: u32 = @import("std").mem.zeroes(u32),
    max_per_stage_descriptor_input_attachments: u32 = @import("std").mem.zeroes(u32),
    max_per_stage_resources: u32 = @import("std").mem.zeroes(u32),
    max_descriptor_set_samplers: u32 = @import("std").mem.zeroes(u32),
    max_descriptor_set_uniform_buffers: u32 = @import("std").mem.zeroes(u32),
    max_descriptor_set_uniform_buffers_dynamic: u32 = @import("std").mem.zeroes(u32),
    max_descriptor_set_storage_buffers: u32 = @import("std").mem.zeroes(u32),
    max_descriptor_set_storage_buffers_dynamic: u32 = @import("std").mem.zeroes(u32),
    max_descriptor_set_sampled_images: u32 = @import("std").mem.zeroes(u32),
    max_descriptor_set_storage_images: u32 = @import("std").mem.zeroes(u32),
    max_descriptor_set_input_attachments: u32 = @import("std").mem.zeroes(u32),
    max_vertex_input_attributes: u32 = @import("std").mem.zeroes(u32),
    max_vertex_input_bindings: u32 = @import("std").mem.zeroes(u32),
    max_vertex_input_attribute_offset: u32 = @import("std").mem.zeroes(u32),
    max_vertex_input_binding_stride: u32 = @import("std").mem.zeroes(u32),
    max_vertex_output_components: u32 = @import("std").mem.zeroes(u32),
    max_tessellation_generation_level: u32 = @import("std").mem.zeroes(u32),
    max_tessellation_patch_size: u32 = @import("std").mem.zeroes(u32),
    max_tessellation_control_per_vertex_input_components: u32 = @import("std").mem.zeroes(u32),
    max_tessellation_control_per_vertex_output_components: u32 = @import("std").mem.zeroes(u32),
    max_tessellation_control_per_patch_output_components: u32 = @import("std").mem.zeroes(u32),
    max_tessellation_control_total_output_components: u32 = @import("std").mem.zeroes(u32),
    max_tessellation_evaluation_input_components: u32 = @import("std").mem.zeroes(u32),
    max_tessellation_evaluation_output_components: u32 = @import("std").mem.zeroes(u32),
    max_geometry_shader_invocations: u32 = @import("std").mem.zeroes(u32),
    max_geometry_input_components: u32 = @import("std").mem.zeroes(u32),
    max_geometry_output_components: u32 = @import("std").mem.zeroes(u32),
    max_geometry_output_vertices: u32 = @import("std").mem.zeroes(u32),
    max_geometry_total_output_components: u32 = @import("std").mem.zeroes(u32),
    max_fragment_input_components: u32 = @import("std").mem.zeroes(u32),
    max_fragment_output_attachments: u32 = @import("std").mem.zeroes(u32),
    max_fragment_dual_src_attachments: u32 = @import("std").mem.zeroes(u32),
    max_fragment_combined_output_resources: u32 = @import("std").mem.zeroes(u32),
    max_compute_shared_memory_size: u32 = @import("std").mem.zeroes(u32),
    max_compute_work_group_count: [3]u32 = @import("std").mem.zeroes([3]u32),
    max_compute_work_group_invocations: u32 = @import("std").mem.zeroes(u32),
    max_compute_work_group_size: [3]u32 = @import("std").mem.zeroes([3]u32),
    sub_pixel_precision_bits: u32 = @import("std").mem.zeroes(u32),
    sub_texel_precision_bits: u32 = @import("std").mem.zeroes(u32),
    mipmap_precision_bits: u32 = @import("std").mem.zeroes(u32),
    max_draw_indexed_index_value: u32 = @import("std").mem.zeroes(u32),
    max_draw_indirect_count: u32 = @import("std").mem.zeroes(u32),
    max_sampler_lod_bias: f32 = @import("std").mem.zeroes(f32),
    max_sampler_anisotropy: f32 = @import("std").mem.zeroes(f32),
    max_viewports: u32 = @import("std").mem.zeroes(u32),
    max_viewport_dimensions: [2]u32 = @import("std").mem.zeroes([2]u32),
    viewport_bounds_range: [2]f32 = @import("std").mem.zeroes([2]f32),
    viewport_sub_pixel_bits: u32 = @import("std").mem.zeroes(u32),
    min_memory_map_alignment: usize = @import("std").mem.zeroes(usize),
    min_texel_buffer_offset_alignment: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    min_uniform_buffer_offset_alignment: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    min_storage_buffer_offset_alignment: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    min_texel_offset: i32 = @import("std").mem.zeroes(i32),
    max_texel_offset: u32 = @import("std").mem.zeroes(u32),
    min_texel_gather_offset: i32 = @import("std").mem.zeroes(i32),
    max_texel_gather_offset: u32 = @import("std").mem.zeroes(u32),
    min_interpolation_offset: f32 = @import("std").mem.zeroes(f32),
    max_interpolation_offset: f32 = @import("std").mem.zeroes(f32),
    sub_pixel_interpolation_offset_bits: u32 = @import("std").mem.zeroes(u32),
    max_framebuffer_width: u32 = @import("std").mem.zeroes(u32),
    max_framebuffer_height: u32 = @import("std").mem.zeroes(u32),
    max_framebuffer_layers: u32 = @import("std").mem.zeroes(u32),
    framebuffer_color_sample_counts: SampleCountFlags = @import("std").mem.zeroes(SampleCountFlags),
    framebuffer_depth_sample_counts: SampleCountFlags = @import("std").mem.zeroes(SampleCountFlags),
    framebuffer_stencil_sample_counts: SampleCountFlags = @import("std").mem.zeroes(SampleCountFlags),
    framebuffer_no_attachments_sample_counts: SampleCountFlags = @import("std").mem.zeroes(SampleCountFlags),
    max_color_attachments: u32 = @import("std").mem.zeroes(u32),
    sampled_image_color_sample_counts: SampleCountFlags = @import("std").mem.zeroes(SampleCountFlags),
    sampled_image_integer_sample_counts: SampleCountFlags = @import("std").mem.zeroes(SampleCountFlags),
    sampled_image_depth_sample_counts: SampleCountFlags = @import("std").mem.zeroes(SampleCountFlags),
    sampled_image_stencil_sample_counts: SampleCountFlags = @import("std").mem.zeroes(SampleCountFlags),
    storage_image_sample_counts: SampleCountFlags = @import("std").mem.zeroes(SampleCountFlags),
    max_sample_mask_words: u32 = @import("std").mem.zeroes(u32),
    timestamp_compute_and_graphics: Bool32 = @import("std").mem.zeroes(Bool32),
    timestamp_period: f32 = @import("std").mem.zeroes(f32),
    max_clip_distances: u32 = @import("std").mem.zeroes(u32),
    max_cull_distances: u32 = @import("std").mem.zeroes(u32),
    max_combined_clip_and_cull_distances: u32 = @import("std").mem.zeroes(u32),
    discrete_queue_priorities: u32 = @import("std").mem.zeroes(u32),
    point_size_range: [2]f32 = @import("std").mem.zeroes([2]f32),
    line_width_range: [2]f32 = @import("std").mem.zeroes([2]f32),
    point_size_granularity: f32 = @import("std").mem.zeroes(f32),
    line_width_granularity: f32 = @import("std").mem.zeroes(f32),
    strict_lines: Bool32 = @import("std").mem.zeroes(Bool32),
    standard_sample_locations: Bool32 = @import("std").mem.zeroes(Bool32),
    optimal_buffer_copy_offset_alignment: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    optimal_buffer_copy_row_pitch_alignment: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    non_coherent_atom_size: DeviceSize = @import("std").mem.zeroes(DeviceSize),
};
pub const PhysicalDeviceMemoryProperties = extern struct {
    memory_type_count: u32 = @import("std").mem.zeroes(u32),
    memory_types: [32]MemoryType = @import("std").mem.zeroes([32]MemoryType),
    memory_heap_count: u32 = @import("std").mem.zeroes(u32),
    memory_heaps: [16]MemoryHeap = @import("std").mem.zeroes([16]MemoryHeap),
};
pub const PhysicalDeviceSparseProperties = extern struct {
    residency_standard2_dblock_shape: Bool32 = @import("std").mem.zeroes(Bool32),
    residency_standard2_dmultisample_block_shape: Bool32 = @import("std").mem.zeroes(Bool32),
    residency_standard3_dblock_shape: Bool32 = @import("std").mem.zeroes(Bool32),
    residency_aligned_mip_size: Bool32 = @import("std").mem.zeroes(Bool32),
    residency_non_resident_strict: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceProperties = extern struct {
    api_version: u32 = @import("std").mem.zeroes(u32),
    driver_version: u32 = @import("std").mem.zeroes(u32),
    vendor_id: u32 = @import("std").mem.zeroes(u32),
    device_id: u32 = @import("std").mem.zeroes(u32),
    device_type: PhysicalDeviceType = @import("std").mem.zeroes(PhysicalDeviceType),
    device_name: [256]u8 = @import("std").mem.zeroes([256]u8),
    pipeline_cache_uuid: [16]u8 = @import("std").mem.zeroes([16]u8),
    limits: PhysicalDeviceLimits = @import("std").mem.zeroes(PhysicalDeviceLimits),
    sparse_properties: PhysicalDeviceSparseProperties = @import("std").mem.zeroes(PhysicalDeviceSparseProperties),
};
pub const QueueFamilyProperties = extern struct {
    queue_flags: QueueFlags = @import("std").mem.zeroes(QueueFlags),
    queue_count: u32 = @import("std").mem.zeroes(u32),
    timestamp_valid_bits: u32 = @import("std").mem.zeroes(u32),
    min_image_transfer_granularity: Extent3D = @import("std").mem.zeroes(Extent3D),
};
pub const DeviceQueueCreateInfo = extern struct {
    s_type: StructureType = .device_queue_create_info,
    p_next: ?*const anyopaque = null,
    flags: DeviceQueueCreateFlags = @import("std").mem.zeroes(DeviceQueueCreateFlags),
    queue_family_index: u32 = @import("std").mem.zeroes(u32),
    queue_count: u32 = @import("std").mem.zeroes(u32),
    p_queue_priorities: [*c]const f32 = @import("std").mem.zeroes([*c]const f32),
};
pub const DeviceCreateInfo = extern struct {
    s_type: StructureType = .device_create_info,
    p_next: ?*const anyopaque = null,
    flags: DeviceCreateFlags = @import("std").mem.zeroes(DeviceCreateFlags),
    queue_create_info_count: u32 = @import("std").mem.zeroes(u32),
    p_queue_create_infos: [*c]const DeviceQueueCreateInfo = @import("std").mem.zeroes([*c]const DeviceQueueCreateInfo),
    enabled_layer_count: u32 = @import("std").mem.zeroes(u32),
    pp_enabled_layer_names: [*c]const [*c]const u8 = @import("std").mem.zeroes([*c]const [*c]const u8),
    enabled_extension_count: u32 = @import("std").mem.zeroes(u32),
    pp_enabled_extension_names: [*c]const [*c]const u8 = @import("std").mem.zeroes([*c]const [*c]const u8),
    p_enabled_features: [*c]const PhysicalDeviceFeatures = @import("std").mem.zeroes([*c]const PhysicalDeviceFeatures),
};
pub const ExtensionProperties = extern struct {
    extension_name: [256]u8 = @import("std").mem.zeroes([256]u8),
    spec_version: u32 = @import("std").mem.zeroes(u32),
};
pub const LayerProperties = extern struct {
    layer_name: [256]u8 = @import("std").mem.zeroes([256]u8),
    spec_version: u32 = @import("std").mem.zeroes(u32),
    implementation_version: u32 = @import("std").mem.zeroes(u32),
    description: [256]u8 = @import("std").mem.zeroes([256]u8),
};
pub const SubmitInfo = extern struct {
    s_type: StructureType = .submit_info,
    p_next: ?*const anyopaque = null,
    wait_semaphore_count: u32 = @import("std").mem.zeroes(u32),
    p_wait_semaphores: [*c]const Semaphore = @import("std").mem.zeroes([*c]const Semaphore),
    p_wait_dst_stage_mask: [*c]const PipelineStageFlags = @import("std").mem.zeroes([*c]const PipelineStageFlags),
    command_buffer_count: u32 = @import("std").mem.zeroes(u32),
    p_command_buffers: [*c]const CommandBuffer = @import("std").mem.zeroes([*c]const CommandBuffer),
    signal_semaphore_count: u32 = @import("std").mem.zeroes(u32),
    p_signal_semaphores: [*c]const Semaphore = @import("std").mem.zeroes([*c]const Semaphore),
};
pub const MappedMemoryRange = extern struct {
    s_type: StructureType = .mapped_memory_range,
    p_next: ?*const anyopaque = null,
    memory: DeviceMemory = @import("std").mem.zeroes(DeviceMemory),
    offset: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    size: DeviceSize = @import("std").mem.zeroes(DeviceSize),
};
pub const MemoryAllocateInfo = extern struct {
    s_type: StructureType = .memory_allocate_info,
    p_next: ?*const anyopaque = null,
    allocation_size: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    memory_type_index: u32 = @import("std").mem.zeroes(u32),
};
pub const MemoryRequirements = extern struct {
    size: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    alignment: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    memory_type_bits: u32 = @import("std").mem.zeroes(u32),
};
pub const SparseMemoryBind = extern struct {
    resource_offset: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    size: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    memory: DeviceMemory = @import("std").mem.zeroes(DeviceMemory),
    memory_offset: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    flags: SparseMemoryBindFlags = @import("std").mem.zeroes(SparseMemoryBindFlags),
};
pub const SparseBufferMemoryBindInfo = extern struct {
    buffer: Buffer = @import("std").mem.zeroes(Buffer),
    bind_count: u32 = @import("std").mem.zeroes(u32),
    p_binds: [*c]const SparseMemoryBind = @import("std").mem.zeroes([*c]const SparseMemoryBind),
};
pub const SparseImageOpaqueMemoryBindInfo = extern struct {
    image: Image = @import("std").mem.zeroes(Image),
    bind_count: u32 = @import("std").mem.zeroes(u32),
    p_binds: [*c]const SparseMemoryBind = @import("std").mem.zeroes([*c]const SparseMemoryBind),
};
pub const ImageSubresource = extern struct {
    aspect_mask: ImageAspectFlags = @import("std").mem.zeroes(ImageAspectFlags),
    mip_level: u32 = @import("std").mem.zeroes(u32),
    array_layer: u32 = @import("std").mem.zeroes(u32),
};
pub const SparseImageMemoryBind = extern struct {
    subresource: ImageSubresource = @import("std").mem.zeroes(ImageSubresource),
    offset: Offset3D = @import("std").mem.zeroes(Offset3D),
    extent: Extent3D = @import("std").mem.zeroes(Extent3D),
    memory: DeviceMemory = @import("std").mem.zeroes(DeviceMemory),
    memory_offset: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    flags: SparseMemoryBindFlags = @import("std").mem.zeroes(SparseMemoryBindFlags),
};
pub const SparseImageMemoryBindInfo = extern struct {
    image: Image = @import("std").mem.zeroes(Image),
    bind_count: u32 = @import("std").mem.zeroes(u32),
    p_binds: [*c]const SparseImageMemoryBind = @import("std").mem.zeroes([*c]const SparseImageMemoryBind),
};
pub const BindSparseInfo = extern struct {
    s_type: StructureType = .bind_sparse_info,
    p_next: ?*const anyopaque = null,
    wait_semaphore_count: u32 = @import("std").mem.zeroes(u32),
    p_wait_semaphores: [*c]const Semaphore = @import("std").mem.zeroes([*c]const Semaphore),
    buffer_bind_count: u32 = @import("std").mem.zeroes(u32),
    p_buffer_binds: [*c]const SparseBufferMemoryBindInfo = @import("std").mem.zeroes([*c]const SparseBufferMemoryBindInfo),
    image_opaque_bind_count: u32 = @import("std").mem.zeroes(u32),
    p_image_opaque_binds: [*c]const SparseImageOpaqueMemoryBindInfo = @import("std").mem.zeroes([*c]const SparseImageOpaqueMemoryBindInfo),
    image_bind_count: u32 = @import("std").mem.zeroes(u32),
    p_image_binds: [*c]const SparseImageMemoryBindInfo = @import("std").mem.zeroes([*c]const SparseImageMemoryBindInfo),
    signal_semaphore_count: u32 = @import("std").mem.zeroes(u32),
    p_signal_semaphores: [*c]const Semaphore = @import("std").mem.zeroes([*c]const Semaphore),
};
pub const SparseImageFormatProperties = extern struct {
    aspect_mask: ImageAspectFlags = @import("std").mem.zeroes(ImageAspectFlags),
    image_granularity: Extent3D = @import("std").mem.zeroes(Extent3D),
    flags: SparseImageFormatFlags = @import("std").mem.zeroes(SparseImageFormatFlags),
};
pub const SparseImageMemoryRequirements = extern struct {
    format_properties: SparseImageFormatProperties = @import("std").mem.zeroes(SparseImageFormatProperties),
    image_mip_tail_first_lod: u32 = @import("std").mem.zeroes(u32),
    image_mip_tail_size: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    image_mip_tail_offset: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    image_mip_tail_stride: DeviceSize = @import("std").mem.zeroes(DeviceSize),
};
pub const FenceCreateInfo = extern struct {
    s_type: StructureType = .fence_create_info,
    p_next: ?*const anyopaque = null,
    flags: FenceCreateFlags = @import("std").mem.zeroes(FenceCreateFlags),
};
pub const SemaphoreCreateInfo = extern struct {
    s_type: StructureType = .semaphore_create_info,
    p_next: ?*const anyopaque = null,
    flags: SemaphoreCreateFlags = @import("std").mem.zeroes(SemaphoreCreateFlags),
};
pub const EventCreateInfo = extern struct {
    s_type: StructureType = .event_create_info,
    p_next: ?*const anyopaque = null,
    flags: EventCreateFlags = @import("std").mem.zeroes(EventCreateFlags),
};
pub const QueryPoolCreateInfo = extern struct {
    s_type: StructureType = .query_pool_create_info,
    p_next: ?*const anyopaque = null,
    flags: QueryPoolCreateFlags = @import("std").mem.zeroes(QueryPoolCreateFlags),
    query_type: QueryType = @import("std").mem.zeroes(QueryType),
    query_count: u32 = @import("std").mem.zeroes(u32),
    pipeline_statistics: QueryPipelineStatisticFlags = @import("std").mem.zeroes(QueryPipelineStatisticFlags),
};
pub const BufferCreateInfo = extern struct {
    s_type: StructureType = .buffer_create_info,
    p_next: ?*const anyopaque = null,
    flags: BufferCreateFlags = @import("std").mem.zeroes(BufferCreateFlags),
    size: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    usage: BufferUsageFlags = @import("std").mem.zeroes(BufferUsageFlags),
    sharing_mode: SharingMode = @import("std").mem.zeroes(SharingMode),
    queue_family_index_count: u32 = @import("std").mem.zeroes(u32),
    p_queue_family_indices: [*c]const u32 = @import("std").mem.zeroes([*c]const u32),
};
pub const BufferViewCreateInfo = extern struct {
    s_type: StructureType = .buffer_view_create_info,
    p_next: ?*const anyopaque = null,
    flags: BufferViewCreateFlags = @import("std").mem.zeroes(BufferViewCreateFlags),
    buffer: Buffer = @import("std").mem.zeroes(Buffer),
    format: Format = @import("std").mem.zeroes(Format),
    offset: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    range: DeviceSize = @import("std").mem.zeroes(DeviceSize),
};
pub const ImageCreateInfo = extern struct {
    s_type: StructureType = .image_create_info,
    p_next: ?*const anyopaque = null,
    flags: ImageCreateFlags = @import("std").mem.zeroes(ImageCreateFlags),
    image_type: ImageType = @import("std").mem.zeroes(ImageType),
    format: Format = @import("std").mem.zeroes(Format),
    extent: Extent3D = @import("std").mem.zeroes(Extent3D),
    mip_levels: u32 = @import("std").mem.zeroes(u32),
    array_layers: u32 = @import("std").mem.zeroes(u32),
    samples: SampleCountFlagBits = @import("std").mem.zeroes(SampleCountFlagBits),
    tiling: ImageTiling = @import("std").mem.zeroes(ImageTiling),
    usage: ImageUsageFlags = @import("std").mem.zeroes(ImageUsageFlags),
    sharing_mode: SharingMode = @import("std").mem.zeroes(SharingMode),
    queue_family_index_count: u32 = @import("std").mem.zeroes(u32),
    p_queue_family_indices: [*c]const u32 = @import("std").mem.zeroes([*c]const u32),
    initial_layout: ImageLayout = @import("std").mem.zeroes(ImageLayout),
};
pub const SubresourceLayout = extern struct {
    offset: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    size: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    row_pitch: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    array_pitch: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    depth_pitch: DeviceSize = @import("std").mem.zeroes(DeviceSize),
};
pub const ComponentMapping = extern struct {
    r: ComponentSwizzle = @import("std").mem.zeroes(ComponentSwizzle),
    g: ComponentSwizzle = @import("std").mem.zeroes(ComponentSwizzle),
    b: ComponentSwizzle = @import("std").mem.zeroes(ComponentSwizzle),
    a: ComponentSwizzle = @import("std").mem.zeroes(ComponentSwizzle),
};
pub const ImageViewCreateInfo = extern struct {
    s_type: StructureType = .image_view_create_info,
    p_next: ?*const anyopaque = null,
    flags: ImageViewCreateFlags = @import("std").mem.zeroes(ImageViewCreateFlags),
    image: Image = @import("std").mem.zeroes(Image),
    view_type: ImageViewType = @import("std").mem.zeroes(ImageViewType),
    format: Format = @import("std").mem.zeroes(Format),
    components: ComponentMapping = @import("std").mem.zeroes(ComponentMapping),
    subresource_range: ImageSubresourceRange = @import("std").mem.zeroes(ImageSubresourceRange),
};
pub const ShaderModuleCreateInfo = extern struct {
    s_type: StructureType = .shader_module_create_info,
    p_next: ?*const anyopaque = null,
    flags: ShaderModuleCreateFlags = @import("std").mem.zeroes(ShaderModuleCreateFlags),
    code_size: usize = @import("std").mem.zeroes(usize),
    p_code: [*c]const u32 = @import("std").mem.zeroes([*c]const u32),
};
pub const PipelineCacheCreateInfo = extern struct {
    s_type: StructureType = .pipeline_cache_create_info,
    p_next: ?*const anyopaque = null,
    flags: PipelineCacheCreateFlags = @import("std").mem.zeroes(PipelineCacheCreateFlags),
    initial_data_size: usize = @import("std").mem.zeroes(usize),
    p_initial_data: ?*const anyopaque = @import("std").mem.zeroes(?*const anyopaque),
};
pub const SpecializationMapEntry = extern struct {
    constant_id: u32 = @import("std").mem.zeroes(u32),
    offset: u32 = @import("std").mem.zeroes(u32),
    size: usize = @import("std").mem.zeroes(usize),
};
pub const SpecializationInfo = extern struct {
    map_entry_count: u32 = @import("std").mem.zeroes(u32),
    p_map_entries: [*c]const SpecializationMapEntry = @import("std").mem.zeroes([*c]const SpecializationMapEntry),
    data_size: usize = @import("std").mem.zeroes(usize),
    p_data: ?*const anyopaque = @import("std").mem.zeroes(?*const anyopaque),
};
pub const PipelineShaderStageCreateInfo = extern struct {
    s_type: StructureType = .pipeline_shader_stage_create_info,
    p_next: ?*const anyopaque = null,
    flags: PipelineShaderStageCreateFlags = @import("std").mem.zeroes(PipelineShaderStageCreateFlags),
    stage: ShaderStageFlagBits = @import("std").mem.zeroes(ShaderStageFlagBits),
    module: ShaderModule = @import("std").mem.zeroes(ShaderModule),
    p_name: [*c]const u8 = @import("std").mem.zeroes([*c]const u8),
    p_specialization_info: [*c]const SpecializationInfo = @import("std").mem.zeroes([*c]const SpecializationInfo),
};
pub const ComputePipelineCreateInfo = extern struct {
    s_type: StructureType = .compute_pipeline_create_info,
    p_next: ?*const anyopaque = null,
    flags: PipelineCreateFlags = @import("std").mem.zeroes(PipelineCreateFlags),
    stage: PipelineShaderStageCreateInfo = @import("std").mem.zeroes(PipelineShaderStageCreateInfo),
    layout: PipelineLayout = @import("std").mem.zeroes(PipelineLayout),
    base_pipeline_handle: Pipeline = @import("std").mem.zeroes(Pipeline),
    base_pipeline_index: i32 = @import("std").mem.zeroes(i32),
};
pub const VertexInputBindingDescription = extern struct {
    binding: u32 = @import("std").mem.zeroes(u32),
    stride: u32 = @import("std").mem.zeroes(u32),
    input_rate: VertexInputRate = @import("std").mem.zeroes(VertexInputRate),
};
pub const VertexInputAttributeDescription = extern struct {
    location: u32 = @import("std").mem.zeroes(u32),
    binding: u32 = @import("std").mem.zeroes(u32),
    format: Format = @import("std").mem.zeroes(Format),
    offset: u32 = @import("std").mem.zeroes(u32),
};
pub const PipelineVertexInputStateCreateInfo = extern struct {
    s_type: StructureType = .pipeline_vertex_input_state_create_info,
    p_next: ?*const anyopaque = null,
    flags: PipelineVertexInputStateCreateFlags = @import("std").mem.zeroes(PipelineVertexInputStateCreateFlags),
    vertex_binding_description_count: u32 = @import("std").mem.zeroes(u32),
    p_vertex_binding_descriptions: [*c]const VertexInputBindingDescription = @import("std").mem.zeroes([*c]const VertexInputBindingDescription),
    vertex_attribute_description_count: u32 = @import("std").mem.zeroes(u32),
    p_vertex_attribute_descriptions: [*c]const VertexInputAttributeDescription = @import("std").mem.zeroes([*c]const VertexInputAttributeDescription),
};
pub const PipelineInputAssemblyStateCreateInfo = extern struct {
    s_type: StructureType = .pipeline_input_assembly_state_create_info,
    p_next: ?*const anyopaque = null,
    flags: PipelineInputAssemblyStateCreateFlags = @import("std").mem.zeroes(PipelineInputAssemblyStateCreateFlags),
    topology: PrimitiveTopology = @import("std").mem.zeroes(PrimitiveTopology),
    primitive_restart_enable: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PipelineTessellationStateCreateInfo = extern struct {
    s_type: StructureType = .pipeline_tessellation_state_create_info,
    p_next: ?*const anyopaque = null,
    flags: PipelineTessellationStateCreateFlags = @import("std").mem.zeroes(PipelineTessellationStateCreateFlags),
    patch_control_points: u32 = @import("std").mem.zeroes(u32),
};
pub const Viewport = extern struct {
    x: f32 = @import("std").mem.zeroes(f32),
    y: f32 = @import("std").mem.zeroes(f32),
    width: f32 = @import("std").mem.zeroes(f32),
    height: f32 = @import("std").mem.zeroes(f32),
    min_depth: f32 = @import("std").mem.zeroes(f32),
    max_depth: f32 = @import("std").mem.zeroes(f32),
};
pub const PipelineViewportStateCreateInfo = extern struct {
    s_type: StructureType = .pipeline_viewport_state_create_info,
    p_next: ?*const anyopaque = null,
    flags: PipelineViewportStateCreateFlags = @import("std").mem.zeroes(PipelineViewportStateCreateFlags),
    viewport_count: u32 = @import("std").mem.zeroes(u32),
    p_viewports: [*c]const Viewport = @import("std").mem.zeroes([*c]const Viewport),
    scissor_count: u32 = @import("std").mem.zeroes(u32),
    p_scissors: [*c]const Rect2D = @import("std").mem.zeroes([*c]const Rect2D),
};
pub const PipelineRasterizationStateCreateInfo = extern struct {
    s_type: StructureType = .pipeline_rasterization_state_create_info,
    p_next: ?*const anyopaque = null,
    flags: PipelineRasterizationStateCreateFlags = @import("std").mem.zeroes(PipelineRasterizationStateCreateFlags),
    depth_clamp_enable: Bool32 = @import("std").mem.zeroes(Bool32),
    rasterizer_discard_enable: Bool32 = @import("std").mem.zeroes(Bool32),
    polygon_mode: PolygonMode = @import("std").mem.zeroes(PolygonMode),
    cull_mode: CullModeFlags = @import("std").mem.zeroes(CullModeFlags),
    front_face: FrontFace = @import("std").mem.zeroes(FrontFace),
    depth_bias_enable: Bool32 = @import("std").mem.zeroes(Bool32),
    depth_bias_constant_factor: f32 = @import("std").mem.zeroes(f32),
    depth_bias_clamp: f32 = @import("std").mem.zeroes(f32),
    depth_bias_slope_factor: f32 = @import("std").mem.zeroes(f32),
    line_width: f32 = @import("std").mem.zeroes(f32),
};
pub const PipelineMultisampleStateCreateInfo = extern struct {
    s_type: StructureType = .pipeline_multisample_state_create_info,
    p_next: ?*const anyopaque = null,
    flags: PipelineMultisampleStateCreateFlags = @import("std").mem.zeroes(PipelineMultisampleStateCreateFlags),
    rasterization_samples: SampleCountFlagBits = @import("std").mem.zeroes(SampleCountFlagBits),
    sample_shading_enable: Bool32 = @import("std").mem.zeroes(Bool32),
    min_sample_shading: f32 = @import("std").mem.zeroes(f32),
    p_sample_mask: [*c]const SampleMask = @import("std").mem.zeroes([*c]const SampleMask),
    alpha_to_coverage_enable: Bool32 = @import("std").mem.zeroes(Bool32),
    alpha_to_one_enable: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const StencilOpState = extern struct {
    fail_op: StencilOp = @import("std").mem.zeroes(StencilOp),
    pass_op: StencilOp = @import("std").mem.zeroes(StencilOp),
    depth_fail_op: StencilOp = @import("std").mem.zeroes(StencilOp),
    compare_op: CompareOp = @import("std").mem.zeroes(CompareOp),
    compare_mask: u32 = @import("std").mem.zeroes(u32),
    write_mask: u32 = @import("std").mem.zeroes(u32),
    reference: u32 = @import("std").mem.zeroes(u32),
};
pub const PipelineDepthStencilStateCreateInfo = extern struct {
    s_type: StructureType = .pipeline_depth_stencil_state_create_info,
    p_next: ?*const anyopaque = null,
    flags: PipelineDepthStencilStateCreateFlags = @import("std").mem.zeroes(PipelineDepthStencilStateCreateFlags),
    depth_test_enable: Bool32 = @import("std").mem.zeroes(Bool32),
    depth_write_enable: Bool32 = @import("std").mem.zeroes(Bool32),
    depth_compare_op: CompareOp = @import("std").mem.zeroes(CompareOp),
    depth_bounds_test_enable: Bool32 = @import("std").mem.zeroes(Bool32),
    stencil_test_enable: Bool32 = @import("std").mem.zeroes(Bool32),
    front: StencilOpState = @import("std").mem.zeroes(StencilOpState),
    back: StencilOpState = @import("std").mem.zeroes(StencilOpState),
    min_depth_bounds: f32 = @import("std").mem.zeroes(f32),
    max_depth_bounds: f32 = @import("std").mem.zeroes(f32),
};
pub const PipelineColorBlendAttachmentState = extern struct {
    blend_enable: Bool32 = @import("std").mem.zeroes(Bool32),
    src_color_blend_factor: BlendFactor = @import("std").mem.zeroes(BlendFactor),
    dst_color_blend_factor: BlendFactor = @import("std").mem.zeroes(BlendFactor),
    color_blend_op: BlendOp = @import("std").mem.zeroes(BlendOp),
    src_alpha_blend_factor: BlendFactor = @import("std").mem.zeroes(BlendFactor),
    dst_alpha_blend_factor: BlendFactor = @import("std").mem.zeroes(BlendFactor),
    alpha_blend_op: BlendOp = @import("std").mem.zeroes(BlendOp),
    color_write_mask: ColorComponentFlags = @import("std").mem.zeroes(ColorComponentFlags),
};
pub const PipelineColorBlendStateCreateInfo = extern struct {
    s_type: StructureType = .pipeline_color_blend_state_create_info,
    p_next: ?*const anyopaque = null,
    flags: PipelineColorBlendStateCreateFlags = @import("std").mem.zeroes(PipelineColorBlendStateCreateFlags),
    logic_op_enable: Bool32 = @import("std").mem.zeroes(Bool32),
    logic_op: LogicOp = @import("std").mem.zeroes(LogicOp),
    attachment_count: u32 = @import("std").mem.zeroes(u32),
    p_attachments: [*c]const PipelineColorBlendAttachmentState = @import("std").mem.zeroes([*c]const PipelineColorBlendAttachmentState),
    blend_constants: [4]f32 = @import("std").mem.zeroes([4]f32),
};
pub const PipelineDynamicStateCreateInfo = extern struct {
    s_type: StructureType = .pipeline_dynamic_state_create_info,
    p_next: ?*const anyopaque = null,
    flags: PipelineDynamicStateCreateFlags = @import("std").mem.zeroes(PipelineDynamicStateCreateFlags),
    dynamic_state_count: u32 = @import("std").mem.zeroes(u32),
    p_dynamic_states: [*c]const DynamicState = @import("std").mem.zeroes([*c]const DynamicState),
};
pub const GraphicsPipelineCreateInfo = extern struct {
    s_type: StructureType = .graphics_pipeline_create_info,
    p_next: ?*const anyopaque = null,
    flags: PipelineCreateFlags = @import("std").mem.zeroes(PipelineCreateFlags),
    stage_count: u32 = @import("std").mem.zeroes(u32),
    p_stages: [*c]const PipelineShaderStageCreateInfo = @import("std").mem.zeroes([*c]const PipelineShaderStageCreateInfo),
    p_vertex_input_state: [*c]const PipelineVertexInputStateCreateInfo = @import("std").mem.zeroes([*c]const PipelineVertexInputStateCreateInfo),
    p_input_assembly_state: [*c]const PipelineInputAssemblyStateCreateInfo = @import("std").mem.zeroes([*c]const PipelineInputAssemblyStateCreateInfo),
    p_tessellation_state: [*c]const PipelineTessellationStateCreateInfo = @import("std").mem.zeroes([*c]const PipelineTessellationStateCreateInfo),
    p_viewport_state: [*c]const PipelineViewportStateCreateInfo = @import("std").mem.zeroes([*c]const PipelineViewportStateCreateInfo),
    p_rasterization_state: [*c]const PipelineRasterizationStateCreateInfo = @import("std").mem.zeroes([*c]const PipelineRasterizationStateCreateInfo),
    p_multisample_state: [*c]const PipelineMultisampleStateCreateInfo = @import("std").mem.zeroes([*c]const PipelineMultisampleStateCreateInfo),
    p_depth_stencil_state: [*c]const PipelineDepthStencilStateCreateInfo = @import("std").mem.zeroes([*c]const PipelineDepthStencilStateCreateInfo),
    p_color_blend_state: [*c]const PipelineColorBlendStateCreateInfo = @import("std").mem.zeroes([*c]const PipelineColorBlendStateCreateInfo),
    p_dynamic_state: [*c]const PipelineDynamicStateCreateInfo = @import("std").mem.zeroes([*c]const PipelineDynamicStateCreateInfo),
    layout: PipelineLayout = @import("std").mem.zeroes(PipelineLayout),
    render_pass: RenderPass = @import("std").mem.zeroes(RenderPass),
    subpass: u32 = @import("std").mem.zeroes(u32),
    base_pipeline_handle: Pipeline = @import("std").mem.zeroes(Pipeline),
    base_pipeline_index: i32 = @import("std").mem.zeroes(i32),
};
pub const PushConstantRange = extern struct {
    stage_flags: ShaderStageFlags = @import("std").mem.zeroes(ShaderStageFlags),
    offset: u32 = @import("std").mem.zeroes(u32),
    size: u32 = @import("std").mem.zeroes(u32),
};
pub const PipelineLayoutCreateInfo = extern struct {
    s_type: StructureType = .pipeline_layout_create_info,
    p_next: ?*const anyopaque = null,
    flags: PipelineLayoutCreateFlags = @import("std").mem.zeroes(PipelineLayoutCreateFlags),
    set_layout_count: u32 = @import("std").mem.zeroes(u32),
    p_set_layouts: [*c]const DescriptorSetLayout = @import("std").mem.zeroes([*c]const DescriptorSetLayout),
    push_constant_range_count: u32 = @import("std").mem.zeroes(u32),
    p_push_constant_ranges: [*c]const PushConstantRange = @import("std").mem.zeroes([*c]const PushConstantRange),
};
pub const SamplerCreateInfo = extern struct {
    s_type: StructureType = .sampler_create_info,
    p_next: ?*const anyopaque = null,
    flags: SamplerCreateFlags = @import("std").mem.zeroes(SamplerCreateFlags),
    mag_filter: Filter = @import("std").mem.zeroes(Filter),
    min_filter: Filter = @import("std").mem.zeroes(Filter),
    mipmap_mode: SamplerMipmapMode = @import("std").mem.zeroes(SamplerMipmapMode),
    address_mode_u: SamplerAddressMode = @import("std").mem.zeroes(SamplerAddressMode),
    address_mode_v: SamplerAddressMode = @import("std").mem.zeroes(SamplerAddressMode),
    address_mode_w: SamplerAddressMode = @import("std").mem.zeroes(SamplerAddressMode),
    mip_lod_bias: f32 = @import("std").mem.zeroes(f32),
    anisotropy_enable: Bool32 = @import("std").mem.zeroes(Bool32),
    max_anisotropy: f32 = @import("std").mem.zeroes(f32),
    compare_enable: Bool32 = @import("std").mem.zeroes(Bool32),
    compare_op: CompareOp = @import("std").mem.zeroes(CompareOp),
    min_lod: f32 = @import("std").mem.zeroes(f32),
    max_lod: f32 = @import("std").mem.zeroes(f32),
    border_color: BorderColor = @import("std").mem.zeroes(BorderColor),
    unnormalized_coordinates: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const CopyDescriptorSet = extern struct {
    s_type: StructureType = .copy_descriptor_set,
    p_next: ?*const anyopaque = null,
    src_set: DescriptorSet = @import("std").mem.zeroes(DescriptorSet),
    src_binding: u32 = @import("std").mem.zeroes(u32),
    src_array_element: u32 = @import("std").mem.zeroes(u32),
    dst_set: DescriptorSet = @import("std").mem.zeroes(DescriptorSet),
    dst_binding: u32 = @import("std").mem.zeroes(u32),
    dst_array_element: u32 = @import("std").mem.zeroes(u32),
    descriptor_count: u32 = @import("std").mem.zeroes(u32),
};
pub const DescriptorBufferInfo = extern struct {
    buffer: Buffer = @import("std").mem.zeroes(Buffer),
    offset: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    range: DeviceSize = @import("std").mem.zeroes(DeviceSize),
};
pub const DescriptorImageInfo = extern struct {
    sampler: Sampler = @import("std").mem.zeroes(Sampler),
    image_view: ImageView = @import("std").mem.zeroes(ImageView),
    image_layout: ImageLayout = @import("std").mem.zeroes(ImageLayout),
};
pub const DescriptorPoolSize = extern struct {
    type: DescriptorType = @import("std").mem.zeroes(DescriptorType),
    descriptor_count: u32 = @import("std").mem.zeroes(u32),
};
pub const DescriptorPoolCreateInfo = extern struct {
    s_type: StructureType = .descriptor_pool_create_info,
    p_next: ?*const anyopaque = null,
    flags: DescriptorPoolCreateFlags = @import("std").mem.zeroes(DescriptorPoolCreateFlags),
    max_sets: u32 = @import("std").mem.zeroes(u32),
    pool_size_count: u32 = @import("std").mem.zeroes(u32),
    p_pool_sizes: [*c]const DescriptorPoolSize = @import("std").mem.zeroes([*c]const DescriptorPoolSize),
};
pub const DescriptorSetAllocateInfo = extern struct {
    s_type: StructureType = .descriptor_set_allocate_info,
    p_next: ?*const anyopaque = null,
    descriptor_pool: DescriptorPool = @import("std").mem.zeroes(DescriptorPool),
    descriptor_set_count: u32 = @import("std").mem.zeroes(u32),
    p_set_layouts: [*c]const DescriptorSetLayout = @import("std").mem.zeroes([*c]const DescriptorSetLayout),
};
pub const DescriptorSetLayoutBinding = extern struct {
    binding: u32 = @import("std").mem.zeroes(u32),
    descriptor_type: DescriptorType = @import("std").mem.zeroes(DescriptorType),
    descriptor_count: u32 = @import("std").mem.zeroes(u32),
    stage_flags: ShaderStageFlags = @import("std").mem.zeroes(ShaderStageFlags),
    p_immutable_samplers: [*c]const Sampler = @import("std").mem.zeroes([*c]const Sampler),
};
pub const DescriptorSetLayoutCreateInfo = extern struct {
    s_type: StructureType = .descriptor_set_layout_create_info,
    p_next: ?*const anyopaque = null,
    flags: DescriptorSetLayoutCreateFlags = @import("std").mem.zeroes(DescriptorSetLayoutCreateFlags),
    binding_count: u32 = @import("std").mem.zeroes(u32),
    p_bindings: [*c]const DescriptorSetLayoutBinding = @import("std").mem.zeroes([*c]const DescriptorSetLayoutBinding),
};
pub const WriteDescriptorSet = extern struct {
    s_type: StructureType = .write_descriptor_set,
    p_next: ?*const anyopaque = null,
    dst_set: DescriptorSet = @import("std").mem.zeroes(DescriptorSet),
    dst_binding: u32 = @import("std").mem.zeroes(u32),
    dst_array_element: u32 = @import("std").mem.zeroes(u32),
    descriptor_count: u32 = @import("std").mem.zeroes(u32),
    descriptor_type: DescriptorType = @import("std").mem.zeroes(DescriptorType),
    p_image_info: [*c]const DescriptorImageInfo = @import("std").mem.zeroes([*c]const DescriptorImageInfo),
    p_buffer_info: [*c]const DescriptorBufferInfo = @import("std").mem.zeroes([*c]const DescriptorBufferInfo),
    p_texel_buffer_view: [*c]const BufferView = @import("std").mem.zeroes([*c]const BufferView),
};
pub const AttachmentDescription = extern struct {
    flags: AttachmentDescriptionFlags = @import("std").mem.zeroes(AttachmentDescriptionFlags),
    format: Format = @import("std").mem.zeroes(Format),
    samples: SampleCountFlagBits = @import("std").mem.zeroes(SampleCountFlagBits),
    load_op: AttachmentLoadOp = @import("std").mem.zeroes(AttachmentLoadOp),
    store_op: AttachmentStoreOp = @import("std").mem.zeroes(AttachmentStoreOp),
    stencil_load_op: AttachmentLoadOp = @import("std").mem.zeroes(AttachmentLoadOp),
    stencil_store_op: AttachmentStoreOp = @import("std").mem.zeroes(AttachmentStoreOp),
    initial_layout: ImageLayout = @import("std").mem.zeroes(ImageLayout),
    final_layout: ImageLayout = @import("std").mem.zeroes(ImageLayout),
};
pub const AttachmentReference = extern struct {
    attachment: u32 = @import("std").mem.zeroes(u32),
    layout: ImageLayout = @import("std").mem.zeroes(ImageLayout),
};
pub const FramebufferCreateInfo = extern struct {
    s_type: StructureType = .framebuffer_create_info,
    p_next: ?*const anyopaque = null,
    flags: FramebufferCreateFlags = @import("std").mem.zeroes(FramebufferCreateFlags),
    render_pass: RenderPass = @import("std").mem.zeroes(RenderPass),
    attachment_count: u32 = @import("std").mem.zeroes(u32),
    p_attachments: [*c]const ImageView = @import("std").mem.zeroes([*c]const ImageView),
    width: u32 = @import("std").mem.zeroes(u32),
    height: u32 = @import("std").mem.zeroes(u32),
    layers: u32 = @import("std").mem.zeroes(u32),
};
pub const SubpassDescription = extern struct {
    flags: SubpassDescriptionFlags = @import("std").mem.zeroes(SubpassDescriptionFlags),
    pipeline_bind_point: PipelineBindPoint = @import("std").mem.zeroes(PipelineBindPoint),
    input_attachment_count: u32 = @import("std").mem.zeroes(u32),
    p_input_attachments: [*c]const AttachmentReference = @import("std").mem.zeroes([*c]const AttachmentReference),
    color_attachment_count: u32 = @import("std").mem.zeroes(u32),
    p_color_attachments: [*c]const AttachmentReference = @import("std").mem.zeroes([*c]const AttachmentReference),
    p_resolve_attachments: [*c]const AttachmentReference = @import("std").mem.zeroes([*c]const AttachmentReference),
    p_depth_stencil_attachment: [*c]const AttachmentReference = @import("std").mem.zeroes([*c]const AttachmentReference),
    preserve_attachment_count: u32 = @import("std").mem.zeroes(u32),
    p_preserve_attachments: [*c]const u32 = @import("std").mem.zeroes([*c]const u32),
};
pub const SubpassDependency = extern struct {
    src_subpass: u32 = @import("std").mem.zeroes(u32),
    dst_subpass: u32 = @import("std").mem.zeroes(u32),
    src_stage_mask: PipelineStageFlags = @import("std").mem.zeroes(PipelineStageFlags),
    dst_stage_mask: PipelineStageFlags = @import("std").mem.zeroes(PipelineStageFlags),
    src_access_mask: AccessFlags = @import("std").mem.zeroes(AccessFlags),
    dst_access_mask: AccessFlags = @import("std").mem.zeroes(AccessFlags),
    dependency_flags: DependencyFlags = @import("std").mem.zeroes(DependencyFlags),
};
pub const RenderPassCreateInfo = extern struct {
    s_type: StructureType = .render_pass_create_info,
    p_next: ?*const anyopaque = null,
    flags: RenderPassCreateFlags = @import("std").mem.zeroes(RenderPassCreateFlags),
    attachment_count: u32 = @import("std").mem.zeroes(u32),
    p_attachments: [*c]const AttachmentDescription = @import("std").mem.zeroes([*c]const AttachmentDescription),
    subpass_count: u32 = @import("std").mem.zeroes(u32),
    p_subpasses: [*c]const SubpassDescription = @import("std").mem.zeroes([*c]const SubpassDescription),
    dependency_count: u32 = @import("std").mem.zeroes(u32),
    p_dependencies: [*c]const SubpassDependency = @import("std").mem.zeroes([*c]const SubpassDependency),
};
pub const CommandPoolCreateInfo = extern struct {
    s_type: StructureType = .command_pool_create_info,
    p_next: ?*const anyopaque = null,
    flags: CommandPoolCreateFlags = @import("std").mem.zeroes(CommandPoolCreateFlags),
    queue_family_index: u32 = @import("std").mem.zeroes(u32),
};
pub const CommandBufferAllocateInfo = extern struct {
    s_type: StructureType = .command_buffer_allocate_info,
    p_next: ?*const anyopaque = null,
    command_pool: CommandPool = @import("std").mem.zeroes(CommandPool),
    level: CommandBufferLevel = @import("std").mem.zeroes(CommandBufferLevel),
    command_buffer_count: u32 = @import("std").mem.zeroes(u32),
};
pub const CommandBufferInheritanceInfo = extern struct {
    s_type: StructureType = .command_buffer_inheritance_info,
    p_next: ?*const anyopaque = null,
    render_pass: RenderPass = @import("std").mem.zeroes(RenderPass),
    subpass: u32 = @import("std").mem.zeroes(u32),
    framebuffer: Framebuffer = @import("std").mem.zeroes(Framebuffer),
    occlusion_query_enable: Bool32 = @import("std").mem.zeroes(Bool32),
    query_flags: QueryControlFlags = @import("std").mem.zeroes(QueryControlFlags),
    pipeline_statistics: QueryPipelineStatisticFlags = @import("std").mem.zeroes(QueryPipelineStatisticFlags),
};
pub const CommandBufferBeginInfo = extern struct {
    s_type: StructureType = .command_buffer_begin_info,
    p_next: ?*const anyopaque = null,
    flags: CommandBufferUsageFlags = @import("std").mem.zeroes(CommandBufferUsageFlags),
    p_inheritance_info: [*c]const CommandBufferInheritanceInfo = @import("std").mem.zeroes([*c]const CommandBufferInheritanceInfo),
};
pub const BufferCopy = extern struct {
    src_offset: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    dst_offset: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    size: DeviceSize = @import("std").mem.zeroes(DeviceSize),
};
pub const ImageSubresourceLayers = extern struct {
    aspect_mask: ImageAspectFlags = @import("std").mem.zeroes(ImageAspectFlags),
    mip_level: u32 = @import("std").mem.zeroes(u32),
    base_array_layer: u32 = @import("std").mem.zeroes(u32),
    layer_count: u32 = @import("std").mem.zeroes(u32),
};
pub const BufferImageCopy = extern struct {
    buffer_offset: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    buffer_row_length: u32 = @import("std").mem.zeroes(u32),
    buffer_image_height: u32 = @import("std").mem.zeroes(u32),
    image_subresource: ImageSubresourceLayers = @import("std").mem.zeroes(ImageSubresourceLayers),
    image_offset: Offset3D = @import("std").mem.zeroes(Offset3D),
    image_extent: Extent3D = @import("std").mem.zeroes(Extent3D),
};
pub const ClearDepthStencilValue = extern struct {
    depth: f32 = @import("std").mem.zeroes(f32),
    stencil: u32 = @import("std").mem.zeroes(u32),
};
pub const ClearAttachment = extern struct {
    aspect_mask: ImageAspectFlags = @import("std").mem.zeroes(ImageAspectFlags),
    color_attachment: u32 = @import("std").mem.zeroes(u32),
    clear_value: ClearValue = @import("std").mem.zeroes(ClearValue),
};
pub const ClearRect = extern struct {
    rect: Rect2D = @import("std").mem.zeroes(Rect2D),
    base_array_layer: u32 = @import("std").mem.zeroes(u32),
    layer_count: u32 = @import("std").mem.zeroes(u32),
};
pub const ImageBlit = extern struct {
    src_subresource: ImageSubresourceLayers = @import("std").mem.zeroes(ImageSubresourceLayers),
    src_offsets: [2]Offset3D = @import("std").mem.zeroes([2]Offset3D),
    dst_subresource: ImageSubresourceLayers = @import("std").mem.zeroes(ImageSubresourceLayers),
    dst_offsets: [2]Offset3D = @import("std").mem.zeroes([2]Offset3D),
};
pub const ImageCopy = extern struct {
    src_subresource: ImageSubresourceLayers = @import("std").mem.zeroes(ImageSubresourceLayers),
    src_offset: Offset3D = @import("std").mem.zeroes(Offset3D),
    dst_subresource: ImageSubresourceLayers = @import("std").mem.zeroes(ImageSubresourceLayers),
    dst_offset: Offset3D = @import("std").mem.zeroes(Offset3D),
    extent: Extent3D = @import("std").mem.zeroes(Extent3D),
};
pub const ImageResolve = extern struct {
    src_subresource: ImageSubresourceLayers = @import("std").mem.zeroes(ImageSubresourceLayers),
    src_offset: Offset3D = @import("std").mem.zeroes(Offset3D),
    dst_subresource: ImageSubresourceLayers = @import("std").mem.zeroes(ImageSubresourceLayers),
    dst_offset: Offset3D = @import("std").mem.zeroes(Offset3D),
    extent: Extent3D = @import("std").mem.zeroes(Extent3D),
};
pub const RenderPassBeginInfo = extern struct {
    s_type: StructureType = .render_pass_begin_info,
    p_next: ?*const anyopaque = null,
    render_pass: RenderPass = @import("std").mem.zeroes(RenderPass),
    framebuffer: Framebuffer = @import("std").mem.zeroes(Framebuffer),
    render_area: Rect2D = @import("std").mem.zeroes(Rect2D),
    clear_value_count: u32 = @import("std").mem.zeroes(u32),
    p_clear_values: [*c]const ClearValue = @import("std").mem.zeroes([*c]const ClearValue),
};
pub const PhysicalDeviceSubgroupProperties = extern struct {
    s_type: StructureType = .physical_device_subgroup_properties,
    p_next: ?*anyopaque = null,
    subgroup_size: u32 = @import("std").mem.zeroes(u32),
    supported_stages: ShaderStageFlags = @import("std").mem.zeroes(ShaderStageFlags),
    supported_operations: SubgroupFeatureFlags = @import("std").mem.zeroes(SubgroupFeatureFlags),
    quad_operations_in_all_stages: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const BindBufferMemoryInfo = extern struct {
    s_type: StructureType = .bind_buffer_memory_info,
    p_next: ?*const anyopaque = null,
    buffer: Buffer = @import("std").mem.zeroes(Buffer),
    memory: DeviceMemory = @import("std").mem.zeroes(DeviceMemory),
    memory_offset: DeviceSize = @import("std").mem.zeroes(DeviceSize),
};
pub const BindImageMemoryInfo = extern struct {
    s_type: StructureType = .bind_image_memory_info,
    p_next: ?*const anyopaque = null,
    image: Image = @import("std").mem.zeroes(Image),
    memory: DeviceMemory = @import("std").mem.zeroes(DeviceMemory),
    memory_offset: DeviceSize = @import("std").mem.zeroes(DeviceSize),
};
pub const PhysicalDevice16BitStorageFeatures = extern struct {
    s_type: StructureType = .physical_device16_bit_storage_features,
    p_next: ?*anyopaque = null,
    storage_buffer16_bit_access: Bool32 = @import("std").mem.zeroes(Bool32),
    uniform_and_storage_buffer16_bit_access: Bool32 = @import("std").mem.zeroes(Bool32),
    storage_push_constant16: Bool32 = @import("std").mem.zeroes(Bool32),
    storage_input_output16: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const MemoryDedicatedRequirements = extern struct {
    s_type: StructureType = .memory_dedicated_requirements,
    p_next: ?*anyopaque = null,
    prefers_dedicated_allocation: Bool32 = @import("std").mem.zeroes(Bool32),
    requires_dedicated_allocation: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const MemoryDedicatedAllocateInfo = extern struct {
    s_type: StructureType = .memory_dedicated_allocate_info,
    p_next: ?*const anyopaque = null,
    image: Image = @import("std").mem.zeroes(Image),
    buffer: Buffer = @import("std").mem.zeroes(Buffer),
};
pub const MemoryAllocateFlagsInfo = extern struct {
    s_type: StructureType = .memory_allocate_flags_info,
    p_next: ?*const anyopaque = null,
    flags: MemoryAllocateFlags = @import("std").mem.zeroes(MemoryAllocateFlags),
    device_mask: u32 = @import("std").mem.zeroes(u32),
};
pub const DeviceGroupRenderPassBeginInfo = extern struct {
    s_type: StructureType = .device_group_render_pass_begin_info,
    p_next: ?*const anyopaque = null,
    device_mask: u32 = @import("std").mem.zeroes(u32),
    device_render_area_count: u32 = @import("std").mem.zeroes(u32),
    p_device_render_areas: [*c]const Rect2D = @import("std").mem.zeroes([*c]const Rect2D),
};
pub const DeviceGroupCommandBufferBeginInfo = extern struct {
    s_type: StructureType = .device_group_command_buffer_begin_info,
    p_next: ?*const anyopaque = null,
    device_mask: u32 = @import("std").mem.zeroes(u32),
};
pub const DeviceGroupSubmitInfo = extern struct {
    s_type: StructureType = .device_group_submit_info,
    p_next: ?*const anyopaque = null,
    wait_semaphore_count: u32 = @import("std").mem.zeroes(u32),
    p_wait_semaphore_device_indices: [*c]const u32 = @import("std").mem.zeroes([*c]const u32),
    command_buffer_count: u32 = @import("std").mem.zeroes(u32),
    p_command_buffer_device_masks: [*c]const u32 = @import("std").mem.zeroes([*c]const u32),
    signal_semaphore_count: u32 = @import("std").mem.zeroes(u32),
    p_signal_semaphore_device_indices: [*c]const u32 = @import("std").mem.zeroes([*c]const u32),
};
pub const DeviceGroupBindSparseInfo = extern struct {
    s_type: StructureType = .device_group_bind_sparse_info,
    p_next: ?*const anyopaque = null,
    resource_device_index: u32 = @import("std").mem.zeroes(u32),
    memory_device_index: u32 = @import("std").mem.zeroes(u32),
};
pub const BindBufferMemoryDeviceGroupInfo = extern struct {
    s_type: StructureType = .bind_buffer_memory_device_group_info,
    p_next: ?*const anyopaque = null,
    device_index_count: u32 = @import("std").mem.zeroes(u32),
    p_device_indices: [*c]const u32 = @import("std").mem.zeroes([*c]const u32),
};
pub const BindImageMemoryDeviceGroupInfo = extern struct {
    s_type: StructureType = .bind_image_memory_device_group_info,
    p_next: ?*const anyopaque = null,
    device_index_count: u32 = @import("std").mem.zeroes(u32),
    p_device_indices: [*c]const u32 = @import("std").mem.zeroes([*c]const u32),
    split_instance_bind_region_count: u32 = @import("std").mem.zeroes(u32),
    p_split_instance_bind_regions: [*c]const Rect2D = @import("std").mem.zeroes([*c]const Rect2D),
};
pub const PhysicalDeviceGroupProperties = extern struct {
    s_type: StructureType = .physical_device_group_properties,
    p_next: ?*anyopaque = null,
    physical_device_count: u32 = @import("std").mem.zeroes(u32),
    physical_devices: [32]PhysicalDevice = @import("std").mem.zeroes([32]PhysicalDevice),
    subset_allocation: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const DeviceGroupDeviceCreateInfo = extern struct {
    s_type: StructureType = .device_group_device_create_info,
    p_next: ?*const anyopaque = null,
    physical_device_count: u32 = @import("std").mem.zeroes(u32),
    p_physical_devices: [*c]const PhysicalDevice = @import("std").mem.zeroes([*c]const PhysicalDevice),
};
pub const BufferMemoryRequirementsInfo2 = extern struct {
    s_type: StructureType = .buffer_memory_requirements_info2,
    p_next: ?*const anyopaque = null,
    buffer: Buffer = @import("std").mem.zeroes(Buffer),
};
pub const ImageMemoryRequirementsInfo2 = extern struct {
    s_type: StructureType = .image_memory_requirements_info2,
    p_next: ?*const anyopaque = null,
    image: Image = @import("std").mem.zeroes(Image),
};
pub const ImageSparseMemoryRequirementsInfo2 = extern struct {
    s_type: StructureType = .image_sparse_memory_requirements_info2,
    p_next: ?*const anyopaque = null,
    image: Image = @import("std").mem.zeroes(Image),
};
pub const MemoryRequirements2 = extern struct {
    s_type: StructureType = .memory_requirements2,
    p_next: ?*anyopaque = null,
    memory_requirements: MemoryRequirements = @import("std").mem.zeroes(MemoryRequirements),
};
pub const SparseImageMemoryRequirements2 = extern struct {
    s_type: StructureType = .sparse_image_memory_requirements2,
    p_next: ?*anyopaque = null,
    memory_requirements: SparseImageMemoryRequirements = @import("std").mem.zeroes(SparseImageMemoryRequirements),
};
pub const PhysicalDeviceFeatures2 = extern struct {
    s_type: StructureType = .physical_device_features2,
    p_next: ?*anyopaque = null,
    features: PhysicalDeviceFeatures = @import("std").mem.zeroes(PhysicalDeviceFeatures),
};
pub const PhysicalDeviceProperties2 = extern struct {
    s_type: StructureType = .physical_device_properties2,
    p_next: ?*anyopaque = null,
    properties: PhysicalDeviceProperties = @import("std").mem.zeroes(PhysicalDeviceProperties),
};
pub const FormatProperties2 = extern struct {
    s_type: StructureType = .format_properties2,
    p_next: ?*anyopaque = null,
    format_properties: FormatProperties = @import("std").mem.zeroes(FormatProperties),
};
pub const ImageFormatProperties2 = extern struct {
    s_type: StructureType = .image_format_properties2,
    p_next: ?*anyopaque = null,
    image_format_properties: ImageFormatProperties = @import("std").mem.zeroes(ImageFormatProperties),
};
pub const PhysicalDeviceImageFormatInfo2 = extern struct {
    s_type: StructureType = .physical_device_image_format_info2,
    p_next: ?*const anyopaque = null,
    format: Format = @import("std").mem.zeroes(Format),
    type: ImageType = @import("std").mem.zeroes(ImageType),
    tiling: ImageTiling = @import("std").mem.zeroes(ImageTiling),
    usage: ImageUsageFlags = @import("std").mem.zeroes(ImageUsageFlags),
    flags: ImageCreateFlags = @import("std").mem.zeroes(ImageCreateFlags),
};
pub const QueueFamilyProperties2 = extern struct {
    s_type: StructureType = .queue_family_properties2,
    p_next: ?*anyopaque = null,
    queue_family_properties: QueueFamilyProperties = @import("std").mem.zeroes(QueueFamilyProperties),
};
pub const PhysicalDeviceMemoryProperties2 = extern struct {
    s_type: StructureType = .physical_device_memory_properties2,
    p_next: ?*anyopaque = null,
    memory_properties: PhysicalDeviceMemoryProperties = @import("std").mem.zeroes(PhysicalDeviceMemoryProperties),
};
pub const SparseImageFormatProperties2 = extern struct {
    s_type: StructureType = .sparse_image_format_properties2,
    p_next: ?*anyopaque = null,
    properties: SparseImageFormatProperties = @import("std").mem.zeroes(SparseImageFormatProperties),
};
pub const PhysicalDeviceSparseImageFormatInfo2 = extern struct {
    s_type: StructureType = .physical_device_sparse_image_format_info2,
    p_next: ?*const anyopaque = null,
    format: Format = @import("std").mem.zeroes(Format),
    type: ImageType = @import("std").mem.zeroes(ImageType),
    samples: SampleCountFlagBits = @import("std").mem.zeroes(SampleCountFlagBits),
    usage: ImageUsageFlags = @import("std").mem.zeroes(ImageUsageFlags),
    tiling: ImageTiling = @import("std").mem.zeroes(ImageTiling),
};
pub const PhysicalDevicePointClippingProperties = extern struct {
    s_type: StructureType = .physical_device_point_clipping_properties,
    p_next: ?*anyopaque = null,
    point_clipping_behavior: PointClippingBehavior = @import("std").mem.zeroes(PointClippingBehavior),
};
pub const InputAttachmentAspectReference = extern struct {
    subpass: u32 = @import("std").mem.zeroes(u32),
    input_attachment_index: u32 = @import("std").mem.zeroes(u32),
    aspect_mask: ImageAspectFlags = @import("std").mem.zeroes(ImageAspectFlags),
};
pub const RenderPassInputAttachmentAspectCreateInfo = extern struct {
    s_type: StructureType = .render_pass_input_attachment_aspect_create_info,
    p_next: ?*const anyopaque = null,
    aspect_reference_count: u32 = @import("std").mem.zeroes(u32),
    p_aspect_references: [*c]const InputAttachmentAspectReference = @import("std").mem.zeroes([*c]const InputAttachmentAspectReference),
};
pub const ImageViewUsageCreateInfo = extern struct {
    s_type: StructureType = .image_view_usage_create_info,
    p_next: ?*const anyopaque = null,
    usage: ImageUsageFlags = @import("std").mem.zeroes(ImageUsageFlags),
};
pub const PipelineTessellationDomainOriginStateCreateInfo = extern struct {
    s_type: StructureType = .pipeline_tessellation_domain_origin_state_create_info,
    p_next: ?*const anyopaque = null,
    domain_origin: TessellationDomainOrigin = @import("std").mem.zeroes(TessellationDomainOrigin),
};
pub const RenderPassMultiviewCreateInfo = extern struct {
    s_type: StructureType = .render_pass_multiview_create_info,
    p_next: ?*const anyopaque = null,
    subpass_count: u32 = @import("std").mem.zeroes(u32),
    p_view_masks: [*c]const u32 = @import("std").mem.zeroes([*c]const u32),
    dependency_count: u32 = @import("std").mem.zeroes(u32),
    p_view_offsets: [*c]const i32 = @import("std").mem.zeroes([*c]const i32),
    correlation_mask_count: u32 = @import("std").mem.zeroes(u32),
    p_correlation_masks: [*c]const u32 = @import("std").mem.zeroes([*c]const u32),
};
pub const PhysicalDeviceMultiviewFeatures = extern struct {
    s_type: StructureType = .physical_device_multiview_features,
    p_next: ?*anyopaque = null,
    multiview: Bool32 = @import("std").mem.zeroes(Bool32),
    multiview_geometry_shader: Bool32 = @import("std").mem.zeroes(Bool32),
    multiview_tessellation_shader: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceMultiviewProperties = extern struct {
    s_type: StructureType = .physical_device_multiview_properties,
    p_next: ?*anyopaque = null,
    max_multiview_view_count: u32 = @import("std").mem.zeroes(u32),
    max_multiview_instance_index: u32 = @import("std").mem.zeroes(u32),
};
pub const PhysicalDeviceVariablePointersFeatures = extern struct {
    s_type: StructureType = .physical_device_variable_pointers_features,
    p_next: ?*anyopaque = null,
    variable_pointers_storage_buffer: Bool32 = @import("std").mem.zeroes(Bool32),
    variable_pointers: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceProtectedMemoryFeatures = extern struct {
    s_type: StructureType = .physical_device_protected_memory_features,
    p_next: ?*anyopaque = null,
    protected_memory: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceProtectedMemoryProperties = extern struct {
    s_type: StructureType = .physical_device_protected_memory_properties,
    p_next: ?*anyopaque = null,
    protected_no_fault: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const DeviceQueueInfo2 = extern struct {
    s_type: StructureType = .device_queue_info2,
    p_next: ?*const anyopaque = null,
    flags: DeviceQueueCreateFlags = @import("std").mem.zeroes(DeviceQueueCreateFlags),
    queue_family_index: u32 = @import("std").mem.zeroes(u32),
    queue_index: u32 = @import("std").mem.zeroes(u32),
};
pub const ProtectedSubmitInfo = extern struct {
    s_type: StructureType = .protected_submit_info,
    p_next: ?*const anyopaque = null,
    protected_submit: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const SamplerYcbcrConversionCreateInfo = extern struct {
    s_type: StructureType = .sampler_ycbcr_conversion_create_info,
    p_next: ?*const anyopaque = null,
    format: Format = @import("std").mem.zeroes(Format),
    ycbcr_model: SamplerYcbcrModelConversion = @import("std").mem.zeroes(SamplerYcbcrModelConversion),
    ycbcr_range: SamplerYcbcrRange = @import("std").mem.zeroes(SamplerYcbcrRange),
    components: ComponentMapping = @import("std").mem.zeroes(ComponentMapping),
    x_chroma_offset: ChromaLocation = @import("std").mem.zeroes(ChromaLocation),
    y_chroma_offset: ChromaLocation = @import("std").mem.zeroes(ChromaLocation),
    chroma_filter: Filter = @import("std").mem.zeroes(Filter),
    force_explicit_reconstruction: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const SamplerYcbcrConversionInfo = extern struct {
    s_type: StructureType = .sampler_ycbcr_conversion_info,
    p_next: ?*const anyopaque = null,
    conversion: SamplerYcbcrConversion = @import("std").mem.zeroes(SamplerYcbcrConversion),
};
pub const BindImagePlaneMemoryInfo = extern struct {
    s_type: StructureType = .bind_image_plane_memory_info,
    p_next: ?*const anyopaque = null,
    plane_aspect: ImageAspectFlagBits = @import("std").mem.zeroes(ImageAspectFlagBits),
};
pub const ImagePlaneMemoryRequirementsInfo = extern struct {
    s_type: StructureType = .image_plane_memory_requirements_info,
    p_next: ?*const anyopaque = null,
    plane_aspect: ImageAspectFlagBits = @import("std").mem.zeroes(ImageAspectFlagBits),
};
pub const PhysicalDeviceSamplerYcbcrConversionFeatures = extern struct {
    s_type: StructureType = .physical_device_sampler_ycbcr_conversion_features,
    p_next: ?*anyopaque = null,
    sampler_ycbcr_conversion: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const SamplerYcbcrConversionImageFormatProperties = extern struct {
    s_type: StructureType = .sampler_ycbcr_conversion_image_format_properties,
    p_next: ?*anyopaque = null,
    combined_image_sampler_descriptor_count: u32 = @import("std").mem.zeroes(u32),
};
pub const DescriptorUpdateTemplateEntry = extern struct {
    dst_binding: u32 = @import("std").mem.zeroes(u32),
    dst_array_element: u32 = @import("std").mem.zeroes(u32),
    descriptor_count: u32 = @import("std").mem.zeroes(u32),
    descriptor_type: DescriptorType = @import("std").mem.zeroes(DescriptorType),
    offset: usize = @import("std").mem.zeroes(usize),
    stride: usize = @import("std").mem.zeroes(usize),
};
pub const DescriptorUpdateTemplateCreateInfo = extern struct {
    s_type: StructureType = .descriptor_update_template_create_info,
    p_next: ?*const anyopaque = null,
    flags: DescriptorUpdateTemplateCreateFlags = @import("std").mem.zeroes(DescriptorUpdateTemplateCreateFlags),
    descriptor_update_entry_count: u32 = @import("std").mem.zeroes(u32),
    p_descriptor_update_entries: [*c]const DescriptorUpdateTemplateEntry = @import("std").mem.zeroes([*c]const DescriptorUpdateTemplateEntry),
    template_type: DescriptorUpdateTemplateType = @import("std").mem.zeroes(DescriptorUpdateTemplateType),
    descriptor_set_layout: DescriptorSetLayout = @import("std").mem.zeroes(DescriptorSetLayout),
    pipeline_bind_point: PipelineBindPoint = @import("std").mem.zeroes(PipelineBindPoint),
    pipeline_layout: PipelineLayout = @import("std").mem.zeroes(PipelineLayout),
    set: u32 = @import("std").mem.zeroes(u32),
};
pub const ExternalMemoryProperties = extern struct {
    external_memory_features: ExternalMemoryFeatureFlags = @import("std").mem.zeroes(ExternalMemoryFeatureFlags),
    export_from_imported_handle_types: ExternalMemoryHandleTypeFlags = @import("std").mem.zeroes(ExternalMemoryHandleTypeFlags),
    compatible_handle_types: ExternalMemoryHandleTypeFlags = @import("std").mem.zeroes(ExternalMemoryHandleTypeFlags),
};
pub const PhysicalDeviceExternalImageFormatInfo = extern struct {
    s_type: StructureType = .physical_device_external_image_format_info,
    p_next: ?*const anyopaque = null,
    handle_type: ExternalMemoryHandleTypeFlagBits = @import("std").mem.zeroes(ExternalMemoryHandleTypeFlagBits),
};
pub const ExternalImageFormatProperties = extern struct {
    s_type: StructureType = .external_image_format_properties,
    p_next: ?*anyopaque = null,
    external_memory_properties: ExternalMemoryProperties = @import("std").mem.zeroes(ExternalMemoryProperties),
};
pub const PhysicalDeviceExternalBufferInfo = extern struct {
    s_type: StructureType = .physical_device_external_buffer_info,
    p_next: ?*const anyopaque = null,
    flags: BufferCreateFlags = @import("std").mem.zeroes(BufferCreateFlags),
    usage: BufferUsageFlags = @import("std").mem.zeroes(BufferUsageFlags),
    handle_type: ExternalMemoryHandleTypeFlagBits = @import("std").mem.zeroes(ExternalMemoryHandleTypeFlagBits),
};
pub const ExternalBufferProperties = extern struct {
    s_type: StructureType = .external_buffer_properties,
    p_next: ?*anyopaque = null,
    external_memory_properties: ExternalMemoryProperties = @import("std").mem.zeroes(ExternalMemoryProperties),
};
pub const PhysicalDeviceIDProperties = extern struct {
    s_type: StructureType = .physical_device_idproperties,
    p_next: ?*anyopaque = null,
    device_uuid: [16]u8 = @import("std").mem.zeroes([16]u8),
    driver_uuid: [16]u8 = @import("std").mem.zeroes([16]u8),
    device_luid: [8]u8 = @import("std").mem.zeroes([8]u8),
    device_node_mask: u32 = @import("std").mem.zeroes(u32),
    device_luidvalid: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const ExternalMemoryImageCreateInfo = extern struct {
    s_type: StructureType = .external_memory_image_create_info,
    p_next: ?*const anyopaque = null,
    handle_types: ExternalMemoryHandleTypeFlags = @import("std").mem.zeroes(ExternalMemoryHandleTypeFlags),
};
pub const ExternalMemoryBufferCreateInfo = extern struct {
    s_type: StructureType = .external_memory_buffer_create_info,
    p_next: ?*const anyopaque = null,
    handle_types: ExternalMemoryHandleTypeFlags = @import("std").mem.zeroes(ExternalMemoryHandleTypeFlags),
};
pub const ExportMemoryAllocateInfo = extern struct {
    s_type: StructureType = .export_memory_allocate_info,
    p_next: ?*const anyopaque = null,
    handle_types: ExternalMemoryHandleTypeFlags = @import("std").mem.zeroes(ExternalMemoryHandleTypeFlags),
};
pub const PhysicalDeviceExternalFenceInfo = extern struct {
    s_type: StructureType = .physical_device_external_fence_info,
    p_next: ?*const anyopaque = null,
    handle_type: ExternalFenceHandleTypeFlagBits = @import("std").mem.zeroes(ExternalFenceHandleTypeFlagBits),
};
pub const ExternalFenceProperties = extern struct {
    s_type: StructureType = .external_fence_properties,
    p_next: ?*anyopaque = null,
    export_from_imported_handle_types: ExternalFenceHandleTypeFlags = @import("std").mem.zeroes(ExternalFenceHandleTypeFlags),
    compatible_handle_types: ExternalFenceHandleTypeFlags = @import("std").mem.zeroes(ExternalFenceHandleTypeFlags),
    external_fence_features: ExternalFenceFeatureFlags = @import("std").mem.zeroes(ExternalFenceFeatureFlags),
};
pub const ExportFenceCreateInfo = extern struct {
    s_type: StructureType = .export_fence_create_info,
    p_next: ?*const anyopaque = null,
    handle_types: ExternalFenceHandleTypeFlags = @import("std").mem.zeroes(ExternalFenceHandleTypeFlags),
};
pub const ExportSemaphoreCreateInfo = extern struct {
    s_type: StructureType = .export_semaphore_create_info,
    p_next: ?*const anyopaque = null,
    handle_types: ExternalSemaphoreHandleTypeFlags = @import("std").mem.zeroes(ExternalSemaphoreHandleTypeFlags),
};
pub const PhysicalDeviceExternalSemaphoreInfo = extern struct {
    s_type: StructureType = .physical_device_external_semaphore_info,
    p_next: ?*const anyopaque = null,
    handle_type: ExternalSemaphoreHandleTypeFlagBits = @import("std").mem.zeroes(ExternalSemaphoreHandleTypeFlagBits),
};
pub const ExternalSemaphoreProperties = extern struct {
    s_type: StructureType = .external_semaphore_properties,
    p_next: ?*anyopaque = null,
    export_from_imported_handle_types: ExternalSemaphoreHandleTypeFlags = @import("std").mem.zeroes(ExternalSemaphoreHandleTypeFlags),
    compatible_handle_types: ExternalSemaphoreHandleTypeFlags = @import("std").mem.zeroes(ExternalSemaphoreHandleTypeFlags),
    external_semaphore_features: ExternalSemaphoreFeatureFlags = @import("std").mem.zeroes(ExternalSemaphoreFeatureFlags),
};
pub const PhysicalDeviceMaintenance3Properties = extern struct {
    s_type: StructureType = .physical_device_maintenance3properties,
    p_next: ?*anyopaque = null,
    max_per_set_descriptors: u32 = @import("std").mem.zeroes(u32),
    max_memory_allocation_size: DeviceSize = @import("std").mem.zeroes(DeviceSize),
};
pub const DescriptorSetLayoutSupport = extern struct {
    s_type: StructureType = .descriptor_set_layout_support,
    p_next: ?*anyopaque = null,
    supported: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceShaderDrawParametersFeatures = extern struct {
    s_type: StructureType = .physical_device_shader_draw_parameters_features,
    p_next: ?*anyopaque = null,
    shader_draw_parameters: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceVulkan11Features = extern struct {
    s_type: StructureType = .physical_device_vulkan11_features,
    p_next: ?*anyopaque = null,
    storage_buffer16_bit_access: Bool32 = @import("std").mem.zeroes(Bool32),
    uniform_and_storage_buffer16_bit_access: Bool32 = @import("std").mem.zeroes(Bool32),
    storage_push_constant16: Bool32 = @import("std").mem.zeroes(Bool32),
    storage_input_output16: Bool32 = @import("std").mem.zeroes(Bool32),
    multiview: Bool32 = @import("std").mem.zeroes(Bool32),
    multiview_geometry_shader: Bool32 = @import("std").mem.zeroes(Bool32),
    multiview_tessellation_shader: Bool32 = @import("std").mem.zeroes(Bool32),
    variable_pointers_storage_buffer: Bool32 = @import("std").mem.zeroes(Bool32),
    variable_pointers: Bool32 = @import("std").mem.zeroes(Bool32),
    protected_memory: Bool32 = @import("std").mem.zeroes(Bool32),
    sampler_ycbcr_conversion: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_draw_parameters: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceVulkan11Properties = extern struct {
    s_type: StructureType = .physical_device_vulkan11_properties,
    p_next: ?*anyopaque = null,
    device_uuid: [16]u8 = @import("std").mem.zeroes([16]u8),
    driver_uuid: [16]u8 = @import("std").mem.zeroes([16]u8),
    device_luid: [8]u8 = @import("std").mem.zeroes([8]u8),
    device_node_mask: u32 = @import("std").mem.zeroes(u32),
    device_luidvalid: Bool32 = @import("std").mem.zeroes(Bool32),
    subgroup_size: u32 = @import("std").mem.zeroes(u32),
    subgroup_supported_stages: ShaderStageFlags = @import("std").mem.zeroes(ShaderStageFlags),
    subgroup_supported_operations: SubgroupFeatureFlags = @import("std").mem.zeroes(SubgroupFeatureFlags),
    subgroup_quad_operations_in_all_stages: Bool32 = @import("std").mem.zeroes(Bool32),
    point_clipping_behavior: PointClippingBehavior = @import("std").mem.zeroes(PointClippingBehavior),
    max_multiview_view_count: u32 = @import("std").mem.zeroes(u32),
    max_multiview_instance_index: u32 = @import("std").mem.zeroes(u32),
    protected_no_fault: Bool32 = @import("std").mem.zeroes(Bool32),
    max_per_set_descriptors: u32 = @import("std").mem.zeroes(u32),
    max_memory_allocation_size: DeviceSize = @import("std").mem.zeroes(DeviceSize),
};
pub const PhysicalDeviceVulkan12Features = extern struct {
    s_type: StructureType = .physical_device_vulkan12_features,
    p_next: ?*anyopaque = null,
    sampler_mirror_clamp_to_edge: Bool32 = @import("std").mem.zeroes(Bool32),
    draw_indirect_count: Bool32 = @import("std").mem.zeroes(Bool32),
    storage_buffer8bit_access: Bool32 = @import("std").mem.zeroes(Bool32),
    uniform_and_storage_buffer8bit_access: Bool32 = @import("std").mem.zeroes(Bool32),
    storage_push_constant8: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_buffer_int64_atomics: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_shared_int64_atomics: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_float16: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_int8: Bool32 = @import("std").mem.zeroes(Bool32),
    descriptor_indexing: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_input_attachment_array_dynamic_indexing: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_uniform_texel_buffer_array_dynamic_indexing: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_storage_texel_buffer_array_dynamic_indexing: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_uniform_buffer_array_non_uniform_indexing: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_sampled_image_array_non_uniform_indexing: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_storage_buffer_array_non_uniform_indexing: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_storage_image_array_non_uniform_indexing: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_input_attachment_array_non_uniform_indexing: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_uniform_texel_buffer_array_non_uniform_indexing: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_storage_texel_buffer_array_non_uniform_indexing: Bool32 = @import("std").mem.zeroes(Bool32),
    descriptor_binding_uniform_buffer_update_after_bind: Bool32 = @import("std").mem.zeroes(Bool32),
    descriptor_binding_sampled_image_update_after_bind: Bool32 = @import("std").mem.zeroes(Bool32),
    descriptor_binding_storage_image_update_after_bind: Bool32 = @import("std").mem.zeroes(Bool32),
    descriptor_binding_storage_buffer_update_after_bind: Bool32 = @import("std").mem.zeroes(Bool32),
    descriptor_binding_uniform_texel_buffer_update_after_bind: Bool32 = @import("std").mem.zeroes(Bool32),
    descriptor_binding_storage_texel_buffer_update_after_bind: Bool32 = @import("std").mem.zeroes(Bool32),
    descriptor_binding_update_unused_while_pending: Bool32 = @import("std").mem.zeroes(Bool32),
    descriptor_binding_partially_bound: Bool32 = @import("std").mem.zeroes(Bool32),
    descriptor_binding_variable_descriptor_count: Bool32 = @import("std").mem.zeroes(Bool32),
    runtime_descriptor_array: Bool32 = @import("std").mem.zeroes(Bool32),
    sampler_filter_minmax: Bool32 = @import("std").mem.zeroes(Bool32),
    scalar_block_layout: Bool32 = @import("std").mem.zeroes(Bool32),
    imageless_framebuffer: Bool32 = @import("std").mem.zeroes(Bool32),
    uniform_buffer_standard_layout: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_subgroup_extended_types: Bool32 = @import("std").mem.zeroes(Bool32),
    separate_depth_stencil_layouts: Bool32 = @import("std").mem.zeroes(Bool32),
    host_query_reset: Bool32 = @import("std").mem.zeroes(Bool32),
    timeline_semaphore: Bool32 = @import("std").mem.zeroes(Bool32),
    buffer_device_address: Bool32 = @import("std").mem.zeroes(Bool32),
    buffer_device_address_capture_replay: Bool32 = @import("std").mem.zeroes(Bool32),
    buffer_device_address_multi_device: Bool32 = @import("std").mem.zeroes(Bool32),
    vulkan_memory_model: Bool32 = @import("std").mem.zeroes(Bool32),
    vulkan_memory_model_device_scope: Bool32 = @import("std").mem.zeroes(Bool32),
    vulkan_memory_model_availability_visibility_chains: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_output_viewport_index: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_output_layer: Bool32 = @import("std").mem.zeroes(Bool32),
    subgroup_broadcast_dynamic_id: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const ConformanceVersion = extern struct {
    major: u8 = @import("std").mem.zeroes(u8),
    minor: u8 = @import("std").mem.zeroes(u8),
    subminor: u8 = @import("std").mem.zeroes(u8),
    patch: u8 = @import("std").mem.zeroes(u8),
};
pub const PhysicalDeviceVulkan12Properties = extern struct {
    s_type: StructureType = .physical_device_vulkan12_properties,
    p_next: ?*anyopaque = null,
    driver_id: DriverId = @import("std").mem.zeroes(DriverId),
    driver_name: [256]u8 = @import("std").mem.zeroes([256]u8),
    driver_info: [256]u8 = @import("std").mem.zeroes([256]u8),
    conformance_version: ConformanceVersion = @import("std").mem.zeroes(ConformanceVersion),
    denorm_behavior_independence: ShaderFloatControlsIndependence = @import("std").mem.zeroes(ShaderFloatControlsIndependence),
    rounding_mode_independence: ShaderFloatControlsIndependence = @import("std").mem.zeroes(ShaderFloatControlsIndependence),
    shader_signed_zero_inf_nan_preserve_float16: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_signed_zero_inf_nan_preserve_float32: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_signed_zero_inf_nan_preserve_float64: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_denorm_preserve_float16: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_denorm_preserve_float32: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_denorm_preserve_float64: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_denorm_flush_to_zero_float16: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_denorm_flush_to_zero_float32: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_denorm_flush_to_zero_float64: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_rounding_mode_rtefloat16: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_rounding_mode_rtefloat32: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_rounding_mode_rtefloat64: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_rounding_mode_rtzfloat16: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_rounding_mode_rtzfloat32: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_rounding_mode_rtzfloat64: Bool32 = @import("std").mem.zeroes(Bool32),
    max_update_after_bind_descriptors_in_all_pools: u32 = @import("std").mem.zeroes(u32),
    shader_uniform_buffer_array_non_uniform_indexing_native: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_sampled_image_array_non_uniform_indexing_native: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_storage_buffer_array_non_uniform_indexing_native: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_storage_image_array_non_uniform_indexing_native: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_input_attachment_array_non_uniform_indexing_native: Bool32 = @import("std").mem.zeroes(Bool32),
    robust_buffer_access_update_after_bind: Bool32 = @import("std").mem.zeroes(Bool32),
    quad_divergent_implicit_lod: Bool32 = @import("std").mem.zeroes(Bool32),
    max_per_stage_descriptor_update_after_bind_samplers: u32 = @import("std").mem.zeroes(u32),
    max_per_stage_descriptor_update_after_bind_uniform_buffers: u32 = @import("std").mem.zeroes(u32),
    max_per_stage_descriptor_update_after_bind_storage_buffers: u32 = @import("std").mem.zeroes(u32),
    max_per_stage_descriptor_update_after_bind_sampled_images: u32 = @import("std").mem.zeroes(u32),
    max_per_stage_descriptor_update_after_bind_storage_images: u32 = @import("std").mem.zeroes(u32),
    max_per_stage_descriptor_update_after_bind_input_attachments: u32 = @import("std").mem.zeroes(u32),
    max_per_stage_update_after_bind_resources: u32 = @import("std").mem.zeroes(u32),
    max_descriptor_set_update_after_bind_samplers: u32 = @import("std").mem.zeroes(u32),
    max_descriptor_set_update_after_bind_uniform_buffers: u32 = @import("std").mem.zeroes(u32),
    max_descriptor_set_update_after_bind_uniform_buffers_dynamic: u32 = @import("std").mem.zeroes(u32),
    max_descriptor_set_update_after_bind_storage_buffers: u32 = @import("std").mem.zeroes(u32),
    max_descriptor_set_update_after_bind_storage_buffers_dynamic: u32 = @import("std").mem.zeroes(u32),
    max_descriptor_set_update_after_bind_sampled_images: u32 = @import("std").mem.zeroes(u32),
    max_descriptor_set_update_after_bind_storage_images: u32 = @import("std").mem.zeroes(u32),
    max_descriptor_set_update_after_bind_input_attachments: u32 = @import("std").mem.zeroes(u32),
    supported_depth_resolve_modes: ResolveModeFlags = @import("std").mem.zeroes(ResolveModeFlags),
    supported_stencil_resolve_modes: ResolveModeFlags = @import("std").mem.zeroes(ResolveModeFlags),
    independent_resolve_none: Bool32 = @import("std").mem.zeroes(Bool32),
    independent_resolve: Bool32 = @import("std").mem.zeroes(Bool32),
    filter_minmax_single_component_formats: Bool32 = @import("std").mem.zeroes(Bool32),
    filter_minmax_image_component_mapping: Bool32 = @import("std").mem.zeroes(Bool32),
    max_timeline_semaphore_value_difference: u64 = @import("std").mem.zeroes(u64),
    framebuffer_integer_color_sample_counts: SampleCountFlags = @import("std").mem.zeroes(SampleCountFlags),
};
pub const ImageFormatListCreateInfo = extern struct {
    s_type: StructureType = .image_format_list_create_info,
    p_next: ?*const anyopaque = null,
    view_format_count: u32 = @import("std").mem.zeroes(u32),
    p_view_formats: [*c]const Format = @import("std").mem.zeroes([*c]const Format),
};
pub const AttachmentDescription2 = extern struct {
    s_type: StructureType = .attachment_description2,
    p_next: ?*const anyopaque = null,
    flags: AttachmentDescriptionFlags = @import("std").mem.zeroes(AttachmentDescriptionFlags),
    format: Format = @import("std").mem.zeroes(Format),
    samples: SampleCountFlagBits = @import("std").mem.zeroes(SampleCountFlagBits),
    load_op: AttachmentLoadOp = @import("std").mem.zeroes(AttachmentLoadOp),
    store_op: AttachmentStoreOp = @import("std").mem.zeroes(AttachmentStoreOp),
    stencil_load_op: AttachmentLoadOp = @import("std").mem.zeroes(AttachmentLoadOp),
    stencil_store_op: AttachmentStoreOp = @import("std").mem.zeroes(AttachmentStoreOp),
    initial_layout: ImageLayout = @import("std").mem.zeroes(ImageLayout),
    final_layout: ImageLayout = @import("std").mem.zeroes(ImageLayout),
};
pub const AttachmentReference2 = extern struct {
    s_type: StructureType = .attachment_reference2,
    p_next: ?*const anyopaque = null,
    attachment: u32 = @import("std").mem.zeroes(u32),
    layout: ImageLayout = @import("std").mem.zeroes(ImageLayout),
    aspect_mask: ImageAspectFlags = @import("std").mem.zeroes(ImageAspectFlags),
};
pub const SubpassDescription2 = extern struct {
    s_type: StructureType = .subpass_description2,
    p_next: ?*const anyopaque = null,
    flags: SubpassDescriptionFlags = @import("std").mem.zeroes(SubpassDescriptionFlags),
    pipeline_bind_point: PipelineBindPoint = @import("std").mem.zeroes(PipelineBindPoint),
    view_mask: u32 = @import("std").mem.zeroes(u32),
    input_attachment_count: u32 = @import("std").mem.zeroes(u32),
    p_input_attachments: [*c]const AttachmentReference2 = @import("std").mem.zeroes([*c]const AttachmentReference2),
    color_attachment_count: u32 = @import("std").mem.zeroes(u32),
    p_color_attachments: [*c]const AttachmentReference2 = @import("std").mem.zeroes([*c]const AttachmentReference2),
    p_resolve_attachments: [*c]const AttachmentReference2 = @import("std").mem.zeroes([*c]const AttachmentReference2),
    p_depth_stencil_attachment: [*c]const AttachmentReference2 = @import("std").mem.zeroes([*c]const AttachmentReference2),
    preserve_attachment_count: u32 = @import("std").mem.zeroes(u32),
    p_preserve_attachments: [*c]const u32 = @import("std").mem.zeroes([*c]const u32),
};
pub const SubpassDependency2 = extern struct {
    s_type: StructureType = .subpass_dependency2,
    p_next: ?*const anyopaque = null,
    src_subpass: u32 = @import("std").mem.zeroes(u32),
    dst_subpass: u32 = @import("std").mem.zeroes(u32),
    src_stage_mask: PipelineStageFlags = @import("std").mem.zeroes(PipelineStageFlags),
    dst_stage_mask: PipelineStageFlags = @import("std").mem.zeroes(PipelineStageFlags),
    src_access_mask: AccessFlags = @import("std").mem.zeroes(AccessFlags),
    dst_access_mask: AccessFlags = @import("std").mem.zeroes(AccessFlags),
    dependency_flags: DependencyFlags = @import("std").mem.zeroes(DependencyFlags),
    view_offset: i32 = @import("std").mem.zeroes(i32),
};
pub const RenderPassCreateInfo2 = extern struct {
    s_type: StructureType = .render_pass_create_info2,
    p_next: ?*const anyopaque = null,
    flags: RenderPassCreateFlags = @import("std").mem.zeroes(RenderPassCreateFlags),
    attachment_count: u32 = @import("std").mem.zeroes(u32),
    p_attachments: [*c]const AttachmentDescription2 = @import("std").mem.zeroes([*c]const AttachmentDescription2),
    subpass_count: u32 = @import("std").mem.zeroes(u32),
    p_subpasses: [*c]const SubpassDescription2 = @import("std").mem.zeroes([*c]const SubpassDescription2),
    dependency_count: u32 = @import("std").mem.zeroes(u32),
    p_dependencies: [*c]const SubpassDependency2 = @import("std").mem.zeroes([*c]const SubpassDependency2),
    correlated_view_mask_count: u32 = @import("std").mem.zeroes(u32),
    p_correlated_view_masks: [*c]const u32 = @import("std").mem.zeroes([*c]const u32),
};
pub const SubpassBeginInfo = extern struct {
    s_type: StructureType = .subpass_begin_info,
    p_next: ?*const anyopaque = null,
    contents: SubpassContents = @import("std").mem.zeroes(SubpassContents),
};
pub const SubpassEndInfo = extern struct {
    s_type: StructureType = .subpass_end_info,
    p_next: ?*const anyopaque = null,
};
pub const PhysicalDevice8BitStorageFeatures = extern struct {
    s_type: StructureType = .physical_device8bit_storage_features,
    p_next: ?*anyopaque = null,
    storage_buffer8bit_access: Bool32 = @import("std").mem.zeroes(Bool32),
    uniform_and_storage_buffer8bit_access: Bool32 = @import("std").mem.zeroes(Bool32),
    storage_push_constant8: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceDriverProperties = extern struct {
    s_type: StructureType = .physical_device_driver_properties,
    p_next: ?*anyopaque = null,
    driver_id: DriverId = @import("std").mem.zeroes(DriverId),
    driver_name: [256]u8 = @import("std").mem.zeroes([256]u8),
    driver_info: [256]u8 = @import("std").mem.zeroes([256]u8),
    conformance_version: ConformanceVersion = @import("std").mem.zeroes(ConformanceVersion),
};
pub const PhysicalDeviceShaderAtomicInt64Features = extern struct {
    s_type: StructureType = .physical_device_shader_atomic_int64_features,
    p_next: ?*anyopaque = null,
    shader_buffer_int64_atomics: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_shared_int64_atomics: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceShaderFloat16Int8Features = extern struct {
    s_type: StructureType = .physical_device_shader_float16_int8_features,
    p_next: ?*anyopaque = null,
    shader_float16: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_int8: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceFloatControlsProperties = extern struct {
    s_type: StructureType = .physical_device_float_controls_properties,
    p_next: ?*anyopaque = null,
    denorm_behavior_independence: ShaderFloatControlsIndependence = @import("std").mem.zeroes(ShaderFloatControlsIndependence),
    rounding_mode_independence: ShaderFloatControlsIndependence = @import("std").mem.zeroes(ShaderFloatControlsIndependence),
    shader_signed_zero_inf_nan_preserve_float16: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_signed_zero_inf_nan_preserve_float32: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_signed_zero_inf_nan_preserve_float64: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_denorm_preserve_float16: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_denorm_preserve_float32: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_denorm_preserve_float64: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_denorm_flush_to_zero_float16: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_denorm_flush_to_zero_float32: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_denorm_flush_to_zero_float64: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_rounding_mode_rtefloat16: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_rounding_mode_rtefloat32: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_rounding_mode_rtefloat64: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_rounding_mode_rtzfloat16: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_rounding_mode_rtzfloat32: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_rounding_mode_rtzfloat64: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const DescriptorSetLayoutBindingFlagsCreateInfo = extern struct {
    s_type: StructureType = .descriptor_set_layout_binding_flags_create_info,
    p_next: ?*const anyopaque = null,
    binding_count: u32 = @import("std").mem.zeroes(u32),
    p_binding_flags: [*c]const DescriptorBindingFlags = @import("std").mem.zeroes([*c]const DescriptorBindingFlags),
};
pub const PhysicalDeviceDescriptorIndexingFeatures = extern struct {
    s_type: StructureType = .physical_device_descriptor_indexing_features,
    p_next: ?*anyopaque = null,
    shader_input_attachment_array_dynamic_indexing: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_uniform_texel_buffer_array_dynamic_indexing: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_storage_texel_buffer_array_dynamic_indexing: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_uniform_buffer_array_non_uniform_indexing: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_sampled_image_array_non_uniform_indexing: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_storage_buffer_array_non_uniform_indexing: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_storage_image_array_non_uniform_indexing: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_input_attachment_array_non_uniform_indexing: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_uniform_texel_buffer_array_non_uniform_indexing: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_storage_texel_buffer_array_non_uniform_indexing: Bool32 = @import("std").mem.zeroes(Bool32),
    descriptor_binding_uniform_buffer_update_after_bind: Bool32 = @import("std").mem.zeroes(Bool32),
    descriptor_binding_sampled_image_update_after_bind: Bool32 = @import("std").mem.zeroes(Bool32),
    descriptor_binding_storage_image_update_after_bind: Bool32 = @import("std").mem.zeroes(Bool32),
    descriptor_binding_storage_buffer_update_after_bind: Bool32 = @import("std").mem.zeroes(Bool32),
    descriptor_binding_uniform_texel_buffer_update_after_bind: Bool32 = @import("std").mem.zeroes(Bool32),
    descriptor_binding_storage_texel_buffer_update_after_bind: Bool32 = @import("std").mem.zeroes(Bool32),
    descriptor_binding_update_unused_while_pending: Bool32 = @import("std").mem.zeroes(Bool32),
    descriptor_binding_partially_bound: Bool32 = @import("std").mem.zeroes(Bool32),
    descriptor_binding_variable_descriptor_count: Bool32 = @import("std").mem.zeroes(Bool32),
    runtime_descriptor_array: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceDescriptorIndexingProperties = extern struct {
    s_type: StructureType = .physical_device_descriptor_indexing_properties,
    p_next: ?*anyopaque = null,
    max_update_after_bind_descriptors_in_all_pools: u32 = @import("std").mem.zeroes(u32),
    shader_uniform_buffer_array_non_uniform_indexing_native: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_sampled_image_array_non_uniform_indexing_native: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_storage_buffer_array_non_uniform_indexing_native: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_storage_image_array_non_uniform_indexing_native: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_input_attachment_array_non_uniform_indexing_native: Bool32 = @import("std").mem.zeroes(Bool32),
    robust_buffer_access_update_after_bind: Bool32 = @import("std").mem.zeroes(Bool32),
    quad_divergent_implicit_lod: Bool32 = @import("std").mem.zeroes(Bool32),
    max_per_stage_descriptor_update_after_bind_samplers: u32 = @import("std").mem.zeroes(u32),
    max_per_stage_descriptor_update_after_bind_uniform_buffers: u32 = @import("std").mem.zeroes(u32),
    max_per_stage_descriptor_update_after_bind_storage_buffers: u32 = @import("std").mem.zeroes(u32),
    max_per_stage_descriptor_update_after_bind_sampled_images: u32 = @import("std").mem.zeroes(u32),
    max_per_stage_descriptor_update_after_bind_storage_images: u32 = @import("std").mem.zeroes(u32),
    max_per_stage_descriptor_update_after_bind_input_attachments: u32 = @import("std").mem.zeroes(u32),
    max_per_stage_update_after_bind_resources: u32 = @import("std").mem.zeroes(u32),
    max_descriptor_set_update_after_bind_samplers: u32 = @import("std").mem.zeroes(u32),
    max_descriptor_set_update_after_bind_uniform_buffers: u32 = @import("std").mem.zeroes(u32),
    max_descriptor_set_update_after_bind_uniform_buffers_dynamic: u32 = @import("std").mem.zeroes(u32),
    max_descriptor_set_update_after_bind_storage_buffers: u32 = @import("std").mem.zeroes(u32),
    max_descriptor_set_update_after_bind_storage_buffers_dynamic: u32 = @import("std").mem.zeroes(u32),
    max_descriptor_set_update_after_bind_sampled_images: u32 = @import("std").mem.zeroes(u32),
    max_descriptor_set_update_after_bind_storage_images: u32 = @import("std").mem.zeroes(u32),
    max_descriptor_set_update_after_bind_input_attachments: u32 = @import("std").mem.zeroes(u32),
};
pub const DescriptorSetVariableDescriptorCountAllocateInfo = extern struct {
    s_type: StructureType = .descriptor_set_variable_descriptor_count_allocate_info,
    p_next: ?*const anyopaque = null,
    descriptor_set_count: u32 = @import("std").mem.zeroes(u32),
    p_descriptor_counts: [*c]const u32 = @import("std").mem.zeroes([*c]const u32),
};
pub const DescriptorSetVariableDescriptorCountLayoutSupport = extern struct {
    s_type: StructureType = .descriptor_set_variable_descriptor_count_layout_support,
    p_next: ?*anyopaque = null,
    max_variable_descriptor_count: u32 = @import("std").mem.zeroes(u32),
};
pub const SubpassDescriptionDepthStencilResolve = extern struct {
    s_type: StructureType = .subpass_description_depth_stencil_resolve,
    p_next: ?*const anyopaque = null,
    depth_resolve_mode: ResolveModeFlagBits = @import("std").mem.zeroes(ResolveModeFlagBits),
    stencil_resolve_mode: ResolveModeFlagBits = @import("std").mem.zeroes(ResolveModeFlagBits),
    p_depth_stencil_resolve_attachment: [*c]const AttachmentReference2 = @import("std").mem.zeroes([*c]const AttachmentReference2),
};
pub const PhysicalDeviceDepthStencilResolveProperties = extern struct {
    s_type: StructureType = .physical_device_depth_stencil_resolve_properties,
    p_next: ?*anyopaque = null,
    supported_depth_resolve_modes: ResolveModeFlags = @import("std").mem.zeroes(ResolveModeFlags),
    supported_stencil_resolve_modes: ResolveModeFlags = @import("std").mem.zeroes(ResolveModeFlags),
    independent_resolve_none: Bool32 = @import("std").mem.zeroes(Bool32),
    independent_resolve: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceScalarBlockLayoutFeatures = extern struct {
    s_type: StructureType = .physical_device_scalar_block_layout_features,
    p_next: ?*anyopaque = null,
    scalar_block_layout: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const ImageStencilUsageCreateInfo = extern struct {
    s_type: StructureType = .image_stencil_usage_create_info,
    p_next: ?*const anyopaque = null,
    stencil_usage: ImageUsageFlags = @import("std").mem.zeroes(ImageUsageFlags),
};
pub const SamplerReductionModeCreateInfo = extern struct {
    s_type: StructureType = .sampler_reduction_mode_create_info,
    p_next: ?*const anyopaque = null,
    reduction_mode: SamplerReductionMode = @import("std").mem.zeroes(SamplerReductionMode),
};
pub const PhysicalDeviceSamplerFilterMinmaxProperties = extern struct {
    s_type: StructureType = .physical_device_sampler_filter_minmax_properties,
    p_next: ?*anyopaque = null,
    filter_minmax_single_component_formats: Bool32 = @import("std").mem.zeroes(Bool32),
    filter_minmax_image_component_mapping: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceVulkanMemoryModelFeatures = extern struct {
    s_type: StructureType = .physical_device_vulkan_memory_model_features,
    p_next: ?*anyopaque = null,
    vulkan_memory_model: Bool32 = @import("std").mem.zeroes(Bool32),
    vulkan_memory_model_device_scope: Bool32 = @import("std").mem.zeroes(Bool32),
    vulkan_memory_model_availability_visibility_chains: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceImagelessFramebufferFeatures = extern struct {
    s_type: StructureType = .physical_device_imageless_framebuffer_features,
    p_next: ?*anyopaque = null,
    imageless_framebuffer: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const FramebufferAttachmentImageInfo = extern struct {
    s_type: StructureType = .framebuffer_attachment_image_info,
    p_next: ?*const anyopaque = null,
    flags: ImageCreateFlags = @import("std").mem.zeroes(ImageCreateFlags),
    usage: ImageUsageFlags = @import("std").mem.zeroes(ImageUsageFlags),
    width: u32 = @import("std").mem.zeroes(u32),
    height: u32 = @import("std").mem.zeroes(u32),
    layer_count: u32 = @import("std").mem.zeroes(u32),
    view_format_count: u32 = @import("std").mem.zeroes(u32),
    p_view_formats: [*c]const Format = @import("std").mem.zeroes([*c]const Format),
};
pub const FramebufferAttachmentsCreateInfo = extern struct {
    s_type: StructureType = .framebuffer_attachments_create_info,
    p_next: ?*const anyopaque = null,
    attachment_image_info_count: u32 = @import("std").mem.zeroes(u32),
    p_attachment_image_infos: [*c]const FramebufferAttachmentImageInfo = @import("std").mem.zeroes([*c]const FramebufferAttachmentImageInfo),
};
pub const RenderPassAttachmentBeginInfo = extern struct {
    s_type: StructureType = .render_pass_attachment_begin_info,
    p_next: ?*const anyopaque = null,
    attachment_count: u32 = @import("std").mem.zeroes(u32),
    p_attachments: [*c]const ImageView = @import("std").mem.zeroes([*c]const ImageView),
};
pub const PhysicalDeviceUniformBufferStandardLayoutFeatures = extern struct {
    s_type: StructureType = .physical_device_uniform_buffer_standard_layout_features,
    p_next: ?*anyopaque = null,
    uniform_buffer_standard_layout: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceShaderSubgroupExtendedTypesFeatures = extern struct {
    s_type: StructureType = .physical_device_shader_subgroup_extended_types_features,
    p_next: ?*anyopaque = null,
    shader_subgroup_extended_types: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceSeparateDepthStencilLayoutsFeatures = extern struct {
    s_type: StructureType = .physical_device_separate_depth_stencil_layouts_features,
    p_next: ?*anyopaque = null,
    separate_depth_stencil_layouts: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const AttachmentReferenceStencilLayout = extern struct {
    s_type: StructureType = .attachment_reference_stencil_layout,
    p_next: ?*anyopaque = null,
    stencil_layout: ImageLayout = @import("std").mem.zeroes(ImageLayout),
};
pub const AttachmentDescriptionStencilLayout = extern struct {
    s_type: StructureType = .attachment_description_stencil_layout,
    p_next: ?*anyopaque = null,
    stencil_initial_layout: ImageLayout = @import("std").mem.zeroes(ImageLayout),
    stencil_final_layout: ImageLayout = @import("std").mem.zeroes(ImageLayout),
};
pub const PhysicalDeviceHostQueryResetFeatures = extern struct {
    s_type: StructureType = .physical_device_host_query_reset_features,
    p_next: ?*anyopaque = null,
    host_query_reset: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceTimelineSemaphoreFeatures = extern struct {
    s_type: StructureType = .physical_device_timeline_semaphore_features,
    p_next: ?*anyopaque = null,
    timeline_semaphore: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceTimelineSemaphoreProperties = extern struct {
    s_type: StructureType = .physical_device_timeline_semaphore_properties,
    p_next: ?*anyopaque = null,
    max_timeline_semaphore_value_difference: u64 = @import("std").mem.zeroes(u64),
};
pub const SemaphoreTypeCreateInfo = extern struct {
    s_type: StructureType = .semaphore_type_create_info,
    p_next: ?*const anyopaque = null,
    semaphore_type: SemaphoreType = @import("std").mem.zeroes(SemaphoreType),
    initial_value: u64 = @import("std").mem.zeroes(u64),
};
pub const TimelineSemaphoreSubmitInfo = extern struct {
    s_type: StructureType = .timeline_semaphore_submit_info,
    p_next: ?*const anyopaque = null,
    wait_semaphore_value_count: u32 = @import("std").mem.zeroes(u32),
    p_wait_semaphore_values: [*c]const u64 = @import("std").mem.zeroes([*c]const u64),
    signal_semaphore_value_count: u32 = @import("std").mem.zeroes(u32),
    p_signal_semaphore_values: [*c]const u64 = @import("std").mem.zeroes([*c]const u64),
};
pub const SemaphoreWaitInfo = extern struct {
    s_type: StructureType = .semaphore_wait_info,
    p_next: ?*const anyopaque = null,
    flags: SemaphoreWaitFlags = @import("std").mem.zeroes(SemaphoreWaitFlags),
    semaphore_count: u32 = @import("std").mem.zeroes(u32),
    p_semaphores: [*c]const Semaphore = @import("std").mem.zeroes([*c]const Semaphore),
    p_values: [*c]const u64 = @import("std").mem.zeroes([*c]const u64),
};
pub const SemaphoreSignalInfo = extern struct {
    s_type: StructureType = .semaphore_signal_info,
    p_next: ?*const anyopaque = null,
    semaphore: Semaphore = @import("std").mem.zeroes(Semaphore),
    value: u64 = @import("std").mem.zeroes(u64),
};
pub const PhysicalDeviceBufferDeviceAddressFeatures = extern struct {
    s_type: StructureType = .physical_device_buffer_device_address_features,
    p_next: ?*anyopaque = null,
    buffer_device_address: Bool32 = @import("std").mem.zeroes(Bool32),
    buffer_device_address_capture_replay: Bool32 = @import("std").mem.zeroes(Bool32),
    buffer_device_address_multi_device: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const BufferDeviceAddressInfo = extern struct {
    s_type: StructureType = .buffer_device_address_info,
    p_next: ?*const anyopaque = null,
    buffer: Buffer = @import("std").mem.zeroes(Buffer),
};
pub const BufferOpaqueCaptureAddressCreateInfo = extern struct {
    s_type: StructureType = .buffer_opaque_capture_address_create_info,
    p_next: ?*const anyopaque = null,
    opaque_capture_address: u64 = @import("std").mem.zeroes(u64),
};
pub const MemoryOpaqueCaptureAddressAllocateInfo = extern struct {
    s_type: StructureType = .memory_opaque_capture_address_allocate_info,
    p_next: ?*const anyopaque = null,
    opaque_capture_address: u64 = @import("std").mem.zeroes(u64),
};
pub const DeviceMemoryOpaqueCaptureAddressInfo = extern struct {
    s_type: StructureType = .device_memory_opaque_capture_address_info,
    p_next: ?*const anyopaque = null,
    memory: DeviceMemory = @import("std").mem.zeroes(DeviceMemory),
};
pub const PhysicalDeviceVulkan13Features = extern struct {
    s_type: StructureType = .physical_device_vulkan13_features,
    p_next: ?*anyopaque = null,
    robust_image_access: Bool32 = @import("std").mem.zeroes(Bool32),
    inline_uniform_block: Bool32 = @import("std").mem.zeroes(Bool32),
    descriptor_binding_inline_uniform_block_update_after_bind: Bool32 = @import("std").mem.zeroes(Bool32),
    pipeline_creation_cache_control: Bool32 = @import("std").mem.zeroes(Bool32),
    private_data: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_demote_to_helper_invocation: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_terminate_invocation: Bool32 = @import("std").mem.zeroes(Bool32),
    subgroup_size_control: Bool32 = @import("std").mem.zeroes(Bool32),
    compute_full_subgroups: Bool32 = @import("std").mem.zeroes(Bool32),
    synchronization2: Bool32 = @import("std").mem.zeroes(Bool32),
    texture_compression_astc_hdr: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_zero_initialize_workgroup_memory: Bool32 = @import("std").mem.zeroes(Bool32),
    dynamic_rendering: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_integer_dot_product: Bool32 = @import("std").mem.zeroes(Bool32),
    maintenance4: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceVulkan13Properties = extern struct {
    s_type: StructureType = .physical_device_vulkan13_properties,
    p_next: ?*anyopaque = null,
    min_subgroup_size: u32 = @import("std").mem.zeroes(u32),
    max_subgroup_size: u32 = @import("std").mem.zeroes(u32),
    max_compute_workgroup_subgroups: u32 = @import("std").mem.zeroes(u32),
    required_subgroup_size_stages: ShaderStageFlags = @import("std").mem.zeroes(ShaderStageFlags),
    max_inline_uniform_block_size: u32 = @import("std").mem.zeroes(u32),
    max_per_stage_descriptor_inline_uniform_blocks: u32 = @import("std").mem.zeroes(u32),
    max_per_stage_descriptor_update_after_bind_inline_uniform_blocks: u32 = @import("std").mem.zeroes(u32),
    max_descriptor_set_inline_uniform_blocks: u32 = @import("std").mem.zeroes(u32),
    max_descriptor_set_update_after_bind_inline_uniform_blocks: u32 = @import("std").mem.zeroes(u32),
    max_inline_uniform_total_size: u32 = @import("std").mem.zeroes(u32),
    integer_dot_product8bit_unsigned_accelerated: Bool32 = @import("std").mem.zeroes(Bool32),
    integer_dot_product8bit_signed_accelerated: Bool32 = @import("std").mem.zeroes(Bool32),
    integer_dot_product8bit_mixed_signedness_accelerated: Bool32 = @import("std").mem.zeroes(Bool32),
    integer_dot_product4x8_bit_packed_unsigned_accelerated: Bool32 = @import("std").mem.zeroes(Bool32),
    integer_dot_product4x8_bit_packed_signed_accelerated: Bool32 = @import("std").mem.zeroes(Bool32),
    integer_dot_product4x8_bit_packed_mixed_signedness_accelerated: Bool32 = @import("std").mem.zeroes(Bool32),
    integer_dot_product16_bit_unsigned_accelerated: Bool32 = @import("std").mem.zeroes(Bool32),
    integer_dot_product16_bit_signed_accelerated: Bool32 = @import("std").mem.zeroes(Bool32),
    integer_dot_product16_bit_mixed_signedness_accelerated: Bool32 = @import("std").mem.zeroes(Bool32),
    integer_dot_product32_bit_unsigned_accelerated: Bool32 = @import("std").mem.zeroes(Bool32),
    integer_dot_product32_bit_signed_accelerated: Bool32 = @import("std").mem.zeroes(Bool32),
    integer_dot_product32_bit_mixed_signedness_accelerated: Bool32 = @import("std").mem.zeroes(Bool32),
    integer_dot_product64_bit_unsigned_accelerated: Bool32 = @import("std").mem.zeroes(Bool32),
    integer_dot_product64_bit_signed_accelerated: Bool32 = @import("std").mem.zeroes(Bool32),
    integer_dot_product64_bit_mixed_signedness_accelerated: Bool32 = @import("std").mem.zeroes(Bool32),
    integer_dot_product_accumulating_saturating8bit_unsigned_accelerated: Bool32 = @import("std").mem.zeroes(Bool32),
    integer_dot_product_accumulating_saturating8bit_signed_accelerated: Bool32 = @import("std").mem.zeroes(Bool32),
    integer_dot_product_accumulating_saturating8bit_mixed_signedness_accelerated: Bool32 = @import("std").mem.zeroes(Bool32),
    integer_dot_product_accumulating_saturating4x8_bit_packed_unsigned_accelerated: Bool32 = @import("std").mem.zeroes(Bool32),
    integer_dot_product_accumulating_saturating4x8_bit_packed_signed_accelerated: Bool32 = @import("std").mem.zeroes(Bool32),
    integer_dot_product_accumulating_saturating4x8_bit_packed_mixed_signedness_accelerated: Bool32 = @import("std").mem.zeroes(Bool32),
    integer_dot_product_accumulating_saturating16_bit_unsigned_accelerated: Bool32 = @import("std").mem.zeroes(Bool32),
    integer_dot_product_accumulating_saturating16_bit_signed_accelerated: Bool32 = @import("std").mem.zeroes(Bool32),
    integer_dot_product_accumulating_saturating16_bit_mixed_signedness_accelerated: Bool32 = @import("std").mem.zeroes(Bool32),
    integer_dot_product_accumulating_saturating32_bit_unsigned_accelerated: Bool32 = @import("std").mem.zeroes(Bool32),
    integer_dot_product_accumulating_saturating32_bit_signed_accelerated: Bool32 = @import("std").mem.zeroes(Bool32),
    integer_dot_product_accumulating_saturating32_bit_mixed_signedness_accelerated: Bool32 = @import("std").mem.zeroes(Bool32),
    integer_dot_product_accumulating_saturating64_bit_unsigned_accelerated: Bool32 = @import("std").mem.zeroes(Bool32),
    integer_dot_product_accumulating_saturating64_bit_signed_accelerated: Bool32 = @import("std").mem.zeroes(Bool32),
    integer_dot_product_accumulating_saturating64_bit_mixed_signedness_accelerated: Bool32 = @import("std").mem.zeroes(Bool32),
    storage_texel_buffer_offset_alignment_bytes: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    storage_texel_buffer_offset_single_texel_alignment: Bool32 = @import("std").mem.zeroes(Bool32),
    uniform_texel_buffer_offset_alignment_bytes: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    uniform_texel_buffer_offset_single_texel_alignment: Bool32 = @import("std").mem.zeroes(Bool32),
    max_buffer_size: DeviceSize = @import("std").mem.zeroes(DeviceSize),
};
pub const PipelineCreationFeedback = extern struct {
    flags: PipelineCreationFeedbackFlags = @import("std").mem.zeroes(PipelineCreationFeedbackFlags),
    duration: u64 = @import("std").mem.zeroes(u64),
};
pub const PipelineCreationFeedbackCreateInfo = extern struct {
    s_type: StructureType = .pipeline_creation_feedback_create_info,
    p_next: ?*const anyopaque = null,
    p_pipeline_creation_feedback: [*c]PipelineCreationFeedback = @import("std").mem.zeroes([*c]PipelineCreationFeedback),
    pipeline_stage_creation_feedback_count: u32 = @import("std").mem.zeroes(u32),
    p_pipeline_stage_creation_feedbacks: [*c]PipelineCreationFeedback = @import("std").mem.zeroes([*c]PipelineCreationFeedback),
};
pub const PhysicalDeviceShaderTerminateInvocationFeatures = extern struct {
    s_type: StructureType = .physical_device_shader_terminate_invocation_features,
    p_next: ?*anyopaque = null,
    shader_terminate_invocation: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceToolProperties = extern struct {
    s_type: StructureType = .physical_device_tool_properties,
    p_next: ?*anyopaque = null,
    name: [256]u8 = @import("std").mem.zeroes([256]u8),
    version: [256]u8 = @import("std").mem.zeroes([256]u8),
    purposes: ToolPurposeFlags = @import("std").mem.zeroes(ToolPurposeFlags),
    description: [256]u8 = @import("std").mem.zeroes([256]u8),
    layer: [256]u8 = @import("std").mem.zeroes([256]u8),
};
pub const PhysicalDeviceShaderDemoteToHelperInvocationFeatures = extern struct {
    s_type: StructureType = .physical_device_shader_demote_to_helper_invocation_features,
    p_next: ?*anyopaque = null,
    shader_demote_to_helper_invocation: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDevicePrivateDataFeatures = extern struct {
    s_type: StructureType = .physical_device_private_data_features,
    p_next: ?*anyopaque = null,
    private_data: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const DevicePrivateDataCreateInfo = extern struct {
    s_type: StructureType = .device_private_data_create_info,
    p_next: ?*const anyopaque = null,
    private_data_slot_request_count: u32 = @import("std").mem.zeroes(u32),
};
pub const PrivateDataSlotCreateInfo = extern struct {
    s_type: StructureType = .private_data_slot_create_info,
    p_next: ?*const anyopaque = null,
    flags: PrivateDataSlotCreateFlags = @import("std").mem.zeroes(PrivateDataSlotCreateFlags),
};
pub const PhysicalDevicePipelineCreationCacheControlFeatures = extern struct {
    s_type: StructureType = .physical_device_pipeline_creation_cache_control_features,
    p_next: ?*anyopaque = null,
    pipeline_creation_cache_control: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const MemoryBarrier2 = extern struct {
    s_type: StructureType = .memory_barrier2,
    p_next: ?*const anyopaque = null,
    src_stage_mask: PipelineStageFlags2 = @import("std").mem.zeroes(PipelineStageFlags2),
    src_access_mask: AccessFlags2 = @import("std").mem.zeroes(AccessFlags2),
    dst_stage_mask: PipelineStageFlags2 = @import("std").mem.zeroes(PipelineStageFlags2),
    dst_access_mask: AccessFlags2 = @import("std").mem.zeroes(AccessFlags2),
};
pub const BufferMemoryBarrier2 = extern struct {
    s_type: StructureType = .buffer_memory_barrier2,
    p_next: ?*const anyopaque = null,
    src_stage_mask: PipelineStageFlags2 = @import("std").mem.zeroes(PipelineStageFlags2),
    src_access_mask: AccessFlags2 = @import("std").mem.zeroes(AccessFlags2),
    dst_stage_mask: PipelineStageFlags2 = @import("std").mem.zeroes(PipelineStageFlags2),
    dst_access_mask: AccessFlags2 = @import("std").mem.zeroes(AccessFlags2),
    src_queue_family_index: u32 = @import("std").mem.zeroes(u32),
    dst_queue_family_index: u32 = @import("std").mem.zeroes(u32),
    buffer: Buffer = @import("std").mem.zeroes(Buffer),
    offset: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    size: DeviceSize = @import("std").mem.zeroes(DeviceSize),
};
pub const ImageMemoryBarrier2 = extern struct {
    s_type: StructureType = .image_memory_barrier2,
    p_next: ?*const anyopaque = null,
    src_stage_mask: PipelineStageFlags2 = @import("std").mem.zeroes(PipelineStageFlags2),
    src_access_mask: AccessFlags2 = @import("std").mem.zeroes(AccessFlags2),
    dst_stage_mask: PipelineStageFlags2 = @import("std").mem.zeroes(PipelineStageFlags2),
    dst_access_mask: AccessFlags2 = @import("std").mem.zeroes(AccessFlags2),
    old_layout: ImageLayout = @import("std").mem.zeroes(ImageLayout),
    new_layout: ImageLayout = @import("std").mem.zeroes(ImageLayout),
    src_queue_family_index: u32 = @import("std").mem.zeroes(u32),
    dst_queue_family_index: u32 = @import("std").mem.zeroes(u32),
    image: Image = @import("std").mem.zeroes(Image),
    subresource_range: ImageSubresourceRange = @import("std").mem.zeroes(ImageSubresourceRange),
};
pub const DependencyInfo = extern struct {
    s_type: StructureType = .dependency_info,
    p_next: ?*const anyopaque = null,
    dependency_flags: DependencyFlags = @import("std").mem.zeroes(DependencyFlags),
    memory_barrier_count: u32 = @import("std").mem.zeroes(u32),
    p_memory_barriers: [*c]const MemoryBarrier2 = @import("std").mem.zeroes([*c]const MemoryBarrier2),
    buffer_memory_barrier_count: u32 = @import("std").mem.zeroes(u32),
    p_buffer_memory_barriers: [*c]const BufferMemoryBarrier2 = @import("std").mem.zeroes([*c]const BufferMemoryBarrier2),
    image_memory_barrier_count: u32 = @import("std").mem.zeroes(u32),
    p_image_memory_barriers: [*c]const ImageMemoryBarrier2 = @import("std").mem.zeroes([*c]const ImageMemoryBarrier2),
};
pub const SemaphoreSubmitInfo = extern struct {
    s_type: StructureType = .semaphore_submit_info,
    p_next: ?*const anyopaque = null,
    semaphore: Semaphore = @import("std").mem.zeroes(Semaphore),
    value: u64 = @import("std").mem.zeroes(u64),
    stage_mask: PipelineStageFlags2 = @import("std").mem.zeroes(PipelineStageFlags2),
    device_index: u32 = @import("std").mem.zeroes(u32),
};
pub const CommandBufferSubmitInfo = extern struct {
    s_type: StructureType = .command_buffer_submit_info,
    p_next: ?*const anyopaque = null,
    command_buffer: CommandBuffer = @import("std").mem.zeroes(CommandBuffer),
    device_mask: u32 = @import("std").mem.zeroes(u32),
};
pub const SubmitInfo2 = extern struct {
    s_type: StructureType = .submit_info2,
    p_next: ?*const anyopaque = null,
    flags: SubmitFlags = @import("std").mem.zeroes(SubmitFlags),
    wait_semaphore_info_count: u32 = @import("std").mem.zeroes(u32),
    p_wait_semaphore_infos: [*c]const SemaphoreSubmitInfo = @import("std").mem.zeroes([*c]const SemaphoreSubmitInfo),
    command_buffer_info_count: u32 = @import("std").mem.zeroes(u32),
    p_command_buffer_infos: [*c]const CommandBufferSubmitInfo = @import("std").mem.zeroes([*c]const CommandBufferSubmitInfo),
    signal_semaphore_info_count: u32 = @import("std").mem.zeroes(u32),
    p_signal_semaphore_infos: [*c]const SemaphoreSubmitInfo = @import("std").mem.zeroes([*c]const SemaphoreSubmitInfo),
};
pub const PhysicalDeviceSynchronization2Features = extern struct {
    s_type: StructureType = .physical_device_synchronization2features,
    p_next: ?*anyopaque = null,
    synchronization2: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceZeroInitializeWorkgroupMemoryFeatures = extern struct {
    s_type: StructureType = .physical_device_zero_initialize_workgroup_memory_features,
    p_next: ?*anyopaque = null,
    shader_zero_initialize_workgroup_memory: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceImageRobustnessFeatures = extern struct {
    s_type: StructureType = .physical_device_image_robustness_features,
    p_next: ?*anyopaque = null,
    robust_image_access: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const BufferCopy2 = extern struct {
    s_type: StructureType = .buffer_copy2,
    p_next: ?*const anyopaque = null,
    src_offset: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    dst_offset: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    size: DeviceSize = @import("std").mem.zeroes(DeviceSize),
};
pub const CopyBufferInfo2 = extern struct {
    s_type: StructureType = .copy_buffer_info2,
    p_next: ?*const anyopaque = null,
    src_buffer: Buffer = @import("std").mem.zeroes(Buffer),
    dst_buffer: Buffer = @import("std").mem.zeroes(Buffer),
    region_count: u32 = @import("std").mem.zeroes(u32),
    p_regions: [*c]const BufferCopy2 = @import("std").mem.zeroes([*c]const BufferCopy2),
};
pub const ImageCopy2 = extern struct {
    s_type: StructureType = .image_copy2,
    p_next: ?*const anyopaque = null,
    src_subresource: ImageSubresourceLayers = @import("std").mem.zeroes(ImageSubresourceLayers),
    src_offset: Offset3D = @import("std").mem.zeroes(Offset3D),
    dst_subresource: ImageSubresourceLayers = @import("std").mem.zeroes(ImageSubresourceLayers),
    dst_offset: Offset3D = @import("std").mem.zeroes(Offset3D),
    extent: Extent3D = @import("std").mem.zeroes(Extent3D),
};
pub const CopyImageInfo2 = extern struct {
    s_type: StructureType = .copy_image_info2,
    p_next: ?*const anyopaque = null,
    src_image: Image = @import("std").mem.zeroes(Image),
    src_image_layout: ImageLayout = @import("std").mem.zeroes(ImageLayout),
    dst_image: Image = @import("std").mem.zeroes(Image),
    dst_image_layout: ImageLayout = @import("std").mem.zeroes(ImageLayout),
    region_count: u32 = @import("std").mem.zeroes(u32),
    p_regions: [*c]const ImageCopy2 = @import("std").mem.zeroes([*c]const ImageCopy2),
};
pub const BufferImageCopy2 = extern struct {
    s_type: StructureType = .buffer_image_copy2,
    p_next: ?*const anyopaque = null,
    buffer_offset: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    buffer_row_length: u32 = @import("std").mem.zeroes(u32),
    buffer_image_height: u32 = @import("std").mem.zeroes(u32),
    image_subresource: ImageSubresourceLayers = @import("std").mem.zeroes(ImageSubresourceLayers),
    image_offset: Offset3D = @import("std").mem.zeroes(Offset3D),
    image_extent: Extent3D = @import("std").mem.zeroes(Extent3D),
};
pub const CopyBufferToImageInfo2 = extern struct {
    s_type: StructureType = .copy_buffer_to_image_info2,
    p_next: ?*const anyopaque = null,
    src_buffer: Buffer = @import("std").mem.zeroes(Buffer),
    dst_image: Image = @import("std").mem.zeroes(Image),
    dst_image_layout: ImageLayout = @import("std").mem.zeroes(ImageLayout),
    region_count: u32 = @import("std").mem.zeroes(u32),
    p_regions: [*c]const BufferImageCopy2 = @import("std").mem.zeroes([*c]const BufferImageCopy2),
};
pub const CopyImageToBufferInfo2 = extern struct {
    s_type: StructureType = .copy_image_to_buffer_info2,
    p_next: ?*const anyopaque = null,
    src_image: Image = @import("std").mem.zeroes(Image),
    src_image_layout: ImageLayout = @import("std").mem.zeroes(ImageLayout),
    dst_buffer: Buffer = @import("std").mem.zeroes(Buffer),
    region_count: u32 = @import("std").mem.zeroes(u32),
    p_regions: [*c]const BufferImageCopy2 = @import("std").mem.zeroes([*c]const BufferImageCopy2),
};
pub const ImageBlit2 = extern struct {
    s_type: StructureType = .image_blit2,
    p_next: ?*const anyopaque = null,
    src_subresource: ImageSubresourceLayers = @import("std").mem.zeroes(ImageSubresourceLayers),
    src_offsets: [2]Offset3D = @import("std").mem.zeroes([2]Offset3D),
    dst_subresource: ImageSubresourceLayers = @import("std").mem.zeroes(ImageSubresourceLayers),
    dst_offsets: [2]Offset3D = @import("std").mem.zeroes([2]Offset3D),
};
pub const BlitImageInfo2 = extern struct {
    s_type: StructureType = .blit_image_info2,
    p_next: ?*const anyopaque = null,
    src_image: Image = @import("std").mem.zeroes(Image),
    src_image_layout: ImageLayout = @import("std").mem.zeroes(ImageLayout),
    dst_image: Image = @import("std").mem.zeroes(Image),
    dst_image_layout: ImageLayout = @import("std").mem.zeroes(ImageLayout),
    region_count: u32 = @import("std").mem.zeroes(u32),
    p_regions: [*c]const ImageBlit2 = @import("std").mem.zeroes([*c]const ImageBlit2),
    filter: Filter = @import("std").mem.zeroes(Filter),
};
pub const ImageResolve2 = extern struct {
    s_type: StructureType = .image_resolve2,
    p_next: ?*const anyopaque = null,
    src_subresource: ImageSubresourceLayers = @import("std").mem.zeroes(ImageSubresourceLayers),
    src_offset: Offset3D = @import("std").mem.zeroes(Offset3D),
    dst_subresource: ImageSubresourceLayers = @import("std").mem.zeroes(ImageSubresourceLayers),
    dst_offset: Offset3D = @import("std").mem.zeroes(Offset3D),
    extent: Extent3D = @import("std").mem.zeroes(Extent3D),
};
pub const ResolveImageInfo2 = extern struct {
    s_type: StructureType = .resolve_image_info2,
    p_next: ?*const anyopaque = null,
    src_image: Image = @import("std").mem.zeroes(Image),
    src_image_layout: ImageLayout = @import("std").mem.zeroes(ImageLayout),
    dst_image: Image = @import("std").mem.zeroes(Image),
    dst_image_layout: ImageLayout = @import("std").mem.zeroes(ImageLayout),
    region_count: u32 = @import("std").mem.zeroes(u32),
    p_regions: [*c]const ImageResolve2 = @import("std").mem.zeroes([*c]const ImageResolve2),
};
pub const PhysicalDeviceSubgroupSizeControlFeatures = extern struct {
    s_type: StructureType = .physical_device_subgroup_size_control_features,
    p_next: ?*anyopaque = null,
    subgroup_size_control: Bool32 = @import("std").mem.zeroes(Bool32),
    compute_full_subgroups: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceSubgroupSizeControlProperties = extern struct {
    s_type: StructureType = .physical_device_subgroup_size_control_properties,
    p_next: ?*anyopaque = null,
    min_subgroup_size: u32 = @import("std").mem.zeroes(u32),
    max_subgroup_size: u32 = @import("std").mem.zeroes(u32),
    max_compute_workgroup_subgroups: u32 = @import("std").mem.zeroes(u32),
    required_subgroup_size_stages: ShaderStageFlags = @import("std").mem.zeroes(ShaderStageFlags),
};
pub const PipelineShaderStageRequiredSubgroupSizeCreateInfo = extern struct {
    s_type: StructureType = .pipeline_shader_stage_required_subgroup_size_create_info,
    p_next: ?*anyopaque = null,
    required_subgroup_size: u32 = @import("std").mem.zeroes(u32),
};
pub const PhysicalDeviceInlineUniformBlockFeatures = extern struct {
    s_type: StructureType = .physical_device_inline_uniform_block_features,
    p_next: ?*anyopaque = null,
    inline_uniform_block: Bool32 = @import("std").mem.zeroes(Bool32),
    descriptor_binding_inline_uniform_block_update_after_bind: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceInlineUniformBlockProperties = extern struct {
    s_type: StructureType = .physical_device_inline_uniform_block_properties,
    p_next: ?*anyopaque = null,
    max_inline_uniform_block_size: u32 = @import("std").mem.zeroes(u32),
    max_per_stage_descriptor_inline_uniform_blocks: u32 = @import("std").mem.zeroes(u32),
    max_per_stage_descriptor_update_after_bind_inline_uniform_blocks: u32 = @import("std").mem.zeroes(u32),
    max_descriptor_set_inline_uniform_blocks: u32 = @import("std").mem.zeroes(u32),
    max_descriptor_set_update_after_bind_inline_uniform_blocks: u32 = @import("std").mem.zeroes(u32),
};
pub const WriteDescriptorSetInlineUniformBlock = extern struct {
    s_type: StructureType = .write_descriptor_set_inline_uniform_block,
    p_next: ?*const anyopaque = null,
    data_size: u32 = @import("std").mem.zeroes(u32),
    p_data: ?*const anyopaque = @import("std").mem.zeroes(?*const anyopaque),
};
pub const DescriptorPoolInlineUniformBlockCreateInfo = extern struct {
    s_type: StructureType = .descriptor_pool_inline_uniform_block_create_info,
    p_next: ?*const anyopaque = null,
    max_inline_uniform_block_bindings: u32 = @import("std").mem.zeroes(u32),
};
pub const PhysicalDeviceTextureCompressionASTCHDRFeatures = extern struct {
    s_type: StructureType = .physical_device_texture_compression_astchdrfeatures,
    p_next: ?*anyopaque = null,
    texture_compression_astc_hdr: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const RenderingAttachmentInfo = extern struct {
    s_type: StructureType = .rendering_attachment_info,
    p_next: ?*const anyopaque = null,
    image_view: ImageView = @import("std").mem.zeroes(ImageView),
    image_layout: ImageLayout = @import("std").mem.zeroes(ImageLayout),
    resolve_mode: ResolveModeFlagBits = @import("std").mem.zeroes(ResolveModeFlagBits),
    resolve_image_view: ImageView = @import("std").mem.zeroes(ImageView),
    resolve_image_layout: ImageLayout = @import("std").mem.zeroes(ImageLayout),
    load_op: AttachmentLoadOp = @import("std").mem.zeroes(AttachmentLoadOp),
    store_op: AttachmentStoreOp = @import("std").mem.zeroes(AttachmentStoreOp),
    clear_value: ClearValue = @import("std").mem.zeroes(ClearValue),
};
pub const RenderingInfo = extern struct {
    s_type: StructureType = .rendering_info,
    p_next: ?*const anyopaque = null,
    flags: RenderingFlags = @import("std").mem.zeroes(RenderingFlags),
    render_area: Rect2D = @import("std").mem.zeroes(Rect2D),
    layer_count: u32 = @import("std").mem.zeroes(u32),
    view_mask: u32 = @import("std").mem.zeroes(u32),
    color_attachment_count: u32 = @import("std").mem.zeroes(u32),
    p_color_attachments: [*c]const RenderingAttachmentInfo = @import("std").mem.zeroes([*c]const RenderingAttachmentInfo),
    p_depth_attachment: [*c]const RenderingAttachmentInfo = @import("std").mem.zeroes([*c]const RenderingAttachmentInfo),
    p_stencil_attachment: [*c]const RenderingAttachmentInfo = @import("std").mem.zeroes([*c]const RenderingAttachmentInfo),
};
pub const PipelineRenderingCreateInfo = extern struct {
    s_type: StructureType = .pipeline_rendering_create_info,
    p_next: ?*const anyopaque = null,
    view_mask: u32 = @import("std").mem.zeroes(u32),
    color_attachment_count: u32 = @import("std").mem.zeroes(u32),
    p_color_attachment_formats: [*c]const Format = @import("std").mem.zeroes([*c]const Format),
    depth_attachment_format: Format = @import("std").mem.zeroes(Format),
    stencil_attachment_format: Format = @import("std").mem.zeroes(Format),
};
pub const PhysicalDeviceDynamicRenderingFeatures = extern struct {
    s_type: StructureType = .physical_device_dynamic_rendering_features,
    p_next: ?*anyopaque = null,
    dynamic_rendering: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const CommandBufferInheritanceRenderingInfo = extern struct {
    s_type: StructureType = .command_buffer_inheritance_rendering_info,
    p_next: ?*const anyopaque = null,
    flags: RenderingFlags = @import("std").mem.zeroes(RenderingFlags),
    view_mask: u32 = @import("std").mem.zeroes(u32),
    color_attachment_count: u32 = @import("std").mem.zeroes(u32),
    p_color_attachment_formats: [*c]const Format = @import("std").mem.zeroes([*c]const Format),
    depth_attachment_format: Format = @import("std").mem.zeroes(Format),
    stencil_attachment_format: Format = @import("std").mem.zeroes(Format),
    rasterization_samples: SampleCountFlagBits = @import("std").mem.zeroes(SampleCountFlagBits),
};
pub const PhysicalDeviceShaderIntegerDotProductFeatures = extern struct {
    s_type: StructureType = .physical_device_shader_integer_dot_product_features,
    p_next: ?*anyopaque = null,
    shader_integer_dot_product: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceShaderIntegerDotProductProperties = extern struct {
    s_type: StructureType = .physical_device_shader_integer_dot_product_properties,
    p_next: ?*anyopaque = null,
    integer_dot_product8bit_unsigned_accelerated: Bool32 = @import("std").mem.zeroes(Bool32),
    integer_dot_product8bit_signed_accelerated: Bool32 = @import("std").mem.zeroes(Bool32),
    integer_dot_product8bit_mixed_signedness_accelerated: Bool32 = @import("std").mem.zeroes(Bool32),
    integer_dot_product4x8_bit_packed_unsigned_accelerated: Bool32 = @import("std").mem.zeroes(Bool32),
    integer_dot_product4x8_bit_packed_signed_accelerated: Bool32 = @import("std").mem.zeroes(Bool32),
    integer_dot_product4x8_bit_packed_mixed_signedness_accelerated: Bool32 = @import("std").mem.zeroes(Bool32),
    integer_dot_product16_bit_unsigned_accelerated: Bool32 = @import("std").mem.zeroes(Bool32),
    integer_dot_product16_bit_signed_accelerated: Bool32 = @import("std").mem.zeroes(Bool32),
    integer_dot_product16_bit_mixed_signedness_accelerated: Bool32 = @import("std").mem.zeroes(Bool32),
    integer_dot_product32_bit_unsigned_accelerated: Bool32 = @import("std").mem.zeroes(Bool32),
    integer_dot_product32_bit_signed_accelerated: Bool32 = @import("std").mem.zeroes(Bool32),
    integer_dot_product32_bit_mixed_signedness_accelerated: Bool32 = @import("std").mem.zeroes(Bool32),
    integer_dot_product64_bit_unsigned_accelerated: Bool32 = @import("std").mem.zeroes(Bool32),
    integer_dot_product64_bit_signed_accelerated: Bool32 = @import("std").mem.zeroes(Bool32),
    integer_dot_product64_bit_mixed_signedness_accelerated: Bool32 = @import("std").mem.zeroes(Bool32),
    integer_dot_product_accumulating_saturating8bit_unsigned_accelerated: Bool32 = @import("std").mem.zeroes(Bool32),
    integer_dot_product_accumulating_saturating8bit_signed_accelerated: Bool32 = @import("std").mem.zeroes(Bool32),
    integer_dot_product_accumulating_saturating8bit_mixed_signedness_accelerated: Bool32 = @import("std").mem.zeroes(Bool32),
    integer_dot_product_accumulating_saturating4x8_bit_packed_unsigned_accelerated: Bool32 = @import("std").mem.zeroes(Bool32),
    integer_dot_product_accumulating_saturating4x8_bit_packed_signed_accelerated: Bool32 = @import("std").mem.zeroes(Bool32),
    integer_dot_product_accumulating_saturating4x8_bit_packed_mixed_signedness_accelerated: Bool32 = @import("std").mem.zeroes(Bool32),
    integer_dot_product_accumulating_saturating16_bit_unsigned_accelerated: Bool32 = @import("std").mem.zeroes(Bool32),
    integer_dot_product_accumulating_saturating16_bit_signed_accelerated: Bool32 = @import("std").mem.zeroes(Bool32),
    integer_dot_product_accumulating_saturating16_bit_mixed_signedness_accelerated: Bool32 = @import("std").mem.zeroes(Bool32),
    integer_dot_product_accumulating_saturating32_bit_unsigned_accelerated: Bool32 = @import("std").mem.zeroes(Bool32),
    integer_dot_product_accumulating_saturating32_bit_signed_accelerated: Bool32 = @import("std").mem.zeroes(Bool32),
    integer_dot_product_accumulating_saturating32_bit_mixed_signedness_accelerated: Bool32 = @import("std").mem.zeroes(Bool32),
    integer_dot_product_accumulating_saturating64_bit_unsigned_accelerated: Bool32 = @import("std").mem.zeroes(Bool32),
    integer_dot_product_accumulating_saturating64_bit_signed_accelerated: Bool32 = @import("std").mem.zeroes(Bool32),
    integer_dot_product_accumulating_saturating64_bit_mixed_signedness_accelerated: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceTexelBufferAlignmentProperties = extern struct {
    s_type: StructureType = .physical_device_texel_buffer_alignment_properties,
    p_next: ?*anyopaque = null,
    storage_texel_buffer_offset_alignment_bytes: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    storage_texel_buffer_offset_single_texel_alignment: Bool32 = @import("std").mem.zeroes(Bool32),
    uniform_texel_buffer_offset_alignment_bytes: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    uniform_texel_buffer_offset_single_texel_alignment: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const FormatProperties3 = extern struct {
    s_type: StructureType = .format_properties3,
    p_next: ?*anyopaque = null,
    linear_tiling_features: FormatFeatureFlags2 = @import("std").mem.zeroes(FormatFeatureFlags2),
    optimal_tiling_features: FormatFeatureFlags2 = @import("std").mem.zeroes(FormatFeatureFlags2),
    buffer_features: FormatFeatureFlags2 = @import("std").mem.zeroes(FormatFeatureFlags2),
};
pub const PhysicalDeviceMaintenance4Features = extern struct {
    s_type: StructureType = .physical_device_maintenance4features,
    p_next: ?*anyopaque = null,
    maintenance4: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceMaintenance4Properties = extern struct {
    s_type: StructureType = .physical_device_maintenance4properties,
    p_next: ?*anyopaque = null,
    max_buffer_size: DeviceSize = @import("std").mem.zeroes(DeviceSize),
};
pub const DeviceBufferMemoryRequirements = extern struct {
    s_type: StructureType = .device_buffer_memory_requirements,
    p_next: ?*const anyopaque = null,
    p_create_info: [*c]const BufferCreateInfo = @import("std").mem.zeroes([*c]const BufferCreateInfo),
};
pub const DeviceImageMemoryRequirements = extern struct {
    s_type: StructureType = .device_image_memory_requirements,
    p_next: ?*const anyopaque = null,
    p_create_info: [*c]const ImageCreateInfo = @import("std").mem.zeroes([*c]const ImageCreateInfo),
    plane_aspect: ImageAspectFlagBits = @import("std").mem.zeroes(ImageAspectFlagBits),
};
pub const PhysicalDeviceVulkan14Features = extern struct {
    s_type: StructureType = .physical_device_vulkan14_features,
    p_next: ?*anyopaque = null,
    global_priority_query: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_subgroup_rotate: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_subgroup_rotate_clustered: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_float_controls2: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_expect_assume: Bool32 = @import("std").mem.zeroes(Bool32),
    rectangular_lines: Bool32 = @import("std").mem.zeroes(Bool32),
    bresenham_lines: Bool32 = @import("std").mem.zeroes(Bool32),
    smooth_lines: Bool32 = @import("std").mem.zeroes(Bool32),
    stippled_rectangular_lines: Bool32 = @import("std").mem.zeroes(Bool32),
    stippled_bresenham_lines: Bool32 = @import("std").mem.zeroes(Bool32),
    stippled_smooth_lines: Bool32 = @import("std").mem.zeroes(Bool32),
    vertex_attribute_instance_rate_divisor: Bool32 = @import("std").mem.zeroes(Bool32),
    vertex_attribute_instance_rate_zero_divisor: Bool32 = @import("std").mem.zeroes(Bool32),
    index_type_uint8: Bool32 = @import("std").mem.zeroes(Bool32),
    dynamic_rendering_local_read: Bool32 = @import("std").mem.zeroes(Bool32),
    maintenance5: Bool32 = @import("std").mem.zeroes(Bool32),
    maintenance6: Bool32 = @import("std").mem.zeroes(Bool32),
    pipeline_protected_access: Bool32 = @import("std").mem.zeroes(Bool32),
    pipeline_robustness: Bool32 = @import("std").mem.zeroes(Bool32),
    host_image_copy: Bool32 = @import("std").mem.zeroes(Bool32),
    push_descriptor: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceVulkan14Properties = extern struct {
    s_type: StructureType = .physical_device_vulkan14_properties,
    p_next: ?*anyopaque = null,
    line_sub_pixel_precision_bits: u32 = @import("std").mem.zeroes(u32),
    max_vertex_attrib_divisor: u32 = @import("std").mem.zeroes(u32),
    supports_non_zero_first_instance: Bool32 = @import("std").mem.zeroes(Bool32),
    max_push_descriptors: u32 = @import("std").mem.zeroes(u32),
    dynamic_rendering_local_read_depth_stencil_attachments: Bool32 = @import("std").mem.zeroes(Bool32),
    dynamic_rendering_local_read_multisampled_attachments: Bool32 = @import("std").mem.zeroes(Bool32),
    early_fragment_multisample_coverage_after_sample_counting: Bool32 = @import("std").mem.zeroes(Bool32),
    early_fragment_sample_mask_test_before_sample_counting: Bool32 = @import("std").mem.zeroes(Bool32),
    depth_stencil_swizzle_one_support: Bool32 = @import("std").mem.zeroes(Bool32),
    polygon_mode_point_size: Bool32 = @import("std").mem.zeroes(Bool32),
    non_strict_single_pixel_wide_lines_use_parallelogram: Bool32 = @import("std").mem.zeroes(Bool32),
    non_strict_wide_lines_use_parallelogram: Bool32 = @import("std").mem.zeroes(Bool32),
    block_texel_view_compatible_multiple_layers: Bool32 = @import("std").mem.zeroes(Bool32),
    max_combined_image_sampler_descriptor_count: u32 = @import("std").mem.zeroes(u32),
    fragment_shading_rate_clamp_combiner_inputs: Bool32 = @import("std").mem.zeroes(Bool32),
    default_robustness_storage_buffers: PipelineRobustnessBufferBehavior = @import("std").mem.zeroes(PipelineRobustnessBufferBehavior),
    default_robustness_uniform_buffers: PipelineRobustnessBufferBehavior = @import("std").mem.zeroes(PipelineRobustnessBufferBehavior),
    default_robustness_vertex_inputs: PipelineRobustnessBufferBehavior = @import("std").mem.zeroes(PipelineRobustnessBufferBehavior),
    default_robustness_images: PipelineRobustnessImageBehavior = @import("std").mem.zeroes(PipelineRobustnessImageBehavior),
    copy_src_layout_count: u32 = @import("std").mem.zeroes(u32),
    p_copy_src_layouts: [*c]ImageLayout = @import("std").mem.zeroes([*c]ImageLayout),
    copy_dst_layout_count: u32 = @import("std").mem.zeroes(u32),
    p_copy_dst_layouts: [*c]ImageLayout = @import("std").mem.zeroes([*c]ImageLayout),
    optimal_tiling_layout_uuid: [16]u8 = @import("std").mem.zeroes([16]u8),
    identical_memory_type_requirements: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const DeviceQueueGlobalPriorityCreateInfo = extern struct {
    s_type: StructureType = .device_queue_global_priority_create_info,
    p_next: ?*const anyopaque = null,
    global_priority: QueueGlobalPriority = @import("std").mem.zeroes(QueueGlobalPriority),
};
pub const PhysicalDeviceGlobalPriorityQueryFeatures = extern struct {
    s_type: StructureType = .physical_device_global_priority_query_features,
    p_next: ?*anyopaque = null,
    global_priority_query: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const QueueFamilyGlobalPriorityProperties = extern struct {
    s_type: StructureType = .queue_family_global_priority_properties,
    p_next: ?*anyopaque = null,
    priority_count: u32 = @import("std").mem.zeroes(u32),
    priorities: [16]QueueGlobalPriority = @import("std").mem.zeroes([16]QueueGlobalPriority),
};
pub const PhysicalDeviceShaderSubgroupRotateFeatures = extern struct {
    s_type: StructureType = .physical_device_shader_subgroup_rotate_features,
    p_next: ?*anyopaque = null,
    shader_subgroup_rotate: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_subgroup_rotate_clustered: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceShaderFloatControls2Features = extern struct {
    s_type: StructureType = .physical_device_shader_float_controls2features,
    p_next: ?*anyopaque = null,
    shader_float_controls2: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceShaderExpectAssumeFeatures = extern struct {
    s_type: StructureType = .physical_device_shader_expect_assume_features,
    p_next: ?*anyopaque = null,
    shader_expect_assume: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceLineRasterizationFeatures = extern struct {
    s_type: StructureType = .physical_device_line_rasterization_features,
    p_next: ?*anyopaque = null,
    rectangular_lines: Bool32 = @import("std").mem.zeroes(Bool32),
    bresenham_lines: Bool32 = @import("std").mem.zeroes(Bool32),
    smooth_lines: Bool32 = @import("std").mem.zeroes(Bool32),
    stippled_rectangular_lines: Bool32 = @import("std").mem.zeroes(Bool32),
    stippled_bresenham_lines: Bool32 = @import("std").mem.zeroes(Bool32),
    stippled_smooth_lines: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceLineRasterizationProperties = extern struct {
    s_type: StructureType = .physical_device_line_rasterization_properties,
    p_next: ?*anyopaque = null,
    line_sub_pixel_precision_bits: u32 = @import("std").mem.zeroes(u32),
};
pub const PipelineRasterizationLineStateCreateInfo = extern struct {
    s_type: StructureType = .pipeline_rasterization_line_state_create_info,
    p_next: ?*const anyopaque = null,
    line_rasterization_mode: LineRasterizationMode = @import("std").mem.zeroes(LineRasterizationMode),
    stippled_line_enable: Bool32 = @import("std").mem.zeroes(Bool32),
    line_stipple_factor: u32 = @import("std").mem.zeroes(u32),
    line_stipple_pattern: u16 = @import("std").mem.zeroes(u16),
};
pub const PhysicalDeviceVertexAttributeDivisorProperties = extern struct {
    s_type: StructureType = .physical_device_vertex_attribute_divisor_properties,
    p_next: ?*anyopaque = null,
    max_vertex_attrib_divisor: u32 = @import("std").mem.zeroes(u32),
    supports_non_zero_first_instance: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const VertexInputBindingDivisorDescription = extern struct {
    binding: u32 = @import("std").mem.zeroes(u32),
    divisor: u32 = @import("std").mem.zeroes(u32),
};
pub const PipelineVertexInputDivisorStateCreateInfo = extern struct {
    s_type: StructureType = .pipeline_vertex_input_divisor_state_create_info,
    p_next: ?*const anyopaque = null,
    vertex_binding_divisor_count: u32 = @import("std").mem.zeroes(u32),
    p_vertex_binding_divisors: [*c]const VertexInputBindingDivisorDescription = @import("std").mem.zeroes([*c]const VertexInputBindingDivisorDescription),
};
pub const PhysicalDeviceVertexAttributeDivisorFeatures = extern struct {
    s_type: StructureType = .physical_device_vertex_attribute_divisor_features,
    p_next: ?*anyopaque = null,
    vertex_attribute_instance_rate_divisor: Bool32 = @import("std").mem.zeroes(Bool32),
    vertex_attribute_instance_rate_zero_divisor: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceIndexTypeUint8Features = extern struct {
    s_type: StructureType = .physical_device_index_type_uint8features,
    p_next: ?*anyopaque = null,
    index_type_uint8: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const MemoryMapInfo = extern struct {
    s_type: StructureType = .memory_map_info,
    p_next: ?*const anyopaque = null,
    flags: MemoryMapFlags = @import("std").mem.zeroes(MemoryMapFlags),
    memory: DeviceMemory = @import("std").mem.zeroes(DeviceMemory),
    offset: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    size: DeviceSize = @import("std").mem.zeroes(DeviceSize),
};
pub const MemoryUnmapInfo = extern struct {
    s_type: StructureType = .memory_unmap_info,
    p_next: ?*const anyopaque = null,
    flags: MemoryUnmapFlags = @import("std").mem.zeroes(MemoryUnmapFlags),
    memory: DeviceMemory = @import("std").mem.zeroes(DeviceMemory),
};
pub const PhysicalDeviceMaintenance5Features = extern struct {
    s_type: StructureType = .physical_device_maintenance5features,
    p_next: ?*anyopaque = null,
    maintenance5: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceMaintenance5Properties = extern struct {
    s_type: StructureType = .physical_device_maintenance5properties,
    p_next: ?*anyopaque = null,
    early_fragment_multisample_coverage_after_sample_counting: Bool32 = @import("std").mem.zeroes(Bool32),
    early_fragment_sample_mask_test_before_sample_counting: Bool32 = @import("std").mem.zeroes(Bool32),
    depth_stencil_swizzle_one_support: Bool32 = @import("std").mem.zeroes(Bool32),
    polygon_mode_point_size: Bool32 = @import("std").mem.zeroes(Bool32),
    non_strict_single_pixel_wide_lines_use_parallelogram: Bool32 = @import("std").mem.zeroes(Bool32),
    non_strict_wide_lines_use_parallelogram: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const RenderingAreaInfo = extern struct {
    s_type: StructureType = .rendering_area_info,
    p_next: ?*const anyopaque = null,
    view_mask: u32 = @import("std").mem.zeroes(u32),
    color_attachment_count: u32 = @import("std").mem.zeroes(u32),
    p_color_attachment_formats: [*c]const Format = @import("std").mem.zeroes([*c]const Format),
    depth_attachment_format: Format = @import("std").mem.zeroes(Format),
    stencil_attachment_format: Format = @import("std").mem.zeroes(Format),
};
pub const ImageSubresource2 = extern struct {
    s_type: StructureType = .image_subresource2,
    p_next: ?*anyopaque = null,
    image_subresource: ImageSubresource = @import("std").mem.zeroes(ImageSubresource),
};
pub const DeviceImageSubresourceInfo = extern struct {
    s_type: StructureType = .device_image_subresource_info,
    p_next: ?*const anyopaque = null,
    p_create_info: [*c]const ImageCreateInfo = @import("std").mem.zeroes([*c]const ImageCreateInfo),
    p_subresource: [*c]const ImageSubresource2 = @import("std").mem.zeroes([*c]const ImageSubresource2),
};
pub const SubresourceLayout2 = extern struct {
    s_type: StructureType = .subresource_layout2,
    p_next: ?*anyopaque = null,
    subresource_layout: SubresourceLayout = @import("std").mem.zeroes(SubresourceLayout),
};
pub const PipelineCreateFlags2CreateInfo = extern struct {
    s_type: StructureType = .pipeline_create_flags2create_info,
    p_next: ?*const anyopaque = null,
    flags: PipelineCreateFlags2 = @import("std").mem.zeroes(PipelineCreateFlags2),
};
pub const BufferUsageFlags2CreateInfo = extern struct {
    s_type: StructureType = .buffer_usage_flags2create_info,
    p_next: ?*const anyopaque = null,
    usage: BufferUsageFlags2 = @import("std").mem.zeroes(BufferUsageFlags2),
};
pub const PhysicalDevicePushDescriptorProperties = extern struct {
    s_type: StructureType = .physical_device_push_descriptor_properties,
    p_next: ?*anyopaque = null,
    max_push_descriptors: u32 = @import("std").mem.zeroes(u32),
};
pub const PhysicalDeviceDynamicRenderingLocalReadFeatures = extern struct {
    s_type: StructureType = .physical_device_dynamic_rendering_local_read_features,
    p_next: ?*anyopaque = null,
    dynamic_rendering_local_read: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const RenderingAttachmentLocationInfo = extern struct {
    s_type: StructureType = .rendering_attachment_location_info,
    p_next: ?*const anyopaque = null,
    color_attachment_count: u32 = @import("std").mem.zeroes(u32),
    p_color_attachment_locations: [*c]const u32 = @import("std").mem.zeroes([*c]const u32),
};
pub const RenderingInputAttachmentIndexInfo = extern struct {
    s_type: StructureType = .rendering_input_attachment_index_info,
    p_next: ?*const anyopaque = null,
    color_attachment_count: u32 = @import("std").mem.zeroes(u32),
    p_color_attachment_input_indices: [*c]const u32 = @import("std").mem.zeroes([*c]const u32),
    p_depth_input_attachment_index: [*c]const u32 = @import("std").mem.zeroes([*c]const u32),
    p_stencil_input_attachment_index: [*c]const u32 = @import("std").mem.zeroes([*c]const u32),
};
pub const PhysicalDeviceMaintenance6Features = extern struct {
    s_type: StructureType = .physical_device_maintenance6features,
    p_next: ?*anyopaque = null,
    maintenance6: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceMaintenance6Properties = extern struct {
    s_type: StructureType = .physical_device_maintenance6properties,
    p_next: ?*anyopaque = null,
    block_texel_view_compatible_multiple_layers: Bool32 = @import("std").mem.zeroes(Bool32),
    max_combined_image_sampler_descriptor_count: u32 = @import("std").mem.zeroes(u32),
    fragment_shading_rate_clamp_combiner_inputs: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const BindMemoryStatus = extern struct {
    s_type: StructureType = .bind_memory_status,
    p_next: ?*const anyopaque = null,
    p_result: [*c]Result = @import("std").mem.zeroes([*c]Result),
};
pub const BindDescriptorSetsInfo = extern struct {
    s_type: StructureType = .bind_descriptor_sets_info,
    p_next: ?*const anyopaque = null,
    stage_flags: ShaderStageFlags = @import("std").mem.zeroes(ShaderStageFlags),
    layout: PipelineLayout = @import("std").mem.zeroes(PipelineLayout),
    first_set: u32 = @import("std").mem.zeroes(u32),
    descriptor_set_count: u32 = @import("std").mem.zeroes(u32),
    p_descriptor_sets: [*c]const DescriptorSet = @import("std").mem.zeroes([*c]const DescriptorSet),
    dynamic_offset_count: u32 = @import("std").mem.zeroes(u32),
    p_dynamic_offsets: [*c]const u32 = @import("std").mem.zeroes([*c]const u32),
};
pub const PushConstantsInfo = extern struct {
    s_type: StructureType = .push_constants_info,
    p_next: ?*const anyopaque = null,
    layout: PipelineLayout = @import("std").mem.zeroes(PipelineLayout),
    stage_flags: ShaderStageFlags = @import("std").mem.zeroes(ShaderStageFlags),
    offset: u32 = @import("std").mem.zeroes(u32),
    size: u32 = @import("std").mem.zeroes(u32),
    p_values: ?*const anyopaque = @import("std").mem.zeroes(?*const anyopaque),
};
pub const PushDescriptorSetInfo = extern struct {
    s_type: StructureType = .push_descriptor_set_info,
    p_next: ?*const anyopaque = null,
    stage_flags: ShaderStageFlags = @import("std").mem.zeroes(ShaderStageFlags),
    layout: PipelineLayout = @import("std").mem.zeroes(PipelineLayout),
    set: u32 = @import("std").mem.zeroes(u32),
    descriptor_write_count: u32 = @import("std").mem.zeroes(u32),
    p_descriptor_writes: [*c]const WriteDescriptorSet = @import("std").mem.zeroes([*c]const WriteDescriptorSet),
};
pub const PushDescriptorSetWithTemplateInfo = extern struct {
    s_type: StructureType = .push_descriptor_set_with_template_info,
    p_next: ?*const anyopaque = null,
    descriptor_update_template: DescriptorUpdateTemplate = @import("std").mem.zeroes(DescriptorUpdateTemplate),
    layout: PipelineLayout = @import("std").mem.zeroes(PipelineLayout),
    set: u32 = @import("std").mem.zeroes(u32),
    p_data: ?*const anyopaque = @import("std").mem.zeroes(?*const anyopaque),
};
pub const PhysicalDevicePipelineProtectedAccessFeatures = extern struct {
    s_type: StructureType = .physical_device_pipeline_protected_access_features,
    p_next: ?*anyopaque = null,
    pipeline_protected_access: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDevicePipelineRobustnessFeatures = extern struct {
    s_type: StructureType = .physical_device_pipeline_robustness_features,
    p_next: ?*anyopaque = null,
    pipeline_robustness: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDevicePipelineRobustnessProperties = extern struct {
    s_type: StructureType = .physical_device_pipeline_robustness_properties,
    p_next: ?*anyopaque = null,
    default_robustness_storage_buffers: PipelineRobustnessBufferBehavior = @import("std").mem.zeroes(PipelineRobustnessBufferBehavior),
    default_robustness_uniform_buffers: PipelineRobustnessBufferBehavior = @import("std").mem.zeroes(PipelineRobustnessBufferBehavior),
    default_robustness_vertex_inputs: PipelineRobustnessBufferBehavior = @import("std").mem.zeroes(PipelineRobustnessBufferBehavior),
    default_robustness_images: PipelineRobustnessImageBehavior = @import("std").mem.zeroes(PipelineRobustnessImageBehavior),
};
pub const PipelineRobustnessCreateInfo = extern struct {
    s_type: StructureType = .pipeline_robustness_create_info,
    p_next: ?*const anyopaque = null,
    storage_buffers: PipelineRobustnessBufferBehavior = @import("std").mem.zeroes(PipelineRobustnessBufferBehavior),
    uniform_buffers: PipelineRobustnessBufferBehavior = @import("std").mem.zeroes(PipelineRobustnessBufferBehavior),
    vertex_inputs: PipelineRobustnessBufferBehavior = @import("std").mem.zeroes(PipelineRobustnessBufferBehavior),
    images: PipelineRobustnessImageBehavior = @import("std").mem.zeroes(PipelineRobustnessImageBehavior),
};
pub const PhysicalDeviceHostImageCopyFeatures = extern struct {
    s_type: StructureType = .physical_device_host_image_copy_features,
    p_next: ?*anyopaque = null,
    host_image_copy: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceHostImageCopyProperties = extern struct {
    s_type: StructureType = .physical_device_host_image_copy_properties,
    p_next: ?*anyopaque = null,
    copy_src_layout_count: u32 = @import("std").mem.zeroes(u32),
    p_copy_src_layouts: [*c]ImageLayout = @import("std").mem.zeroes([*c]ImageLayout),
    copy_dst_layout_count: u32 = @import("std").mem.zeroes(u32),
    p_copy_dst_layouts: [*c]ImageLayout = @import("std").mem.zeroes([*c]ImageLayout),
    optimal_tiling_layout_uuid: [16]u8 = @import("std").mem.zeroes([16]u8),
    identical_memory_type_requirements: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const MemoryToImageCopy = extern struct {
    s_type: StructureType = .memory_to_image_copy,
    p_next: ?*const anyopaque = null,
    p_host_pointer: ?*const anyopaque = @import("std").mem.zeroes(?*const anyopaque),
    memory_row_length: u32 = @import("std").mem.zeroes(u32),
    memory_image_height: u32 = @import("std").mem.zeroes(u32),
    image_subresource: ImageSubresourceLayers = @import("std").mem.zeroes(ImageSubresourceLayers),
    image_offset: Offset3D = @import("std").mem.zeroes(Offset3D),
    image_extent: Extent3D = @import("std").mem.zeroes(Extent3D),
};
pub const ImageToMemoryCopy = extern struct {
    s_type: StructureType = .image_to_memory_copy,
    p_next: ?*const anyopaque = null,
    p_host_pointer: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
    memory_row_length: u32 = @import("std").mem.zeroes(u32),
    memory_image_height: u32 = @import("std").mem.zeroes(u32),
    image_subresource: ImageSubresourceLayers = @import("std").mem.zeroes(ImageSubresourceLayers),
    image_offset: Offset3D = @import("std").mem.zeroes(Offset3D),
    image_extent: Extent3D = @import("std").mem.zeroes(Extent3D),
};
pub const CopyMemoryToImageInfo = extern struct {
    s_type: StructureType = .copy_memory_to_image_info,
    p_next: ?*const anyopaque = null,
    flags: HostImageCopyFlags = @import("std").mem.zeroes(HostImageCopyFlags),
    dst_image: Image = @import("std").mem.zeroes(Image),
    dst_image_layout: ImageLayout = @import("std").mem.zeroes(ImageLayout),
    region_count: u32 = @import("std").mem.zeroes(u32),
    p_regions: [*c]const MemoryToImageCopy = @import("std").mem.zeroes([*c]const MemoryToImageCopy),
};
pub const CopyImageToMemoryInfo = extern struct {
    s_type: StructureType = .copy_image_to_memory_info,
    p_next: ?*const anyopaque = null,
    flags: HostImageCopyFlags = @import("std").mem.zeroes(HostImageCopyFlags),
    src_image: Image = @import("std").mem.zeroes(Image),
    src_image_layout: ImageLayout = @import("std").mem.zeroes(ImageLayout),
    region_count: u32 = @import("std").mem.zeroes(u32),
    p_regions: [*c]const ImageToMemoryCopy = @import("std").mem.zeroes([*c]const ImageToMemoryCopy),
};
pub const CopyImageToImageInfo = extern struct {
    s_type: StructureType = .copy_image_to_image_info,
    p_next: ?*const anyopaque = null,
    flags: HostImageCopyFlags = @import("std").mem.zeroes(HostImageCopyFlags),
    src_image: Image = @import("std").mem.zeroes(Image),
    src_image_layout: ImageLayout = @import("std").mem.zeroes(ImageLayout),
    dst_image: Image = @import("std").mem.zeroes(Image),
    dst_image_layout: ImageLayout = @import("std").mem.zeroes(ImageLayout),
    region_count: u32 = @import("std").mem.zeroes(u32),
    p_regions: [*c]const ImageCopy2 = @import("std").mem.zeroes([*c]const ImageCopy2),
};
pub const HostImageLayoutTransitionInfo = extern struct {
    s_type: StructureType = .host_image_layout_transition_info,
    p_next: ?*const anyopaque = null,
    image: Image = @import("std").mem.zeroes(Image),
    old_layout: ImageLayout = @import("std").mem.zeroes(ImageLayout),
    new_layout: ImageLayout = @import("std").mem.zeroes(ImageLayout),
    subresource_range: ImageSubresourceRange = @import("std").mem.zeroes(ImageSubresourceRange),
};
pub const SubresourceHostMemcpySize = extern struct {
    s_type: StructureType = .subresource_host_memcpy_size,
    p_next: ?*anyopaque = null,
    size: DeviceSize = @import("std").mem.zeroes(DeviceSize),
};
pub const HostImageCopyDevicePerformanceQuery = extern struct {
    s_type: StructureType = .host_image_copy_device_performance_query,
    p_next: ?*anyopaque = null,
    optimal_device_access: Bool32 = @import("std").mem.zeroes(Bool32),
    identical_memory_layout: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const SurfaceCapabilitiesKHR = extern struct {
    min_image_count: u32 = @import("std").mem.zeroes(u32),
    max_image_count: u32 = @import("std").mem.zeroes(u32),
    current_extent: Extent2D = @import("std").mem.zeroes(Extent2D),
    min_image_extent: Extent2D = @import("std").mem.zeroes(Extent2D),
    max_image_extent: Extent2D = @import("std").mem.zeroes(Extent2D),
    max_image_array_layers: u32 = @import("std").mem.zeroes(u32),
    supported_transforms: SurfaceTransformFlagsKHR = @import("std").mem.zeroes(SurfaceTransformFlagsKHR),
    current_transform: SurfaceTransformFlagBitsKHR = @import("std").mem.zeroes(SurfaceTransformFlagBitsKHR),
    supported_composite_alpha: CompositeAlphaFlagsKHR = @import("std").mem.zeroes(CompositeAlphaFlagsKHR),
    supported_usage_flags: ImageUsageFlags = @import("std").mem.zeroes(ImageUsageFlags),
};
pub const SurfaceFormatKHR = extern struct {
    format: Format = @import("std").mem.zeroes(Format),
    color_space: ColorSpaceKHR = @import("std").mem.zeroes(ColorSpaceKHR),
};
pub const SwapchainCreateInfoKHR = extern struct {
    s_type: StructureType = .swapchain_create_info_khr,
    p_next: ?*const anyopaque = null,
    flags: SwapchainCreateFlagsKHR = @import("std").mem.zeroes(SwapchainCreateFlagsKHR),
    surface: SurfaceKHR = @import("std").mem.zeroes(SurfaceKHR),
    min_image_count: u32 = @import("std").mem.zeroes(u32),
    image_format: Format = @import("std").mem.zeroes(Format),
    image_color_space: ColorSpaceKHR = @import("std").mem.zeroes(ColorSpaceKHR),
    image_extent: Extent2D = @import("std").mem.zeroes(Extent2D),
    image_array_layers: u32 = @import("std").mem.zeroes(u32),
    image_usage: ImageUsageFlags = @import("std").mem.zeroes(ImageUsageFlags),
    image_sharing_mode: SharingMode = @import("std").mem.zeroes(SharingMode),
    queue_family_index_count: u32 = @import("std").mem.zeroes(u32),
    p_queue_family_indices: [*c]const u32 = @import("std").mem.zeroes([*c]const u32),
    pre_transform: SurfaceTransformFlagBitsKHR = @import("std").mem.zeroes(SurfaceTransformFlagBitsKHR),
    composite_alpha: CompositeAlphaFlagBitsKHR = @import("std").mem.zeroes(CompositeAlphaFlagBitsKHR),
    present_mode: PresentModeKHR = @import("std").mem.zeroes(PresentModeKHR),
    clipped: Bool32 = @import("std").mem.zeroes(Bool32),
    old_swapchain: SwapchainKHR = @import("std").mem.zeroes(SwapchainKHR),
};
pub const PresentInfoKHR = extern struct {
    s_type: StructureType = .present_info_khr,
    p_next: ?*const anyopaque = null,
    wait_semaphore_count: u32 = @import("std").mem.zeroes(u32),
    p_wait_semaphores: [*c]const Semaphore = @import("std").mem.zeroes([*c]const Semaphore),
    swapchain_count: u32 = @import("std").mem.zeroes(u32),
    p_swapchains: [*c]const SwapchainKHR = @import("std").mem.zeroes([*c]const SwapchainKHR),
    p_image_indices: [*c]const u32 = @import("std").mem.zeroes([*c]const u32),
    p_results: [*c]Result = @import("std").mem.zeroes([*c]Result),
};
pub const ImageSwapchainCreateInfoKHR = extern struct {
    s_type: StructureType = .image_swapchain_create_info_khr,
    p_next: ?*const anyopaque = null,
    swapchain: SwapchainKHR = @import("std").mem.zeroes(SwapchainKHR),
};
pub const BindImageMemorySwapchainInfoKHR = extern struct {
    s_type: StructureType = .bind_image_memory_swapchain_info_khr,
    p_next: ?*const anyopaque = null,
    swapchain: SwapchainKHR = @import("std").mem.zeroes(SwapchainKHR),
    image_index: u32 = @import("std").mem.zeroes(u32),
};
pub const AcquireNextImageInfoKHR = extern struct {
    s_type: StructureType = .acquire_next_image_info_khr,
    p_next: ?*const anyopaque = null,
    swapchain: SwapchainKHR = @import("std").mem.zeroes(SwapchainKHR),
    timeout: u64 = @import("std").mem.zeroes(u64),
    semaphore: Semaphore = @import("std").mem.zeroes(Semaphore),
    fence: Fence = @import("std").mem.zeroes(Fence),
    device_mask: u32 = @import("std").mem.zeroes(u32),
};
pub const DeviceGroupPresentCapabilitiesKHR = extern struct {
    s_type: StructureType = .device_group_present_capabilities_khr,
    p_next: ?*anyopaque = null,
    present_mask: [32]u32 = @import("std").mem.zeroes([32]u32),
    modes: DeviceGroupPresentModeFlagsKHR = @import("std").mem.zeroes(DeviceGroupPresentModeFlagsKHR),
};
pub const DeviceGroupPresentInfoKHR = extern struct {
    s_type: StructureType = .device_group_present_info_khr,
    p_next: ?*const anyopaque = null,
    swapchain_count: u32 = @import("std").mem.zeroes(u32),
    p_device_masks: [*c]const u32 = @import("std").mem.zeroes([*c]const u32),
    mode: DeviceGroupPresentModeFlagBitsKHR = @import("std").mem.zeroes(DeviceGroupPresentModeFlagBitsKHR),
};
pub const DeviceGroupSwapchainCreateInfoKHR = extern struct {
    s_type: StructureType = .device_group_swapchain_create_info_khr,
    p_next: ?*const anyopaque = null,
    modes: DeviceGroupPresentModeFlagsKHR = @import("std").mem.zeroes(DeviceGroupPresentModeFlagsKHR),
};
pub const DisplayModeParametersKHR = extern struct {
    visible_region: Extent2D = @import("std").mem.zeroes(Extent2D),
    refresh_rate: u32 = @import("std").mem.zeroes(u32),
};
pub const DisplayModeCreateInfoKHR = extern struct {
    s_type: StructureType = .display_mode_create_info_khr,
    p_next: ?*const anyopaque = null,
    flags: DisplayModeCreateFlagsKHR = @import("std").mem.zeroes(DisplayModeCreateFlagsKHR),
    parameters: DisplayModeParametersKHR = @import("std").mem.zeroes(DisplayModeParametersKHR),
};
pub const DisplayModePropertiesKHR = extern struct {
    display_mode: DisplayModeKHR = @import("std").mem.zeroes(DisplayModeKHR),
    parameters: DisplayModeParametersKHR = @import("std").mem.zeroes(DisplayModeParametersKHR),
};
pub const DisplayPlaneCapabilitiesKHR = extern struct {
    supported_alpha: DisplayPlaneAlphaFlagsKHR = @import("std").mem.zeroes(DisplayPlaneAlphaFlagsKHR),
    min_src_position: Offset2D = @import("std").mem.zeroes(Offset2D),
    max_src_position: Offset2D = @import("std").mem.zeroes(Offset2D),
    min_src_extent: Extent2D = @import("std").mem.zeroes(Extent2D),
    max_src_extent: Extent2D = @import("std").mem.zeroes(Extent2D),
    min_dst_position: Offset2D = @import("std").mem.zeroes(Offset2D),
    max_dst_position: Offset2D = @import("std").mem.zeroes(Offset2D),
    min_dst_extent: Extent2D = @import("std").mem.zeroes(Extent2D),
    max_dst_extent: Extent2D = @import("std").mem.zeroes(Extent2D),
};
pub const DisplayPlanePropertiesKHR = extern struct {
    current_display: DisplayKHR = @import("std").mem.zeroes(DisplayKHR),
    current_stack_index: u32 = @import("std").mem.zeroes(u32),
};
pub const DisplayPropertiesKHR = extern struct {
    display: DisplayKHR = @import("std").mem.zeroes(DisplayKHR),
    display_name: [*c]const u8 = @import("std").mem.zeroes([*c]const u8),
    physical_dimensions: Extent2D = @import("std").mem.zeroes(Extent2D),
    physical_resolution: Extent2D = @import("std").mem.zeroes(Extent2D),
    supported_transforms: SurfaceTransformFlagsKHR = @import("std").mem.zeroes(SurfaceTransformFlagsKHR),
    plane_reorder_possible: Bool32 = @import("std").mem.zeroes(Bool32),
    persistent_content: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const DisplaySurfaceCreateInfoKHR = extern struct {
    s_type: StructureType = .display_surface_create_info_khr,
    p_next: ?*const anyopaque = null,
    flags: DisplaySurfaceCreateFlagsKHR = @import("std").mem.zeroes(DisplaySurfaceCreateFlagsKHR),
    display_mode: DisplayModeKHR = @import("std").mem.zeroes(DisplayModeKHR),
    plane_index: u32 = @import("std").mem.zeroes(u32),
    plane_stack_index: u32 = @import("std").mem.zeroes(u32),
    transform: SurfaceTransformFlagBitsKHR = @import("std").mem.zeroes(SurfaceTransformFlagBitsKHR),
    global_alpha: f32 = @import("std").mem.zeroes(f32),
    alpha_mode: DisplayPlaneAlphaFlagBitsKHR = @import("std").mem.zeroes(DisplayPlaneAlphaFlagBitsKHR),
    image_extent: Extent2D = @import("std").mem.zeroes(Extent2D),
};
pub const DisplayPresentInfoKHR = extern struct {
    s_type: StructureType = .display_present_info_khr,
    p_next: ?*const anyopaque = null,
    src_rect: Rect2D = @import("std").mem.zeroes(Rect2D),
    dst_rect: Rect2D = @import("std").mem.zeroes(Rect2D),
    persistent: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const QueueFamilyQueryResultStatusPropertiesKHR = extern struct {
    s_type: StructureType = .queue_family_query_result_status_properties_khr,
    p_next: ?*anyopaque = null,
    query_result_status_support: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const QueueFamilyVideoPropertiesKHR = extern struct {
    s_type: StructureType = .queue_family_video_properties_khr,
    p_next: ?*anyopaque = null,
    video_codec_operations: VideoCodecOperationFlagsKHR = @import("std").mem.zeroes(VideoCodecOperationFlagsKHR),
};
pub const VideoProfileInfoKHR = extern struct {
    s_type: StructureType = .video_profile_info_khr,
    p_next: ?*const anyopaque = null,
    video_codec_operation: VideoCodecOperationFlagBitsKHR = @import("std").mem.zeroes(VideoCodecOperationFlagBitsKHR),
    chroma_subsampling: VideoChromaSubsamplingFlagsKHR = @import("std").mem.zeroes(VideoChromaSubsamplingFlagsKHR),
    luma_bit_depth: VideoComponentBitDepthFlagsKHR = @import("std").mem.zeroes(VideoComponentBitDepthFlagsKHR),
    chroma_bit_depth: VideoComponentBitDepthFlagsKHR = @import("std").mem.zeroes(VideoComponentBitDepthFlagsKHR),
};
pub const VideoProfileListInfoKHR = extern struct {
    s_type: StructureType = .video_profile_list_info_khr,
    p_next: ?*const anyopaque = null,
    profile_count: u32 = @import("std").mem.zeroes(u32),
    p_profiles: [*c]const VideoProfileInfoKHR = @import("std").mem.zeroes([*c]const VideoProfileInfoKHR),
};
pub const VideoCapabilitiesKHR = extern struct {
    s_type: StructureType = .video_capabilities_khr,
    p_next: ?*anyopaque = null,
    flags: VideoCapabilityFlagsKHR = @import("std").mem.zeroes(VideoCapabilityFlagsKHR),
    min_bitstream_buffer_offset_alignment: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    min_bitstream_buffer_size_alignment: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    picture_access_granularity: Extent2D = @import("std").mem.zeroes(Extent2D),
    min_coded_extent: Extent2D = @import("std").mem.zeroes(Extent2D),
    max_coded_extent: Extent2D = @import("std").mem.zeroes(Extent2D),
    max_dpb_slots: u32 = @import("std").mem.zeroes(u32),
    max_active_reference_pictures: u32 = @import("std").mem.zeroes(u32),
    std_header_version: ExtensionProperties = @import("std").mem.zeroes(ExtensionProperties),
};
pub const PhysicalDeviceVideoFormatInfoKHR = extern struct {
    s_type: StructureType = .physical_device_video_format_info_khr,
    p_next: ?*const anyopaque = null,
    image_usage: ImageUsageFlags = @import("std").mem.zeroes(ImageUsageFlags),
};
pub const VideoFormatPropertiesKHR = extern struct {
    s_type: StructureType = .video_format_properties_khr,
    p_next: ?*anyopaque = null,
    format: Format = @import("std").mem.zeroes(Format),
    component_mapping: ComponentMapping = @import("std").mem.zeroes(ComponentMapping),
    image_create_flags: ImageCreateFlags = @import("std").mem.zeroes(ImageCreateFlags),
    image_type: ImageType = @import("std").mem.zeroes(ImageType),
    image_tiling: ImageTiling = @import("std").mem.zeroes(ImageTiling),
    image_usage_flags: ImageUsageFlags = @import("std").mem.zeroes(ImageUsageFlags),
};
pub const VideoPictureResourceInfoKHR = extern struct {
    s_type: StructureType = .video_picture_resource_info_khr,
    p_next: ?*const anyopaque = null,
    coded_offset: Offset2D = @import("std").mem.zeroes(Offset2D),
    coded_extent: Extent2D = @import("std").mem.zeroes(Extent2D),
    base_array_layer: u32 = @import("std").mem.zeroes(u32),
    image_view_binding: ImageView = @import("std").mem.zeroes(ImageView),
};
pub const VideoReferenceSlotInfoKHR = extern struct {
    s_type: StructureType = .video_reference_slot_info_khr,
    p_next: ?*const anyopaque = null,
    slot_index: i32 = @import("std").mem.zeroes(i32),
    p_picture_resource: [*c]const VideoPictureResourceInfoKHR = @import("std").mem.zeroes([*c]const VideoPictureResourceInfoKHR),
};
pub const VideoSessionMemoryRequirementsKHR = extern struct {
    s_type: StructureType = .video_session_memory_requirements_khr,
    p_next: ?*anyopaque = null,
    memory_bind_index: u32 = @import("std").mem.zeroes(u32),
    memory_requirements: MemoryRequirements = @import("std").mem.zeroes(MemoryRequirements),
};
pub const BindVideoSessionMemoryInfoKHR = extern struct {
    s_type: StructureType = .bind_video_session_memory_info_khr,
    p_next: ?*const anyopaque = null,
    memory_bind_index: u32 = @import("std").mem.zeroes(u32),
    memory: DeviceMemory = @import("std").mem.zeroes(DeviceMemory),
    memory_offset: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    memory_size: DeviceSize = @import("std").mem.zeroes(DeviceSize),
};
pub const VideoSessionCreateInfoKHR = extern struct {
    s_type: StructureType = .video_session_create_info_khr,
    p_next: ?*const anyopaque = null,
    queue_family_index: u32 = @import("std").mem.zeroes(u32),
    flags: VideoSessionCreateFlagsKHR = @import("std").mem.zeroes(VideoSessionCreateFlagsKHR),
    p_video_profile: [*c]const VideoProfileInfoKHR = @import("std").mem.zeroes([*c]const VideoProfileInfoKHR),
    picture_format: Format = @import("std").mem.zeroes(Format),
    max_coded_extent: Extent2D = @import("std").mem.zeroes(Extent2D),
    reference_picture_format: Format = @import("std").mem.zeroes(Format),
    max_dpb_slots: u32 = @import("std").mem.zeroes(u32),
    max_active_reference_pictures: u32 = @import("std").mem.zeroes(u32),
    p_std_header_version: [*c]const ExtensionProperties = @import("std").mem.zeroes([*c]const ExtensionProperties),
};
pub const VideoSessionParametersCreateInfoKHR = extern struct {
    s_type: StructureType = .video_session_parameters_create_info_khr,
    p_next: ?*const anyopaque = null,
    flags: VideoSessionParametersCreateFlagsKHR = @import("std").mem.zeroes(VideoSessionParametersCreateFlagsKHR),
    video_session_parameters_template: VideoSessionParametersKHR = @import("std").mem.zeroes(VideoSessionParametersKHR),
    video_session: VideoSessionKHR = @import("std").mem.zeroes(VideoSessionKHR),
};
pub const VideoSessionParametersUpdateInfoKHR = extern struct {
    s_type: StructureType = .video_session_parameters_update_info_khr,
    p_next: ?*const anyopaque = null,
    update_sequence_count: u32 = @import("std").mem.zeroes(u32),
};
pub const VideoBeginCodingInfoKHR = extern struct {
    s_type: StructureType = .video_begin_coding_info_khr,
    p_next: ?*const anyopaque = null,
    flags: VideoBeginCodingFlagsKHR = @import("std").mem.zeroes(VideoBeginCodingFlagsKHR),
    video_session: VideoSessionKHR = @import("std").mem.zeroes(VideoSessionKHR),
    video_session_parameters: VideoSessionParametersKHR = @import("std").mem.zeroes(VideoSessionParametersKHR),
    reference_slot_count: u32 = @import("std").mem.zeroes(u32),
    p_reference_slots: [*c]const VideoReferenceSlotInfoKHR = @import("std").mem.zeroes([*c]const VideoReferenceSlotInfoKHR),
};
pub const VideoEndCodingInfoKHR = extern struct {
    s_type: StructureType = .video_end_coding_info_khr,
    p_next: ?*const anyopaque = null,
    flags: VideoEndCodingFlagsKHR = @import("std").mem.zeroes(VideoEndCodingFlagsKHR),
};
pub const VideoCodingControlInfoKHR = extern struct {
    s_type: StructureType = .video_coding_control_info_khr,
    p_next: ?*const anyopaque = null,
    flags: VideoCodingControlFlagsKHR = @import("std").mem.zeroes(VideoCodingControlFlagsKHR),
};
pub const VideoDecodeCapabilitiesKHR = extern struct {
    s_type: StructureType = .video_decode_capabilities_khr,
    p_next: ?*anyopaque = null,
    flags: VideoDecodeCapabilityFlagsKHR = @import("std").mem.zeroes(VideoDecodeCapabilityFlagsKHR),
};
pub const VideoDecodeUsageInfoKHR = extern struct {
    s_type: StructureType = .video_decode_usage_info_khr,
    p_next: ?*const anyopaque = null,
    video_usage_hints: VideoDecodeUsageFlagsKHR = @import("std").mem.zeroes(VideoDecodeUsageFlagsKHR),
};
pub const VideoDecodeInfoKHR = extern struct {
    s_type: StructureType = .video_decode_info_khr,
    p_next: ?*const anyopaque = null,
    flags: VideoDecodeFlagsKHR = @import("std").mem.zeroes(VideoDecodeFlagsKHR),
    src_buffer: Buffer = @import("std").mem.zeroes(Buffer),
    src_buffer_offset: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    src_buffer_range: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    dst_picture_resource: VideoPictureResourceInfoKHR = @import("std").mem.zeroes(VideoPictureResourceInfoKHR),
    p_setup_reference_slot: [*c]const VideoReferenceSlotInfoKHR = @import("std").mem.zeroes([*c]const VideoReferenceSlotInfoKHR),
    reference_slot_count: u32 = @import("std").mem.zeroes(u32),
    p_reference_slots: [*c]const VideoReferenceSlotInfoKHR = @import("std").mem.zeroes([*c]const VideoReferenceSlotInfoKHR),
};
pub const VideoEncodeH264CapabilitiesKHR = extern struct {
    s_type: StructureType = .video_encode_h264_capabilities_khr,
    p_next: ?*anyopaque = null,
    flags: VideoEncodeH264CapabilityFlagsKHR = @import("std").mem.zeroes(VideoEncodeH264CapabilityFlagsKHR),
    max_level_idc: StdVideoH264LevelIdc = @import("std").mem.zeroes(StdVideoH264LevelIdc),
    max_slice_count: u32 = @import("std").mem.zeroes(u32),
    max_ppicture_l0reference_count: u32 = @import("std").mem.zeroes(u32),
    max_bpicture_l0reference_count: u32 = @import("std").mem.zeroes(u32),
    max_l1reference_count: u32 = @import("std").mem.zeroes(u32),
    max_temporal_layer_count: u32 = @import("std").mem.zeroes(u32),
    expect_dyadic_temporal_layer_pattern: Bool32 = @import("std").mem.zeroes(Bool32),
    min_qp: i32 = @import("std").mem.zeroes(i32),
    max_qp: i32 = @import("std").mem.zeroes(i32),
    prefers_gop_remaining_frames: Bool32 = @import("std").mem.zeroes(Bool32),
    requires_gop_remaining_frames: Bool32 = @import("std").mem.zeroes(Bool32),
    std_syntax_flags: VideoEncodeH264StdFlagsKHR = @import("std").mem.zeroes(VideoEncodeH264StdFlagsKHR),
};
pub const VideoEncodeH264QpKHR = extern struct {
    qp_i: i32 = @import("std").mem.zeroes(i32),
    qp_p: i32 = @import("std").mem.zeroes(i32),
    qp_b: i32 = @import("std").mem.zeroes(i32),
};
pub const VideoEncodeH264QualityLevelPropertiesKHR = extern struct {
    s_type: StructureType = .video_encode_h264_quality_level_properties_khr,
    p_next: ?*anyopaque = null,
    preferred_rate_control_flags: VideoEncodeH264RateControlFlagsKHR = @import("std").mem.zeroes(VideoEncodeH264RateControlFlagsKHR),
    preferred_gop_frame_count: u32 = @import("std").mem.zeroes(u32),
    preferred_idr_period: u32 = @import("std").mem.zeroes(u32),
    preferred_consecutive_bframe_count: u32 = @import("std").mem.zeroes(u32),
    preferred_temporal_layer_count: u32 = @import("std").mem.zeroes(u32),
    preferred_constant_qp: VideoEncodeH264QpKHR = @import("std").mem.zeroes(VideoEncodeH264QpKHR),
    preferred_max_l0reference_count: u32 = @import("std").mem.zeroes(u32),
    preferred_max_l1reference_count: u32 = @import("std").mem.zeroes(u32),
    preferred_std_entropy_coding_mode_flag: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const VideoEncodeH264SessionCreateInfoKHR = extern struct {
    s_type: StructureType = .video_encode_h264_session_create_info_khr,
    p_next: ?*const anyopaque = null,
    use_max_level_idc: Bool32 = @import("std").mem.zeroes(Bool32),
    max_level_idc: StdVideoH264LevelIdc = @import("std").mem.zeroes(StdVideoH264LevelIdc),
};
pub const VideoEncodeH264SessionParametersAddInfoKHR = extern struct {
    s_type: StructureType = .video_encode_h264_session_parameters_add_info_khr,
    p_next: ?*const anyopaque = null,
    std_spscount: u32 = @import("std").mem.zeroes(u32),
    p_std_spss: ?*const StdVideoH264SequenceParameterSet = @import("std").mem.zeroes(?*const StdVideoH264SequenceParameterSet),
    std_ppscount: u32 = @import("std").mem.zeroes(u32),
    p_std_ppss: ?*const StdVideoH264PictureParameterSet = @import("std").mem.zeroes(?*const StdVideoH264PictureParameterSet),
};
pub const VideoEncodeH264SessionParametersCreateInfoKHR = extern struct {
    s_type: StructureType = .video_encode_h264_session_parameters_create_info_khr,
    p_next: ?*const anyopaque = null,
    max_std_spscount: u32 = @import("std").mem.zeroes(u32),
    max_std_ppscount: u32 = @import("std").mem.zeroes(u32),
    p_parameters_add_info: [*c]const VideoEncodeH264SessionParametersAddInfoKHR = @import("std").mem.zeroes([*c]const VideoEncodeH264SessionParametersAddInfoKHR),
};
pub const VideoEncodeH264SessionParametersGetInfoKHR = extern struct {
    s_type: StructureType = .video_encode_h264_session_parameters_get_info_khr,
    p_next: ?*const anyopaque = null,
    write_std_sps: Bool32 = @import("std").mem.zeroes(Bool32),
    write_std_pps: Bool32 = @import("std").mem.zeroes(Bool32),
    std_spsid: u32 = @import("std").mem.zeroes(u32),
    std_ppsid: u32 = @import("std").mem.zeroes(u32),
};
pub const VideoEncodeH264SessionParametersFeedbackInfoKHR = extern struct {
    s_type: StructureType = .video_encode_h264_session_parameters_feedback_info_khr,
    p_next: ?*anyopaque = null,
    has_std_spsoverrides: Bool32 = @import("std").mem.zeroes(Bool32),
    has_std_ppsoverrides: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const VideoEncodeH264NaluSliceInfoKHR = extern struct {
    s_type: StructureType = .video_encode_h264_nalu_slice_info_khr,
    p_next: ?*const anyopaque = null,
    constant_qp: i32 = @import("std").mem.zeroes(i32),
    p_std_slice_header: ?*const StdVideoEncodeH264SliceHeader = @import("std").mem.zeroes(?*const StdVideoEncodeH264SliceHeader),
};
pub const VideoEncodeH264PictureInfoKHR = extern struct {
    s_type: StructureType = .video_encode_h264_picture_info_khr,
    p_next: ?*const anyopaque = null,
    nalu_slice_entry_count: u32 = @import("std").mem.zeroes(u32),
    p_nalu_slice_entries: [*c]const VideoEncodeH264NaluSliceInfoKHR = @import("std").mem.zeroes([*c]const VideoEncodeH264NaluSliceInfoKHR),
    p_std_picture_info: ?*const StdVideoEncodeH264PictureInfo = @import("std").mem.zeroes(?*const StdVideoEncodeH264PictureInfo),
    generate_prefix_nalu: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const VideoEncodeH264DpbSlotInfoKHR = extern struct {
    s_type: StructureType = .video_encode_h264_dpb_slot_info_khr,
    p_next: ?*const anyopaque = null,
    p_std_reference_info: ?*const StdVideoEncodeH264ReferenceInfo = @import("std").mem.zeroes(?*const StdVideoEncodeH264ReferenceInfo),
};
pub const VideoEncodeH264ProfileInfoKHR = extern struct {
    s_type: StructureType = .video_encode_h264_profile_info_khr,
    p_next: ?*const anyopaque = null,
    std_profile_idc: StdVideoH264ProfileIdc = @import("std").mem.zeroes(StdVideoH264ProfileIdc),
};
pub const VideoEncodeH264RateControlInfoKHR = extern struct {
    s_type: StructureType = .video_encode_h264_rate_control_info_khr,
    p_next: ?*const anyopaque = null,
    flags: VideoEncodeH264RateControlFlagsKHR = @import("std").mem.zeroes(VideoEncodeH264RateControlFlagsKHR),
    gop_frame_count: u32 = @import("std").mem.zeroes(u32),
    idr_period: u32 = @import("std").mem.zeroes(u32),
    consecutive_bframe_count: u32 = @import("std").mem.zeroes(u32),
    temporal_layer_count: u32 = @import("std").mem.zeroes(u32),
};
pub const VideoEncodeH264FrameSizeKHR = extern struct {
    frame_isize: u32 = @import("std").mem.zeroes(u32),
    frame_psize: u32 = @import("std").mem.zeroes(u32),
    frame_bsize: u32 = @import("std").mem.zeroes(u32),
};
pub const VideoEncodeH264RateControlLayerInfoKHR = extern struct {
    s_type: StructureType = .video_encode_h264_rate_control_layer_info_khr,
    p_next: ?*const anyopaque = null,
    use_min_qp: Bool32 = @import("std").mem.zeroes(Bool32),
    min_qp: VideoEncodeH264QpKHR = @import("std").mem.zeroes(VideoEncodeH264QpKHR),
    use_max_qp: Bool32 = @import("std").mem.zeroes(Bool32),
    max_qp: VideoEncodeH264QpKHR = @import("std").mem.zeroes(VideoEncodeH264QpKHR),
    use_max_frame_size: Bool32 = @import("std").mem.zeroes(Bool32),
    max_frame_size: VideoEncodeH264FrameSizeKHR = @import("std").mem.zeroes(VideoEncodeH264FrameSizeKHR),
};
pub const VideoEncodeH264GopRemainingFrameInfoKHR = extern struct {
    s_type: StructureType = .video_encode_h264_gop_remaining_frame_info_khr,
    p_next: ?*const anyopaque = null,
    use_gop_remaining_frames: Bool32 = @import("std").mem.zeroes(Bool32),
    gop_remaining_i: u32 = @import("std").mem.zeroes(u32),
    gop_remaining_p: u32 = @import("std").mem.zeroes(u32),
    gop_remaining_b: u32 = @import("std").mem.zeroes(u32),
};
pub const VideoEncodeH265CapabilitiesKHR = extern struct {
    s_type: StructureType = .video_encode_h265_capabilities_khr,
    p_next: ?*anyopaque = null,
    flags: VideoEncodeH265CapabilityFlagsKHR = @import("std").mem.zeroes(VideoEncodeH265CapabilityFlagsKHR),
    max_level_idc: StdVideoH265LevelIdc = @import("std").mem.zeroes(StdVideoH265LevelIdc),
    max_slice_segment_count: u32 = @import("std").mem.zeroes(u32),
    max_tiles: Extent2D = @import("std").mem.zeroes(Extent2D),
    ctb_sizes: VideoEncodeH265CtbSizeFlagsKHR = @import("std").mem.zeroes(VideoEncodeH265CtbSizeFlagsKHR),
    transform_block_sizes: VideoEncodeH265TransformBlockSizeFlagsKHR = @import("std").mem.zeroes(VideoEncodeH265TransformBlockSizeFlagsKHR),
    max_ppicture_l0reference_count: u32 = @import("std").mem.zeroes(u32),
    max_bpicture_l0reference_count: u32 = @import("std").mem.zeroes(u32),
    max_l1reference_count: u32 = @import("std").mem.zeroes(u32),
    max_sub_layer_count: u32 = @import("std").mem.zeroes(u32),
    expect_dyadic_temporal_sub_layer_pattern: Bool32 = @import("std").mem.zeroes(Bool32),
    min_qp: i32 = @import("std").mem.zeroes(i32),
    max_qp: i32 = @import("std").mem.zeroes(i32),
    prefers_gop_remaining_frames: Bool32 = @import("std").mem.zeroes(Bool32),
    requires_gop_remaining_frames: Bool32 = @import("std").mem.zeroes(Bool32),
    std_syntax_flags: VideoEncodeH265StdFlagsKHR = @import("std").mem.zeroes(VideoEncodeH265StdFlagsKHR),
};
pub const VideoEncodeH265SessionCreateInfoKHR = extern struct {
    s_type: StructureType = .video_encode_h265_session_create_info_khr,
    p_next: ?*const anyopaque = null,
    use_max_level_idc: Bool32 = @import("std").mem.zeroes(Bool32),
    max_level_idc: StdVideoH265LevelIdc = @import("std").mem.zeroes(StdVideoH265LevelIdc),
};
pub const VideoEncodeH265QpKHR = extern struct {
    qp_i: i32 = @import("std").mem.zeroes(i32),
    qp_p: i32 = @import("std").mem.zeroes(i32),
    qp_b: i32 = @import("std").mem.zeroes(i32),
};
pub const VideoEncodeH265QualityLevelPropertiesKHR = extern struct {
    s_type: StructureType = .video_encode_h265_quality_level_properties_khr,
    p_next: ?*anyopaque = null,
    preferred_rate_control_flags: VideoEncodeH265RateControlFlagsKHR = @import("std").mem.zeroes(VideoEncodeH265RateControlFlagsKHR),
    preferred_gop_frame_count: u32 = @import("std").mem.zeroes(u32),
    preferred_idr_period: u32 = @import("std").mem.zeroes(u32),
    preferred_consecutive_bframe_count: u32 = @import("std").mem.zeroes(u32),
    preferred_sub_layer_count: u32 = @import("std").mem.zeroes(u32),
    preferred_constant_qp: VideoEncodeH265QpKHR = @import("std").mem.zeroes(VideoEncodeH265QpKHR),
    preferred_max_l0reference_count: u32 = @import("std").mem.zeroes(u32),
    preferred_max_l1reference_count: u32 = @import("std").mem.zeroes(u32),
};
pub const VideoEncodeH265SessionParametersAddInfoKHR = extern struct {
    s_type: StructureType = .video_encode_h265_session_parameters_add_info_khr,
    p_next: ?*const anyopaque = null,
    std_vpscount: u32 = @import("std").mem.zeroes(u32),
    p_std_vpss: ?*const StdVideoH265VideoParameterSet = @import("std").mem.zeroes(?*const StdVideoH265VideoParameterSet),
    std_spscount: u32 = @import("std").mem.zeroes(u32),
    p_std_spss: ?*const StdVideoH265SequenceParameterSet = @import("std").mem.zeroes(?*const StdVideoH265SequenceParameterSet),
    std_ppscount: u32 = @import("std").mem.zeroes(u32),
    p_std_ppss: ?*const StdVideoH265PictureParameterSet = @import("std").mem.zeroes(?*const StdVideoH265PictureParameterSet),
};
pub const VideoEncodeH265SessionParametersCreateInfoKHR = extern struct {
    s_type: StructureType = .video_encode_h265_session_parameters_create_info_khr,
    p_next: ?*const anyopaque = null,
    max_std_vpscount: u32 = @import("std").mem.zeroes(u32),
    max_std_spscount: u32 = @import("std").mem.zeroes(u32),
    max_std_ppscount: u32 = @import("std").mem.zeroes(u32),
    p_parameters_add_info: [*c]const VideoEncodeH265SessionParametersAddInfoKHR = @import("std").mem.zeroes([*c]const VideoEncodeH265SessionParametersAddInfoKHR),
};
pub const VideoEncodeH265SessionParametersGetInfoKHR = extern struct {
    s_type: StructureType = .video_encode_h265_session_parameters_get_info_khr,
    p_next: ?*const anyopaque = null,
    write_std_vps: Bool32 = @import("std").mem.zeroes(Bool32),
    write_std_sps: Bool32 = @import("std").mem.zeroes(Bool32),
    write_std_pps: Bool32 = @import("std").mem.zeroes(Bool32),
    std_vpsid: u32 = @import("std").mem.zeroes(u32),
    std_spsid: u32 = @import("std").mem.zeroes(u32),
    std_ppsid: u32 = @import("std").mem.zeroes(u32),
};
pub const VideoEncodeH265SessionParametersFeedbackInfoKHR = extern struct {
    s_type: StructureType = .video_encode_h265_session_parameters_feedback_info_khr,
    p_next: ?*anyopaque = null,
    has_std_vpsoverrides: Bool32 = @import("std").mem.zeroes(Bool32),
    has_std_spsoverrides: Bool32 = @import("std").mem.zeroes(Bool32),
    has_std_ppsoverrides: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const VideoEncodeH265NaluSliceSegmentInfoKHR = extern struct {
    s_type: StructureType = .video_encode_h265_nalu_slice_segment_info_khr,
    p_next: ?*const anyopaque = null,
    constant_qp: i32 = @import("std").mem.zeroes(i32),
    p_std_slice_segment_header: ?*const StdVideoEncodeH265SliceSegmentHeader = @import("std").mem.zeroes(?*const StdVideoEncodeH265SliceSegmentHeader),
};
pub const VideoEncodeH265PictureInfoKHR = extern struct {
    s_type: StructureType = .video_encode_h265_picture_info_khr,
    p_next: ?*const anyopaque = null,
    nalu_slice_segment_entry_count: u32 = @import("std").mem.zeroes(u32),
    p_nalu_slice_segment_entries: [*c]const VideoEncodeH265NaluSliceSegmentInfoKHR = @import("std").mem.zeroes([*c]const VideoEncodeH265NaluSliceSegmentInfoKHR),
    p_std_picture_info: ?*const StdVideoEncodeH265PictureInfo = @import("std").mem.zeroes(?*const StdVideoEncodeH265PictureInfo),
};
pub const VideoEncodeH265DpbSlotInfoKHR = extern struct {
    s_type: StructureType = .video_encode_h265_dpb_slot_info_khr,
    p_next: ?*const anyopaque = null,
    p_std_reference_info: ?*const StdVideoEncodeH265ReferenceInfo = @import("std").mem.zeroes(?*const StdVideoEncodeH265ReferenceInfo),
};
pub const VideoEncodeH265ProfileInfoKHR = extern struct {
    s_type: StructureType = .video_encode_h265_profile_info_khr,
    p_next: ?*const anyopaque = null,
    std_profile_idc: StdVideoH265ProfileIdc = @import("std").mem.zeroes(StdVideoH265ProfileIdc),
};
pub const VideoEncodeH265RateControlInfoKHR = extern struct {
    s_type: StructureType = .video_encode_h265_rate_control_info_khr,
    p_next: ?*const anyopaque = null,
    flags: VideoEncodeH265RateControlFlagsKHR = @import("std").mem.zeroes(VideoEncodeH265RateControlFlagsKHR),
    gop_frame_count: u32 = @import("std").mem.zeroes(u32),
    idr_period: u32 = @import("std").mem.zeroes(u32),
    consecutive_bframe_count: u32 = @import("std").mem.zeroes(u32),
    sub_layer_count: u32 = @import("std").mem.zeroes(u32),
};
pub const VideoEncodeH265FrameSizeKHR = extern struct {
    frame_isize: u32 = @import("std").mem.zeroes(u32),
    frame_psize: u32 = @import("std").mem.zeroes(u32),
    frame_bsize: u32 = @import("std").mem.zeroes(u32),
};
pub const VideoEncodeH265RateControlLayerInfoKHR = extern struct {
    s_type: StructureType = .video_encode_h265_rate_control_layer_info_khr,
    p_next: ?*const anyopaque = null,
    use_min_qp: Bool32 = @import("std").mem.zeroes(Bool32),
    min_qp: VideoEncodeH265QpKHR = @import("std").mem.zeroes(VideoEncodeH265QpKHR),
    use_max_qp: Bool32 = @import("std").mem.zeroes(Bool32),
    max_qp: VideoEncodeH265QpKHR = @import("std").mem.zeroes(VideoEncodeH265QpKHR),
    use_max_frame_size: Bool32 = @import("std").mem.zeroes(Bool32),
    max_frame_size: VideoEncodeH265FrameSizeKHR = @import("std").mem.zeroes(VideoEncodeH265FrameSizeKHR),
};
pub const VideoEncodeH265GopRemainingFrameInfoKHR = extern struct {
    s_type: StructureType = .video_encode_h265_gop_remaining_frame_info_khr,
    p_next: ?*const anyopaque = null,
    use_gop_remaining_frames: Bool32 = @import("std").mem.zeroes(Bool32),
    gop_remaining_i: u32 = @import("std").mem.zeroes(u32),
    gop_remaining_p: u32 = @import("std").mem.zeroes(u32),
    gop_remaining_b: u32 = @import("std").mem.zeroes(u32),
};
pub const VideoDecodeH264ProfileInfoKHR = extern struct {
    s_type: StructureType = .video_decode_h264_profile_info_khr,
    p_next: ?*const anyopaque = null,
    std_profile_idc: StdVideoH264ProfileIdc = @import("std").mem.zeroes(StdVideoH264ProfileIdc),
    picture_layout: VideoDecodeH264PictureLayoutFlagBitsKHR = @import("std").mem.zeroes(VideoDecodeH264PictureLayoutFlagBitsKHR),
};
pub const VideoDecodeH264CapabilitiesKHR = extern struct {
    s_type: StructureType = .video_decode_h264_capabilities_khr,
    p_next: ?*anyopaque = null,
    max_level_idc: StdVideoH264LevelIdc = @import("std").mem.zeroes(StdVideoH264LevelIdc),
    field_offset_granularity: Offset2D = @import("std").mem.zeroes(Offset2D),
};
pub const VideoDecodeH264SessionParametersAddInfoKHR = extern struct {
    s_type: StructureType = .video_decode_h264_session_parameters_add_info_khr,
    p_next: ?*const anyopaque = null,
    std_spscount: u32 = @import("std").mem.zeroes(u32),
    p_std_spss: ?*const StdVideoH264SequenceParameterSet = @import("std").mem.zeroes(?*const StdVideoH264SequenceParameterSet),
    std_ppscount: u32 = @import("std").mem.zeroes(u32),
    p_std_ppss: ?*const StdVideoH264PictureParameterSet = @import("std").mem.zeroes(?*const StdVideoH264PictureParameterSet),
};
pub const VideoDecodeH264SessionParametersCreateInfoKHR = extern struct {
    s_type: StructureType = .video_decode_h264_session_parameters_create_info_khr,
    p_next: ?*const anyopaque = null,
    max_std_spscount: u32 = @import("std").mem.zeroes(u32),
    max_std_ppscount: u32 = @import("std").mem.zeroes(u32),
    p_parameters_add_info: [*c]const VideoDecodeH264SessionParametersAddInfoKHR = @import("std").mem.zeroes([*c]const VideoDecodeH264SessionParametersAddInfoKHR),
};
pub const VideoDecodeH264PictureInfoKHR = extern struct {
    s_type: StructureType = .video_decode_h264_picture_info_khr,
    p_next: ?*const anyopaque = null,
    p_std_picture_info: ?*const StdVideoDecodeH264PictureInfo = @import("std").mem.zeroes(?*const StdVideoDecodeH264PictureInfo),
    slice_count: u32 = @import("std").mem.zeroes(u32),
    p_slice_offsets: [*c]const u32 = @import("std").mem.zeroes([*c]const u32),
};
pub const VideoDecodeH264DpbSlotInfoKHR = extern struct {
    s_type: StructureType = .video_decode_h264_dpb_slot_info_khr,
    p_next: ?*const anyopaque = null,
    p_std_reference_info: ?*const StdVideoDecodeH264ReferenceInfo = @import("std").mem.zeroes(?*const StdVideoDecodeH264ReferenceInfo),
};
pub const ImportMemoryFdInfoKHR = extern struct {
    s_type: StructureType = .import_memory_fd_info_khr,
    p_next: ?*const anyopaque = null,
    handle_type: ExternalMemoryHandleTypeFlagBits = @import("std").mem.zeroes(ExternalMemoryHandleTypeFlagBits),
    fd: c_int = @import("std").mem.zeroes(c_int),
};
pub const MemoryFdPropertiesKHR = extern struct {
    s_type: StructureType = .memory_fd_properties_khr,
    p_next: ?*anyopaque = null,
    memory_type_bits: u32 = @import("std").mem.zeroes(u32),
};
pub const MemoryGetFdInfoKHR = extern struct {
    s_type: StructureType = .memory_get_fd_info_khr,
    p_next: ?*const anyopaque = null,
    memory: DeviceMemory = @import("std").mem.zeroes(DeviceMemory),
    handle_type: ExternalMemoryHandleTypeFlagBits = @import("std").mem.zeroes(ExternalMemoryHandleTypeFlagBits),
};
pub const ImportSemaphoreFdInfoKHR = extern struct {
    s_type: StructureType = .import_semaphore_fd_info_khr,
    p_next: ?*const anyopaque = null,
    semaphore: Semaphore = @import("std").mem.zeroes(Semaphore),
    flags: SemaphoreImportFlags = @import("std").mem.zeroes(SemaphoreImportFlags),
    handle_type: ExternalSemaphoreHandleTypeFlagBits = @import("std").mem.zeroes(ExternalSemaphoreHandleTypeFlagBits),
    fd: c_int = @import("std").mem.zeroes(c_int),
};
pub const SemaphoreGetFdInfoKHR = extern struct {
    s_type: StructureType = .semaphore_get_fd_info_khr,
    p_next: ?*const anyopaque = null,
    semaphore: Semaphore = @import("std").mem.zeroes(Semaphore),
    handle_type: ExternalSemaphoreHandleTypeFlagBits = @import("std").mem.zeroes(ExternalSemaphoreHandleTypeFlagBits),
};
pub const RectLayerKHR = extern struct {
    offset: Offset2D = @import("std").mem.zeroes(Offset2D),
    extent: Extent2D = @import("std").mem.zeroes(Extent2D),
    layer: u32 = @import("std").mem.zeroes(u32),
};
pub const PresentRegionKHR = extern struct {
    rectangle_count: u32 = @import("std").mem.zeroes(u32),
    p_rectangles: [*c]const RectLayerKHR = @import("std").mem.zeroes([*c]const RectLayerKHR),
};
pub const PresentRegionsKHR = extern struct {
    s_type: StructureType = .present_regions_khr,
    p_next: ?*const anyopaque = null,
    swapchain_count: u32 = @import("std").mem.zeroes(u32),
    p_regions: [*c]const PresentRegionKHR = @import("std").mem.zeroes([*c]const PresentRegionKHR),
};
pub const SharedPresentSurfaceCapabilitiesKHR = extern struct {
    s_type: StructureType = .shared_present_surface_capabilities_khr,
    p_next: ?*anyopaque = null,
    shared_present_supported_usage_flags: ImageUsageFlags = @import("std").mem.zeroes(ImageUsageFlags),
};
pub const ImportFenceFdInfoKHR = extern struct {
    s_type: StructureType = .import_fence_fd_info_khr,
    p_next: ?*const anyopaque = null,
    fence: Fence = @import("std").mem.zeroes(Fence),
    flags: FenceImportFlags = @import("std").mem.zeroes(FenceImportFlags),
    handle_type: ExternalFenceHandleTypeFlagBits = @import("std").mem.zeroes(ExternalFenceHandleTypeFlagBits),
    fd: c_int = @import("std").mem.zeroes(c_int),
};
pub const FenceGetFdInfoKHR = extern struct {
    s_type: StructureType = .fence_get_fd_info_khr,
    p_next: ?*const anyopaque = null,
    fence: Fence = @import("std").mem.zeroes(Fence),
    handle_type: ExternalFenceHandleTypeFlagBits = @import("std").mem.zeroes(ExternalFenceHandleTypeFlagBits),
};
pub const PhysicalDevicePerformanceQueryFeaturesKHR = extern struct {
    s_type: StructureType = .physical_device_performance_query_features_khr,
    p_next: ?*anyopaque = null,
    performance_counter_query_pools: Bool32 = @import("std").mem.zeroes(Bool32),
    performance_counter_multiple_query_pools: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDevicePerformanceQueryPropertiesKHR = extern struct {
    s_type: StructureType = .physical_device_performance_query_properties_khr,
    p_next: ?*anyopaque = null,
    allow_command_buffer_query_copies: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PerformanceCounterKHR = extern struct {
    s_type: StructureType = .performance_counter_khr,
    p_next: ?*anyopaque = null,
    unit: PerformanceCounterUnitKHR = @import("std").mem.zeroes(PerformanceCounterUnitKHR),
    scope: PerformanceCounterScopeKHR = @import("std").mem.zeroes(PerformanceCounterScopeKHR),
    storage: PerformanceCounterStorageKHR = @import("std").mem.zeroes(PerformanceCounterStorageKHR),
    uuid: [16]u8 = @import("std").mem.zeroes([16]u8),
};
pub const PerformanceCounterDescriptionKHR = extern struct {
    s_type: StructureType = .performance_counter_description_khr,
    p_next: ?*anyopaque = null,
    flags: PerformanceCounterDescriptionFlagsKHR = @import("std").mem.zeroes(PerformanceCounterDescriptionFlagsKHR),
    name: [256]u8 = @import("std").mem.zeroes([256]u8),
    category: [256]u8 = @import("std").mem.zeroes([256]u8),
    description: [256]u8 = @import("std").mem.zeroes([256]u8),
};
pub const QueryPoolPerformanceCreateInfoKHR = extern struct {
    s_type: StructureType = .query_pool_performance_create_info_khr,
    p_next: ?*const anyopaque = null,
    queue_family_index: u32 = @import("std").mem.zeroes(u32),
    counter_index_count: u32 = @import("std").mem.zeroes(u32),
    p_counter_indices: [*c]const u32 = @import("std").mem.zeroes([*c]const u32),
};
pub const AcquireProfilingLockInfoKHR = extern struct {
    s_type: StructureType = .acquire_profiling_lock_info_khr,
    p_next: ?*const anyopaque = null,
    flags: AcquireProfilingLockFlagsKHR = @import("std").mem.zeroes(AcquireProfilingLockFlagsKHR),
    timeout: u64 = @import("std").mem.zeroes(u64),
};
pub const PerformanceQuerySubmitInfoKHR = extern struct {
    s_type: StructureType = .performance_query_submit_info_khr,
    p_next: ?*const anyopaque = null,
    counter_pass_index: u32 = @import("std").mem.zeroes(u32),
};
pub const PhysicalDeviceSurfaceInfo2KHR = extern struct {
    s_type: StructureType = .physical_device_surface_info2khr,
    p_next: ?*const anyopaque = null,
    surface: SurfaceKHR = @import("std").mem.zeroes(SurfaceKHR),
};
pub const SurfaceCapabilities2KHR = extern struct {
    s_type: StructureType = .surface_capabilities2khr,
    p_next: ?*anyopaque = null,
    surface_capabilities: SurfaceCapabilitiesKHR = @import("std").mem.zeroes(SurfaceCapabilitiesKHR),
};
pub const SurfaceFormat2KHR = extern struct {
    s_type: StructureType = .surface_format2khr,
    p_next: ?*anyopaque = null,
    surface_format: SurfaceFormatKHR = @import("std").mem.zeroes(SurfaceFormatKHR),
};
pub const DisplayProperties2KHR = extern struct {
    s_type: StructureType = .display_properties2khr,
    p_next: ?*anyopaque = null,
    display_properties: DisplayPropertiesKHR = @import("std").mem.zeroes(DisplayPropertiesKHR),
};
pub const DisplayPlaneProperties2KHR = extern struct {
    s_type: StructureType = .display_plane_properties2khr,
    p_next: ?*anyopaque = null,
    display_plane_properties: DisplayPlanePropertiesKHR = @import("std").mem.zeroes(DisplayPlanePropertiesKHR),
};
pub const DisplayModeProperties2KHR = extern struct {
    s_type: StructureType = .display_mode_properties2khr,
    p_next: ?*anyopaque = null,
    display_mode_properties: DisplayModePropertiesKHR = @import("std").mem.zeroes(DisplayModePropertiesKHR),
};
pub const DisplayPlaneInfo2KHR = extern struct {
    s_type: StructureType = .display_plane_info2khr,
    p_next: ?*const anyopaque = null,
    mode: DisplayModeKHR = @import("std").mem.zeroes(DisplayModeKHR),
    plane_index: u32 = @import("std").mem.zeroes(u32),
};
pub const DisplayPlaneCapabilities2KHR = extern struct {
    s_type: StructureType = .display_plane_capabilities2khr,
    p_next: ?*anyopaque = null,
    capabilities: DisplayPlaneCapabilitiesKHR = @import("std").mem.zeroes(DisplayPlaneCapabilitiesKHR),
};
pub const PhysicalDeviceShaderBfloat16FeaturesKHR = extern struct {
    s_type: StructureType = .physical_device_shader_bfloat16_features_khr,
    p_next: ?*anyopaque = null,
    shader_bfloat16_type: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_bfloat16_dot_product: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_bfloat16_cooperative_matrix: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceShaderClockFeaturesKHR = extern struct {
    s_type: StructureType = .physical_device_shader_clock_features_khr,
    p_next: ?*anyopaque = null,
    shader_subgroup_clock: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_device_clock: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const VideoDecodeH265ProfileInfoKHR = extern struct {
    s_type: StructureType = .video_decode_h265_profile_info_khr,
    p_next: ?*const anyopaque = null,
    std_profile_idc: StdVideoH265ProfileIdc = @import("std").mem.zeroes(StdVideoH265ProfileIdc),
};
pub const VideoDecodeH265CapabilitiesKHR = extern struct {
    s_type: StructureType = .video_decode_h265_capabilities_khr,
    p_next: ?*anyopaque = null,
    max_level_idc: StdVideoH265LevelIdc = @import("std").mem.zeroes(StdVideoH265LevelIdc),
};
pub const VideoDecodeH265SessionParametersAddInfoKHR = extern struct {
    s_type: StructureType = .video_decode_h265_session_parameters_add_info_khr,
    p_next: ?*const anyopaque = null,
    std_vpscount: u32 = @import("std").mem.zeroes(u32),
    p_std_vpss: ?*const StdVideoH265VideoParameterSet = @import("std").mem.zeroes(?*const StdVideoH265VideoParameterSet),
    std_spscount: u32 = @import("std").mem.zeroes(u32),
    p_std_spss: ?*const StdVideoH265SequenceParameterSet = @import("std").mem.zeroes(?*const StdVideoH265SequenceParameterSet),
    std_ppscount: u32 = @import("std").mem.zeroes(u32),
    p_std_ppss: ?*const StdVideoH265PictureParameterSet = @import("std").mem.zeroes(?*const StdVideoH265PictureParameterSet),
};
pub const VideoDecodeH265SessionParametersCreateInfoKHR = extern struct {
    s_type: StructureType = .video_decode_h265_session_parameters_create_info_khr,
    p_next: ?*const anyopaque = null,
    max_std_vpscount: u32 = @import("std").mem.zeroes(u32),
    max_std_spscount: u32 = @import("std").mem.zeroes(u32),
    max_std_ppscount: u32 = @import("std").mem.zeroes(u32),
    p_parameters_add_info: [*c]const VideoDecodeH265SessionParametersAddInfoKHR = @import("std").mem.zeroes([*c]const VideoDecodeH265SessionParametersAddInfoKHR),
};
pub const VideoDecodeH265PictureInfoKHR = extern struct {
    s_type: StructureType = .video_decode_h265_picture_info_khr,
    p_next: ?*const anyopaque = null,
    p_std_picture_info: ?*const StdVideoDecodeH265PictureInfo = @import("std").mem.zeroes(?*const StdVideoDecodeH265PictureInfo),
    slice_segment_count: u32 = @import("std").mem.zeroes(u32),
    p_slice_segment_offsets: [*c]const u32 = @import("std").mem.zeroes([*c]const u32),
};
pub const VideoDecodeH265DpbSlotInfoKHR = extern struct {
    s_type: StructureType = .video_decode_h265_dpb_slot_info_khr,
    p_next: ?*const anyopaque = null,
    p_std_reference_info: ?*const StdVideoDecodeH265ReferenceInfo = @import("std").mem.zeroes(?*const StdVideoDecodeH265ReferenceInfo),
};
pub const FragmentShadingRateAttachmentInfoKHR = extern struct {
    s_type: StructureType = .fragment_shading_rate_attachment_info_khr,
    p_next: ?*const anyopaque = null,
    p_fragment_shading_rate_attachment: [*c]const AttachmentReference2 = @import("std").mem.zeroes([*c]const AttachmentReference2),
    shading_rate_attachment_texel_size: Extent2D = @import("std").mem.zeroes(Extent2D),
};
pub const PipelineFragmentShadingRateStateCreateInfoKHR = extern struct {
    s_type: StructureType = .pipeline_fragment_shading_rate_state_create_info_khr,
    p_next: ?*const anyopaque = null,
    fragment_size: Extent2D = @import("std").mem.zeroes(Extent2D),
    combiner_ops: [2]FragmentShadingRateCombinerOpKHR = @import("std").mem.zeroes([2]FragmentShadingRateCombinerOpKHR),
};
pub const PhysicalDeviceFragmentShadingRateFeaturesKHR = extern struct {
    s_type: StructureType = .physical_device_fragment_shading_rate_features_khr,
    p_next: ?*anyopaque = null,
    pipeline_fragment_shading_rate: Bool32 = @import("std").mem.zeroes(Bool32),
    primitive_fragment_shading_rate: Bool32 = @import("std").mem.zeroes(Bool32),
    attachment_fragment_shading_rate: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceFragmentShadingRatePropertiesKHR = extern struct {
    s_type: StructureType = .physical_device_fragment_shading_rate_properties_khr,
    p_next: ?*anyopaque = null,
    min_fragment_shading_rate_attachment_texel_size: Extent2D = @import("std").mem.zeroes(Extent2D),
    max_fragment_shading_rate_attachment_texel_size: Extent2D = @import("std").mem.zeroes(Extent2D),
    max_fragment_shading_rate_attachment_texel_size_aspect_ratio: u32 = @import("std").mem.zeroes(u32),
    primitive_fragment_shading_rate_with_multiple_viewports: Bool32 = @import("std").mem.zeroes(Bool32),
    layered_shading_rate_attachments: Bool32 = @import("std").mem.zeroes(Bool32),
    fragment_shading_rate_non_trivial_combiner_ops: Bool32 = @import("std").mem.zeroes(Bool32),
    max_fragment_size: Extent2D = @import("std").mem.zeroes(Extent2D),
    max_fragment_size_aspect_ratio: u32 = @import("std").mem.zeroes(u32),
    max_fragment_shading_rate_coverage_samples: u32 = @import("std").mem.zeroes(u32),
    max_fragment_shading_rate_rasterization_samples: SampleCountFlagBits = @import("std").mem.zeroes(SampleCountFlagBits),
    fragment_shading_rate_with_shader_depth_stencil_writes: Bool32 = @import("std").mem.zeroes(Bool32),
    fragment_shading_rate_with_sample_mask: Bool32 = @import("std").mem.zeroes(Bool32),
    fragment_shading_rate_with_shader_sample_mask: Bool32 = @import("std").mem.zeroes(Bool32),
    fragment_shading_rate_with_conservative_rasterization: Bool32 = @import("std").mem.zeroes(Bool32),
    fragment_shading_rate_with_fragment_shader_interlock: Bool32 = @import("std").mem.zeroes(Bool32),
    fragment_shading_rate_with_custom_sample_locations: Bool32 = @import("std").mem.zeroes(Bool32),
    fragment_shading_rate_strict_multiply_combiner: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceFragmentShadingRateKHR = extern struct {
    s_type: StructureType = .physical_device_fragment_shading_rate_khr,
    p_next: ?*anyopaque = null,
    sample_counts: SampleCountFlags = @import("std").mem.zeroes(SampleCountFlags),
    fragment_size: Extent2D = @import("std").mem.zeroes(Extent2D),
};
pub const RenderingFragmentShadingRateAttachmentInfoKHR = extern struct {
    s_type: StructureType = .rendering_fragment_shading_rate_attachment_info_khr,
    p_next: ?*const anyopaque = null,
    image_view: ImageView = @import("std").mem.zeroes(ImageView),
    image_layout: ImageLayout = @import("std").mem.zeroes(ImageLayout),
    shading_rate_attachment_texel_size: Extent2D = @import("std").mem.zeroes(Extent2D),
};
pub const PhysicalDeviceShaderQuadControlFeaturesKHR = extern struct {
    s_type: StructureType = .physical_device_shader_quad_control_features_khr,
    p_next: ?*anyopaque = null,
    shader_quad_control: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const SurfaceProtectedCapabilitiesKHR = extern struct {
    s_type: StructureType = .surface_protected_capabilities_khr,
    p_next: ?*const anyopaque = null,
    supports_protected: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDevicePresentWaitFeaturesKHR = extern struct {
    s_type: StructureType = .physical_device_present_wait_features_khr,
    p_next: ?*anyopaque = null,
    present_wait: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDevicePipelineExecutablePropertiesFeaturesKHR = extern struct {
    s_type: StructureType = .physical_device_pipeline_executable_properties_features_khr,
    p_next: ?*anyopaque = null,
    pipeline_executable_info: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PipelineInfoKHR = extern struct {
    s_type: StructureType = .pipeline_info_khr,
    p_next: ?*const anyopaque = null,
    pipeline: Pipeline = @import("std").mem.zeroes(Pipeline),
};
pub const PipelineExecutablePropertiesKHR = extern struct {
    s_type: StructureType = .pipeline_executable_properties_khr,
    p_next: ?*anyopaque = null,
    stages: ShaderStageFlags = @import("std").mem.zeroes(ShaderStageFlags),
    name: [256]u8 = @import("std").mem.zeroes([256]u8),
    description: [256]u8 = @import("std").mem.zeroes([256]u8),
    subgroup_size: u32 = @import("std").mem.zeroes(u32),
};
pub const PipelineExecutableInfoKHR = extern struct {
    s_type: StructureType = .pipeline_executable_info_khr,
    p_next: ?*const anyopaque = null,
    pipeline: Pipeline = @import("std").mem.zeroes(Pipeline),
    executable_index: u32 = @import("std").mem.zeroes(u32),
};
pub const PipelineExecutableStatisticKHR = extern struct {
    s_type: StructureType = .pipeline_executable_statistic_khr,
    p_next: ?*anyopaque = null,
    name: [256]u8 = @import("std").mem.zeroes([256]u8),
    description: [256]u8 = @import("std").mem.zeroes([256]u8),
    format: PipelineExecutableStatisticFormatKHR = @import("std").mem.zeroes(PipelineExecutableStatisticFormatKHR),
    value: PipelineExecutableStatisticValueKHR = @import("std").mem.zeroes(PipelineExecutableStatisticValueKHR),
};
pub const PipelineExecutableInternalRepresentationKHR = extern struct {
    s_type: StructureType = .pipeline_executable_internal_representation_khr,
    p_next: ?*anyopaque = null,
    name: [256]u8 = @import("std").mem.zeroes([256]u8),
    description: [256]u8 = @import("std").mem.zeroes([256]u8),
    is_text: Bool32 = @import("std").mem.zeroes(Bool32),
    data_size: usize = @import("std").mem.zeroes(usize),
    p_data: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
};
pub const PipelineLibraryCreateInfoKHR = extern struct {
    s_type: StructureType = .pipeline_library_create_info_khr,
    p_next: ?*const anyopaque = null,
    library_count: u32 = @import("std").mem.zeroes(u32),
    p_libraries: [*c]const Pipeline = @import("std").mem.zeroes([*c]const Pipeline),
};
pub const PresentIdKHR = extern struct {
    s_type: StructureType = .present_id_khr,
    p_next: ?*const anyopaque = null,
    swapchain_count: u32 = @import("std").mem.zeroes(u32),
    p_present_ids: [*c]const u64 = @import("std").mem.zeroes([*c]const u64),
};
pub const PhysicalDevicePresentIdFeaturesKHR = extern struct {
    s_type: StructureType = .physical_device_present_id_features_khr,
    p_next: ?*anyopaque = null,
    present_id: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const VideoEncodeInfoKHR = extern struct {
    s_type: StructureType = .video_encode_info_khr,
    p_next: ?*const anyopaque = null,
    flags: VideoEncodeFlagsKHR = @import("std").mem.zeroes(VideoEncodeFlagsKHR),
    dst_buffer: Buffer = @import("std").mem.zeroes(Buffer),
    dst_buffer_offset: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    dst_buffer_range: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    src_picture_resource: VideoPictureResourceInfoKHR = @import("std").mem.zeroes(VideoPictureResourceInfoKHR),
    p_setup_reference_slot: [*c]const VideoReferenceSlotInfoKHR = @import("std").mem.zeroes([*c]const VideoReferenceSlotInfoKHR),
    reference_slot_count: u32 = @import("std").mem.zeroes(u32),
    p_reference_slots: [*c]const VideoReferenceSlotInfoKHR = @import("std").mem.zeroes([*c]const VideoReferenceSlotInfoKHR),
    preceding_externally_encoded_bytes: u32 = @import("std").mem.zeroes(u32),
};
pub const VideoEncodeCapabilitiesKHR = extern struct {
    s_type: StructureType = .video_encode_capabilities_khr,
    p_next: ?*anyopaque = null,
    flags: VideoEncodeCapabilityFlagsKHR = @import("std").mem.zeroes(VideoEncodeCapabilityFlagsKHR),
    rate_control_modes: VideoEncodeRateControlModeFlagsKHR = @import("std").mem.zeroes(VideoEncodeRateControlModeFlagsKHR),
    max_rate_control_layers: u32 = @import("std").mem.zeroes(u32),
    max_bitrate: u64 = @import("std").mem.zeroes(u64),
    max_quality_levels: u32 = @import("std").mem.zeroes(u32),
    encode_input_picture_granularity: Extent2D = @import("std").mem.zeroes(Extent2D),
    supported_encode_feedback_flags: VideoEncodeFeedbackFlagsKHR = @import("std").mem.zeroes(VideoEncodeFeedbackFlagsKHR),
};
pub const QueryPoolVideoEncodeFeedbackCreateInfoKHR = extern struct {
    s_type: StructureType = .query_pool_video_encode_feedback_create_info_khr,
    p_next: ?*const anyopaque = null,
    encode_feedback_flags: VideoEncodeFeedbackFlagsKHR = @import("std").mem.zeroes(VideoEncodeFeedbackFlagsKHR),
};
pub const VideoEncodeUsageInfoKHR = extern struct {
    s_type: StructureType = .video_encode_usage_info_khr,
    p_next: ?*const anyopaque = null,
    video_usage_hints: VideoEncodeUsageFlagsKHR = @import("std").mem.zeroes(VideoEncodeUsageFlagsKHR),
    video_content_hints: VideoEncodeContentFlagsKHR = @import("std").mem.zeroes(VideoEncodeContentFlagsKHR),
    tuning_mode: VideoEncodeTuningModeKHR = @import("std").mem.zeroes(VideoEncodeTuningModeKHR),
};
pub const VideoEncodeRateControlLayerInfoKHR = extern struct {
    s_type: StructureType = .video_encode_rate_control_layer_info_khr,
    p_next: ?*const anyopaque = null,
    average_bitrate: u64 = @import("std").mem.zeroes(u64),
    max_bitrate: u64 = @import("std").mem.zeroes(u64),
    frame_rate_numerator: u32 = @import("std").mem.zeroes(u32),
    frame_rate_denominator: u32 = @import("std").mem.zeroes(u32),
};
pub const VideoEncodeRateControlInfoKHR = extern struct {
    s_type: StructureType = .video_encode_rate_control_info_khr,
    p_next: ?*const anyopaque = null,
    flags: VideoEncodeRateControlFlagsKHR = @import("std").mem.zeroes(VideoEncodeRateControlFlagsKHR),
    rate_control_mode: VideoEncodeRateControlModeFlagBitsKHR = @import("std").mem.zeroes(VideoEncodeRateControlModeFlagBitsKHR),
    layer_count: u32 = @import("std").mem.zeroes(u32),
    p_layers: [*c]const VideoEncodeRateControlLayerInfoKHR = @import("std").mem.zeroes([*c]const VideoEncodeRateControlLayerInfoKHR),
    virtual_buffer_size_in_ms: u32 = @import("std").mem.zeroes(u32),
    initial_virtual_buffer_size_in_ms: u32 = @import("std").mem.zeroes(u32),
};
pub const PhysicalDeviceVideoEncodeQualityLevelInfoKHR = extern struct {
    s_type: StructureType = .physical_device_video_encode_quality_level_info_khr,
    p_next: ?*const anyopaque = null,
    p_video_profile: [*c]const VideoProfileInfoKHR = @import("std").mem.zeroes([*c]const VideoProfileInfoKHR),
    quality_level: u32 = @import("std").mem.zeroes(u32),
};
pub const VideoEncodeQualityLevelPropertiesKHR = extern struct {
    s_type: StructureType = .video_encode_quality_level_properties_khr,
    p_next: ?*anyopaque = null,
    preferred_rate_control_mode: VideoEncodeRateControlModeFlagBitsKHR = @import("std").mem.zeroes(VideoEncodeRateControlModeFlagBitsKHR),
    preferred_rate_control_layer_count: u32 = @import("std").mem.zeroes(u32),
};
pub const VideoEncodeQualityLevelInfoKHR = extern struct {
    s_type: StructureType = .video_encode_quality_level_info_khr,
    p_next: ?*const anyopaque = null,
    quality_level: u32 = @import("std").mem.zeroes(u32),
};
pub const VideoEncodeSessionParametersGetInfoKHR = extern struct {
    s_type: StructureType = .video_encode_session_parameters_get_info_khr,
    p_next: ?*const anyopaque = null,
    video_session_parameters: VideoSessionParametersKHR = @import("std").mem.zeroes(VideoSessionParametersKHR),
};
pub const VideoEncodeSessionParametersFeedbackInfoKHR = extern struct {
    s_type: StructureType = .video_encode_session_parameters_feedback_info_khr,
    p_next: ?*anyopaque = null,
    has_overrides: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceFragmentShaderBarycentricFeaturesKHR = extern struct {
    s_type: StructureType = .physical_device_fragment_shader_barycentric_features_khr,
    p_next: ?*anyopaque = null,
    fragment_shader_barycentric: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceFragmentShaderBarycentricPropertiesKHR = extern struct {
    s_type: StructureType = .physical_device_fragment_shader_barycentric_properties_khr,
    p_next: ?*anyopaque = null,
    tri_strip_vertex_order_independent_of_provoking_vertex: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceShaderSubgroupUniformControlFlowFeaturesKHR = extern struct {
    s_type: StructureType = .physical_device_shader_subgroup_uniform_control_flow_features_khr,
    p_next: ?*anyopaque = null,
    shader_subgroup_uniform_control_flow: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceWorkgroupMemoryExplicitLayoutFeaturesKHR = extern struct {
    s_type: StructureType = .physical_device_workgroup_memory_explicit_layout_features_khr,
    p_next: ?*anyopaque = null,
    workgroup_memory_explicit_layout: Bool32 = @import("std").mem.zeroes(Bool32),
    workgroup_memory_explicit_layout_scalar_block_layout: Bool32 = @import("std").mem.zeroes(Bool32),
    workgroup_memory_explicit_layout8bit_access: Bool32 = @import("std").mem.zeroes(Bool32),
    workgroup_memory_explicit_layout16_bit_access: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceRayTracingMaintenance1FeaturesKHR = extern struct {
    s_type: StructureType = .physical_device_ray_tracing_maintenance1features_khr,
    p_next: ?*anyopaque = null,
    ray_tracing_maintenance1: Bool32 = @import("std").mem.zeroes(Bool32),
    ray_tracing_pipeline_trace_rays_indirect2: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const TraceRaysIndirectCommand2KHR = extern struct {
    raygen_shader_record_address: DeviceAddress = @import("std").mem.zeroes(DeviceAddress),
    raygen_shader_record_size: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    miss_shader_binding_table_address: DeviceAddress = @import("std").mem.zeroes(DeviceAddress),
    miss_shader_binding_table_size: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    miss_shader_binding_table_stride: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    hit_shader_binding_table_address: DeviceAddress = @import("std").mem.zeroes(DeviceAddress),
    hit_shader_binding_table_size: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    hit_shader_binding_table_stride: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    callable_shader_binding_table_address: DeviceAddress = @import("std").mem.zeroes(DeviceAddress),
    callable_shader_binding_table_size: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    callable_shader_binding_table_stride: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    width: u32 = @import("std").mem.zeroes(u32),
    height: u32 = @import("std").mem.zeroes(u32),
    depth: u32 = @import("std").mem.zeroes(u32),
};
pub const PhysicalDeviceShaderMaximalReconvergenceFeaturesKHR = extern struct {
    s_type: StructureType = .physical_device_shader_maximal_reconvergence_features_khr,
    p_next: ?*anyopaque = null,
    shader_maximal_reconvergence: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const SurfaceCapabilitiesPresentId2KHR = extern struct {
    s_type: StructureType = .surface_capabilities_present_id2khr,
    p_next: ?*anyopaque = null,
    present_id2supported: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PresentId2KHR = extern struct {
    s_type: StructureType = .present_id2khr,
    p_next: ?*const anyopaque = null,
    swapchain_count: u32 = @import("std").mem.zeroes(u32),
    p_present_ids: [*c]const u64 = @import("std").mem.zeroes([*c]const u64),
};
pub const PhysicalDevicePresentId2FeaturesKHR = extern struct {
    s_type: StructureType = .physical_device_present_id2features_khr,
    p_next: ?*anyopaque = null,
    present_id2: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const SurfaceCapabilitiesPresentWait2KHR = extern struct {
    s_type: StructureType = .surface_capabilities_present_wait2khr,
    p_next: ?*anyopaque = null,
    present_wait2supported: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDevicePresentWait2FeaturesKHR = extern struct {
    s_type: StructureType = .physical_device_present_wait2features_khr,
    p_next: ?*anyopaque = null,
    present_wait2: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PresentWait2InfoKHR = extern struct {
    s_type: StructureType = .present_wait2info_khr,
    p_next: ?*const anyopaque = null,
    present_id: u64 = @import("std").mem.zeroes(u64),
    timeout: u64 = @import("std").mem.zeroes(u64),
};
pub const PhysicalDeviceRayTracingPositionFetchFeaturesKHR = extern struct {
    s_type: StructureType = .physical_device_ray_tracing_position_fetch_features_khr,
    p_next: ?*anyopaque = null,
    ray_tracing_position_fetch: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDevicePipelineBinaryFeaturesKHR = extern struct {
    s_type: StructureType = .physical_device_pipeline_binary_features_khr,
    p_next: ?*anyopaque = null,
    pipeline_binaries: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDevicePipelineBinaryPropertiesKHR = extern struct {
    s_type: StructureType = .physical_device_pipeline_binary_properties_khr,
    p_next: ?*anyopaque = null,
    pipeline_binary_internal_cache: Bool32 = @import("std").mem.zeroes(Bool32),
    pipeline_binary_internal_cache_control: Bool32 = @import("std").mem.zeroes(Bool32),
    pipeline_binary_prefers_internal_cache: Bool32 = @import("std").mem.zeroes(Bool32),
    pipeline_binary_precompiled_internal_cache: Bool32 = @import("std").mem.zeroes(Bool32),
    pipeline_binary_compressed_data: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const DevicePipelineBinaryInternalCacheControlKHR = extern struct {
    s_type: StructureType = .device_pipeline_binary_internal_cache_control_khr,
    p_next: ?*const anyopaque = null,
    disable_internal_cache: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PipelineBinaryKeyKHR = extern struct {
    s_type: StructureType = .pipeline_binary_key_khr,
    p_next: ?*anyopaque = null,
    key_size: u32 = @import("std").mem.zeroes(u32),
    key: [32]u8 = @import("std").mem.zeroes([32]u8),
};
pub const PipelineBinaryDataKHR = extern struct {
    data_size: usize = @import("std").mem.zeroes(usize),
    p_data: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
};
pub const PipelineBinaryKeysAndDataKHR = extern struct {
    binary_count: u32 = @import("std").mem.zeroes(u32),
    p_pipeline_binary_keys: [*c]const PipelineBinaryKeyKHR = @import("std").mem.zeroes([*c]const PipelineBinaryKeyKHR),
    p_pipeline_binary_data: [*c]const PipelineBinaryDataKHR = @import("std").mem.zeroes([*c]const PipelineBinaryDataKHR),
};
pub const PipelineCreateInfoKHR = extern struct {
    s_type: StructureType = .pipeline_create_info_khr,
    p_next: ?*anyopaque = null,
};
pub const PipelineBinaryCreateInfoKHR = extern struct {
    s_type: StructureType = .pipeline_binary_create_info_khr,
    p_next: ?*const anyopaque = null,
    p_keys_and_data_info: [*c]const PipelineBinaryKeysAndDataKHR = @import("std").mem.zeroes([*c]const PipelineBinaryKeysAndDataKHR),
    pipeline: Pipeline = @import("std").mem.zeroes(Pipeline),
    p_pipeline_create_info: [*c]const PipelineCreateInfoKHR = @import("std").mem.zeroes([*c]const PipelineCreateInfoKHR),
};
pub const PipelineBinaryInfoKHR = extern struct {
    s_type: StructureType = .pipeline_binary_info_khr,
    p_next: ?*const anyopaque = null,
    binary_count: u32 = @import("std").mem.zeroes(u32),
    p_pipeline_binaries: [*c]const PipelineBinaryKHR = @import("std").mem.zeroes([*c]const PipelineBinaryKHR),
};
pub const ReleaseCapturedPipelineDataInfoKHR = extern struct {
    s_type: StructureType = .release_captured_pipeline_data_info_khr,
    p_next: ?*anyopaque = null,
    pipeline: Pipeline = @import("std").mem.zeroes(Pipeline),
};
pub const PipelineBinaryDataInfoKHR = extern struct {
    s_type: StructureType = .pipeline_binary_data_info_khr,
    p_next: ?*anyopaque = null,
    pipeline_binary: PipelineBinaryKHR = @import("std").mem.zeroes(PipelineBinaryKHR),
};
pub const PipelineBinaryHandlesInfoKHR = extern struct {
    s_type: StructureType = .pipeline_binary_handles_info_khr,
    p_next: ?*const anyopaque = null,
    pipeline_binary_count: u32 = @import("std").mem.zeroes(u32),
    p_pipeline_binaries: [*c]PipelineBinaryKHR = @import("std").mem.zeroes([*c]PipelineBinaryKHR),
};
pub const SurfacePresentModeKHR = extern struct {
    s_type: StructureType = .surface_present_mode_khr,
    p_next: ?*anyopaque = null,
    present_mode: PresentModeKHR = @import("std").mem.zeroes(PresentModeKHR),
};
pub const SurfacePresentScalingCapabilitiesKHR = extern struct {
    s_type: StructureType = .surface_present_scaling_capabilities_khr,
    p_next: ?*anyopaque = null,
    supported_present_scaling: PresentScalingFlagsKHR = @import("std").mem.zeroes(PresentScalingFlagsKHR),
    supported_present_gravity_x: PresentGravityFlagsKHR = @import("std").mem.zeroes(PresentGravityFlagsKHR),
    supported_present_gravity_y: PresentGravityFlagsKHR = @import("std").mem.zeroes(PresentGravityFlagsKHR),
    min_scaled_image_extent: Extent2D = @import("std").mem.zeroes(Extent2D),
    max_scaled_image_extent: Extent2D = @import("std").mem.zeroes(Extent2D),
};
pub const SurfacePresentModeCompatibilityKHR = extern struct {
    s_type: StructureType = .surface_present_mode_compatibility_khr,
    p_next: ?*anyopaque = null,
    present_mode_count: u32 = @import("std").mem.zeroes(u32),
    p_present_modes: [*c]PresentModeKHR = @import("std").mem.zeroes([*c]PresentModeKHR),
};
pub const PhysicalDeviceSwapchainMaintenance1FeaturesKHR = extern struct {
    s_type: StructureType = .physical_device_swapchain_maintenance1features_khr,
    p_next: ?*anyopaque = null,
    swapchain_maintenance1: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const SwapchainPresentFenceInfoKHR = extern struct {
    s_type: StructureType = .swapchain_present_fence_info_khr,
    p_next: ?*const anyopaque = null,
    swapchain_count: u32 = @import("std").mem.zeroes(u32),
    p_fences: [*c]const Fence = @import("std").mem.zeroes([*c]const Fence),
};
pub const SwapchainPresentModesCreateInfoKHR = extern struct {
    s_type: StructureType = .swapchain_present_modes_create_info_khr,
    p_next: ?*const anyopaque = null,
    present_mode_count: u32 = @import("std").mem.zeroes(u32),
    p_present_modes: [*c]const PresentModeKHR = @import("std").mem.zeroes([*c]const PresentModeKHR),
};
pub const SwapchainPresentModeInfoKHR = extern struct {
    s_type: StructureType = .swapchain_present_mode_info_khr,
    p_next: ?*const anyopaque = null,
    swapchain_count: u32 = @import("std").mem.zeroes(u32),
    p_present_modes: [*c]const PresentModeKHR = @import("std").mem.zeroes([*c]const PresentModeKHR),
};
pub const SwapchainPresentScalingCreateInfoKHR = extern struct {
    s_type: StructureType = .swapchain_present_scaling_create_info_khr,
    p_next: ?*const anyopaque = null,
    scaling_behavior: PresentScalingFlagsKHR = @import("std").mem.zeroes(PresentScalingFlagsKHR),
    present_gravity_x: PresentGravityFlagsKHR = @import("std").mem.zeroes(PresentGravityFlagsKHR),
    present_gravity_y: PresentGravityFlagsKHR = @import("std").mem.zeroes(PresentGravityFlagsKHR),
};
pub const ReleaseSwapchainImagesInfoKHR = extern struct {
    s_type: StructureType = .release_swapchain_images_info_khr,
    p_next: ?*const anyopaque = null,
    swapchain: SwapchainKHR = @import("std").mem.zeroes(SwapchainKHR),
    image_index_count: u32 = @import("std").mem.zeroes(u32),
    p_image_indices: [*c]const u32 = @import("std").mem.zeroes([*c]const u32),
};
pub const CooperativeMatrixPropertiesKHR = extern struct {
    s_type: StructureType = .cooperative_matrix_properties_khr,
    p_next: ?*anyopaque = null,
    msize: u32 = @import("std").mem.zeroes(u32),
    nsize: u32 = @import("std").mem.zeroes(u32),
    ksize: u32 = @import("std").mem.zeroes(u32),
    atype: ComponentTypeKHR = @import("std").mem.zeroes(ComponentTypeKHR),
    btype: ComponentTypeKHR = @import("std").mem.zeroes(ComponentTypeKHR),
    ctype: ComponentTypeKHR = @import("std").mem.zeroes(ComponentTypeKHR),
    result_type: ComponentTypeKHR = @import("std").mem.zeroes(ComponentTypeKHR),
    saturating_accumulation: Bool32 = @import("std").mem.zeroes(Bool32),
    scope: ScopeKHR = @import("std").mem.zeroes(ScopeKHR),
};
pub const PhysicalDeviceCooperativeMatrixFeaturesKHR = extern struct {
    s_type: StructureType = .physical_device_cooperative_matrix_features_khr,
    p_next: ?*anyopaque = null,
    cooperative_matrix: Bool32 = @import("std").mem.zeroes(Bool32),
    cooperative_matrix_robust_buffer_access: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceCooperativeMatrixPropertiesKHR = extern struct {
    s_type: StructureType = .physical_device_cooperative_matrix_properties_khr,
    p_next: ?*anyopaque = null,
    cooperative_matrix_supported_stages: ShaderStageFlags = @import("std").mem.zeroes(ShaderStageFlags),
};
pub const PhysicalDeviceComputeShaderDerivativesFeaturesKHR = extern struct {
    s_type: StructureType = .physical_device_compute_shader_derivatives_features_khr,
    p_next: ?*anyopaque = null,
    compute_derivative_group_quads: Bool32 = @import("std").mem.zeroes(Bool32),
    compute_derivative_group_linear: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceComputeShaderDerivativesPropertiesKHR = extern struct {
    s_type: StructureType = .physical_device_compute_shader_derivatives_properties_khr,
    p_next: ?*anyopaque = null,
    mesh_and_task_shader_derivatives: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const VideoDecodeAV1ProfileInfoKHR = extern struct {
    s_type: StructureType = .video_decode_av1profile_info_khr,
    p_next: ?*const anyopaque = null,
    std_profile: StdVideoAV1Profile = @import("std").mem.zeroes(StdVideoAV1Profile),
    film_grain_support: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const VideoDecodeAV1CapabilitiesKHR = extern struct {
    s_type: StructureType = .video_decode_av1capabilities_khr,
    p_next: ?*anyopaque = null,
    max_level: StdVideoAV1Level = @import("std").mem.zeroes(StdVideoAV1Level),
};
pub const VideoDecodeAV1SessionParametersCreateInfoKHR = extern struct {
    s_type: StructureType = .video_decode_av1session_parameters_create_info_khr,
    p_next: ?*const anyopaque = null,
    p_std_sequence_header: ?*const StdVideoAV1SequenceHeader = @import("std").mem.zeroes(?*const StdVideoAV1SequenceHeader),
};
pub const VideoDecodeAV1PictureInfoKHR = extern struct {
    s_type: StructureType = .video_decode_av1picture_info_khr,
    p_next: ?*const anyopaque = null,
    p_std_picture_info: ?*const StdVideoDecodeAV1PictureInfo = @import("std").mem.zeroes(?*const StdVideoDecodeAV1PictureInfo),
    reference_name_slot_indices: [7]i32 = @import("std").mem.zeroes([7]i32),
    frame_header_offset: u32 = @import("std").mem.zeroes(u32),
    tile_count: u32 = @import("std").mem.zeroes(u32),
    p_tile_offsets: [*c]const u32 = @import("std").mem.zeroes([*c]const u32),
    p_tile_sizes: [*c]const u32 = @import("std").mem.zeroes([*c]const u32),
};
pub const VideoDecodeAV1DpbSlotInfoKHR = extern struct {
    s_type: StructureType = .video_decode_av1dpb_slot_info_khr,
    p_next: ?*const anyopaque = null,
    p_std_reference_info: ?*const StdVideoDecodeAV1ReferenceInfo = @import("std").mem.zeroes(?*const StdVideoDecodeAV1ReferenceInfo),
};
pub const PhysicalDeviceVideoEncodeAV1FeaturesKHR = extern struct {
    s_type: StructureType = .physical_device_video_encode_av1features_khr,
    p_next: ?*anyopaque = null,
    video_encode_av1: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const VideoEncodeAV1CapabilitiesKHR = extern struct {
    s_type: StructureType = .video_encode_av1capabilities_khr,
    p_next: ?*anyopaque = null,
    flags: VideoEncodeAV1CapabilityFlagsKHR = @import("std").mem.zeroes(VideoEncodeAV1CapabilityFlagsKHR),
    max_level: StdVideoAV1Level = @import("std").mem.zeroes(StdVideoAV1Level),
    coded_picture_alignment: Extent2D = @import("std").mem.zeroes(Extent2D),
    max_tiles: Extent2D = @import("std").mem.zeroes(Extent2D),
    min_tile_size: Extent2D = @import("std").mem.zeroes(Extent2D),
    max_tile_size: Extent2D = @import("std").mem.zeroes(Extent2D),
    superblock_sizes: VideoEncodeAV1SuperblockSizeFlagsKHR = @import("std").mem.zeroes(VideoEncodeAV1SuperblockSizeFlagsKHR),
    max_single_reference_count: u32 = @import("std").mem.zeroes(u32),
    single_reference_name_mask: u32 = @import("std").mem.zeroes(u32),
    max_unidirectional_compound_reference_count: u32 = @import("std").mem.zeroes(u32),
    max_unidirectional_compound_group1reference_count: u32 = @import("std").mem.zeroes(u32),
    unidirectional_compound_reference_name_mask: u32 = @import("std").mem.zeroes(u32),
    max_bidirectional_compound_reference_count: u32 = @import("std").mem.zeroes(u32),
    max_bidirectional_compound_group1reference_count: u32 = @import("std").mem.zeroes(u32),
    max_bidirectional_compound_group2reference_count: u32 = @import("std").mem.zeroes(u32),
    bidirectional_compound_reference_name_mask: u32 = @import("std").mem.zeroes(u32),
    max_temporal_layer_count: u32 = @import("std").mem.zeroes(u32),
    max_spatial_layer_count: u32 = @import("std").mem.zeroes(u32),
    max_operating_points: u32 = @import("std").mem.zeroes(u32),
    min_qindex: u32 = @import("std").mem.zeroes(u32),
    max_qindex: u32 = @import("std").mem.zeroes(u32),
    prefers_gop_remaining_frames: Bool32 = @import("std").mem.zeroes(Bool32),
    requires_gop_remaining_frames: Bool32 = @import("std").mem.zeroes(Bool32),
    std_syntax_flags: VideoEncodeAV1StdFlagsKHR = @import("std").mem.zeroes(VideoEncodeAV1StdFlagsKHR),
};
pub const VideoEncodeAV1QIndexKHR = extern struct {
    intra_qindex: u32 = @import("std").mem.zeroes(u32),
    predictive_qindex: u32 = @import("std").mem.zeroes(u32),
    bipredictive_qindex: u32 = @import("std").mem.zeroes(u32),
};
pub const VideoEncodeAV1QualityLevelPropertiesKHR = extern struct {
    s_type: StructureType = .video_encode_av1quality_level_properties_khr,
    p_next: ?*anyopaque = null,
    preferred_rate_control_flags: VideoEncodeAV1RateControlFlagsKHR = @import("std").mem.zeroes(VideoEncodeAV1RateControlFlagsKHR),
    preferred_gop_frame_count: u32 = @import("std").mem.zeroes(u32),
    preferred_key_frame_period: u32 = @import("std").mem.zeroes(u32),
    preferred_consecutive_bipredictive_frame_count: u32 = @import("std").mem.zeroes(u32),
    preferred_temporal_layer_count: u32 = @import("std").mem.zeroes(u32),
    preferred_constant_qindex: VideoEncodeAV1QIndexKHR = @import("std").mem.zeroes(VideoEncodeAV1QIndexKHR),
    preferred_max_single_reference_count: u32 = @import("std").mem.zeroes(u32),
    preferred_single_reference_name_mask: u32 = @import("std").mem.zeroes(u32),
    preferred_max_unidirectional_compound_reference_count: u32 = @import("std").mem.zeroes(u32),
    preferred_max_unidirectional_compound_group1reference_count: u32 = @import("std").mem.zeroes(u32),
    preferred_unidirectional_compound_reference_name_mask: u32 = @import("std").mem.zeroes(u32),
    preferred_max_bidirectional_compound_reference_count: u32 = @import("std").mem.zeroes(u32),
    preferred_max_bidirectional_compound_group1reference_count: u32 = @import("std").mem.zeroes(u32),
    preferred_max_bidirectional_compound_group2reference_count: u32 = @import("std").mem.zeroes(u32),
    preferred_bidirectional_compound_reference_name_mask: u32 = @import("std").mem.zeroes(u32),
};
pub const VideoEncodeAV1SessionCreateInfoKHR = extern struct {
    s_type: StructureType = .video_encode_av1session_create_info_khr,
    p_next: ?*const anyopaque = null,
    use_max_level: Bool32 = @import("std").mem.zeroes(Bool32),
    max_level: StdVideoAV1Level = @import("std").mem.zeroes(StdVideoAV1Level),
};
pub const VideoEncodeAV1SessionParametersCreateInfoKHR = extern struct {
    s_type: StructureType = .video_encode_av1session_parameters_create_info_khr,
    p_next: ?*const anyopaque = null,
    p_std_sequence_header: ?*const StdVideoAV1SequenceHeader = @import("std").mem.zeroes(?*const StdVideoAV1SequenceHeader),
    p_std_decoder_model_info: [*c]const StdVideoEncodeAV1DecoderModelInfo = @import("std").mem.zeroes([*c]const StdVideoEncodeAV1DecoderModelInfo),
    std_operating_point_count: u32 = @import("std").mem.zeroes(u32),
    p_std_operating_points: ?*const StdVideoEncodeAV1OperatingPointInfo = @import("std").mem.zeroes(?*const StdVideoEncodeAV1OperatingPointInfo),
};
pub const VideoEncodeAV1PictureInfoKHR = extern struct {
    s_type: StructureType = .video_encode_av1picture_info_khr,
    p_next: ?*const anyopaque = null,
    prediction_mode: VideoEncodeAV1PredictionModeKHR = @import("std").mem.zeroes(VideoEncodeAV1PredictionModeKHR),
    rate_control_group: VideoEncodeAV1RateControlGroupKHR = @import("std").mem.zeroes(VideoEncodeAV1RateControlGroupKHR),
    constant_qindex: u32 = @import("std").mem.zeroes(u32),
    p_std_picture_info: ?*const StdVideoEncodeAV1PictureInfo = @import("std").mem.zeroes(?*const StdVideoEncodeAV1PictureInfo),
    reference_name_slot_indices: [7]i32 = @import("std").mem.zeroes([7]i32),
    primary_reference_cdf_only: Bool32 = @import("std").mem.zeroes(Bool32),
    generate_obu_extension_header: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const VideoEncodeAV1DpbSlotInfoKHR = extern struct {
    s_type: StructureType = .video_encode_av1dpb_slot_info_khr,
    p_next: ?*const anyopaque = null,
    p_std_reference_info: ?*const StdVideoEncodeAV1ReferenceInfo = @import("std").mem.zeroes(?*const StdVideoEncodeAV1ReferenceInfo),
};
pub const VideoEncodeAV1ProfileInfoKHR = extern struct {
    s_type: StructureType = .video_encode_av1profile_info_khr,
    p_next: ?*const anyopaque = null,
    std_profile: StdVideoAV1Profile = @import("std").mem.zeroes(StdVideoAV1Profile),
};
pub const VideoEncodeAV1FrameSizeKHR = extern struct {
    intra_frame_size: u32 = @import("std").mem.zeroes(u32),
    predictive_frame_size: u32 = @import("std").mem.zeroes(u32),
    bipredictive_frame_size: u32 = @import("std").mem.zeroes(u32),
};
pub const VideoEncodeAV1GopRemainingFrameInfoKHR = extern struct {
    s_type: StructureType = .video_encode_av1gop_remaining_frame_info_khr,
    p_next: ?*const anyopaque = null,
    use_gop_remaining_frames: Bool32 = @import("std").mem.zeroes(Bool32),
    gop_remaining_intra: u32 = @import("std").mem.zeroes(u32),
    gop_remaining_predictive: u32 = @import("std").mem.zeroes(u32),
    gop_remaining_bipredictive: u32 = @import("std").mem.zeroes(u32),
};
pub const VideoEncodeAV1RateControlInfoKHR = extern struct {
    s_type: StructureType = .video_encode_av1rate_control_info_khr,
    p_next: ?*const anyopaque = null,
    flags: VideoEncodeAV1RateControlFlagsKHR = @import("std").mem.zeroes(VideoEncodeAV1RateControlFlagsKHR),
    gop_frame_count: u32 = @import("std").mem.zeroes(u32),
    key_frame_period: u32 = @import("std").mem.zeroes(u32),
    consecutive_bipredictive_frame_count: u32 = @import("std").mem.zeroes(u32),
    temporal_layer_count: u32 = @import("std").mem.zeroes(u32),
};
pub const VideoEncodeAV1RateControlLayerInfoKHR = extern struct {
    s_type: StructureType = .video_encode_av1rate_control_layer_info_khr,
    p_next: ?*const anyopaque = null,
    use_min_qindex: Bool32 = @import("std").mem.zeroes(Bool32),
    min_qindex: VideoEncodeAV1QIndexKHR = @import("std").mem.zeroes(VideoEncodeAV1QIndexKHR),
    use_max_qindex: Bool32 = @import("std").mem.zeroes(Bool32),
    max_qindex: VideoEncodeAV1QIndexKHR = @import("std").mem.zeroes(VideoEncodeAV1QIndexKHR),
    use_max_frame_size: Bool32 = @import("std").mem.zeroes(Bool32),
    max_frame_size: VideoEncodeAV1FrameSizeKHR = @import("std").mem.zeroes(VideoEncodeAV1FrameSizeKHR),
};
pub const PhysicalDeviceVideoDecodeVP9FeaturesKHR = extern struct {
    s_type: StructureType = .physical_device_video_decode_vp9features_khr,
    p_next: ?*anyopaque = null,
    video_decode_vp9: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const VideoDecodeVP9ProfileInfoKHR = extern struct {
    s_type: StructureType = .video_decode_vp9profile_info_khr,
    p_next: ?*const anyopaque = null,
    std_profile: StdVideoVP9Profile = @import("std").mem.zeroes(StdVideoVP9Profile),
};
pub const VideoDecodeVP9CapabilitiesKHR = extern struct {
    s_type: StructureType = .video_decode_vp9capabilities_khr,
    p_next: ?*anyopaque = null,
    max_level: StdVideoVP9Level = @import("std").mem.zeroes(StdVideoVP9Level),
};
pub const VideoDecodeVP9PictureInfoKHR = extern struct {
    s_type: StructureType = .video_decode_vp9picture_info_khr,
    p_next: ?*const anyopaque = null,
    p_std_picture_info: ?*const StdVideoDecodeVP9PictureInfo = @import("std").mem.zeroes(?*const StdVideoDecodeVP9PictureInfo),
    reference_name_slot_indices: [3]i32 = @import("std").mem.zeroes([3]i32),
    uncompressed_header_offset: u32 = @import("std").mem.zeroes(u32),
    compressed_header_offset: u32 = @import("std").mem.zeroes(u32),
    tiles_offset: u32 = @import("std").mem.zeroes(u32),
};
pub const PhysicalDeviceVideoMaintenance1FeaturesKHR = extern struct {
    s_type: StructureType = .physical_device_video_maintenance1features_khr,
    p_next: ?*anyopaque = null,
    video_maintenance1: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const VideoInlineQueryInfoKHR = extern struct {
    s_type: StructureType = .video_inline_query_info_khr,
    p_next: ?*const anyopaque = null,
    query_pool: QueryPool = @import("std").mem.zeroes(QueryPool),
    first_query: u32 = @import("std").mem.zeroes(u32),
    query_count: u32 = @import("std").mem.zeroes(u32),
};
pub const PhysicalDeviceUnifiedImageLayoutsFeaturesKHR = extern struct {
    s_type: StructureType = .physical_device_unified_image_layouts_features_khr,
    p_next: ?*anyopaque = null,
    unified_image_layouts: Bool32 = @import("std").mem.zeroes(Bool32),
    unified_image_layouts_video: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const AttachmentFeedbackLoopInfoEXT = extern struct {
    s_type: StructureType = .attachment_feedback_loop_info_ext,
    p_next: ?*const anyopaque = null,
    feedback_loop_enable: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const CalibratedTimestampInfoKHR = extern struct {
    s_type: StructureType = .calibrated_timestamp_info_khr,
    p_next: ?*const anyopaque = null,
    time_domain: TimeDomainKHR = @import("std").mem.zeroes(TimeDomainKHR),
};
pub const SetDescriptorBufferOffsetsInfoEXT = extern struct {
    s_type: StructureType = .set_descriptor_buffer_offsets_info_ext,
    p_next: ?*const anyopaque = null,
    stage_flags: ShaderStageFlags = @import("std").mem.zeroes(ShaderStageFlags),
    layout: PipelineLayout = @import("std").mem.zeroes(PipelineLayout),
    first_set: u32 = @import("std").mem.zeroes(u32),
    set_count: u32 = @import("std").mem.zeroes(u32),
    p_buffer_indices: [*c]const u32 = @import("std").mem.zeroes([*c]const u32),
    p_offsets: [*c]const DeviceSize = @import("std").mem.zeroes([*c]const DeviceSize),
};
pub const BindDescriptorBufferEmbeddedSamplersInfoEXT = extern struct {
    s_type: StructureType = .bind_descriptor_buffer_embedded_samplers_info_ext,
    p_next: ?*const anyopaque = null,
    stage_flags: ShaderStageFlags = @import("std").mem.zeroes(ShaderStageFlags),
    layout: PipelineLayout = @import("std").mem.zeroes(PipelineLayout),
    set: u32 = @import("std").mem.zeroes(u32),
};
pub const VideoEncodeIntraRefreshCapabilitiesKHR = extern struct {
    s_type: StructureType = .video_encode_intra_refresh_capabilities_khr,
    p_next: ?*anyopaque = null,
    intra_refresh_modes: VideoEncodeIntraRefreshModeFlagsKHR = @import("std").mem.zeroes(VideoEncodeIntraRefreshModeFlagsKHR),
    max_intra_refresh_cycle_duration: u32 = @import("std").mem.zeroes(u32),
    max_intra_refresh_active_reference_pictures: u32 = @import("std").mem.zeroes(u32),
    partition_independent_intra_refresh_regions: Bool32 = @import("std").mem.zeroes(Bool32),
    non_rectangular_intra_refresh_regions: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const VideoEncodeSessionIntraRefreshCreateInfoKHR = extern struct {
    s_type: StructureType = .video_encode_session_intra_refresh_create_info_khr,
    p_next: ?*const anyopaque = null,
    intra_refresh_mode: VideoEncodeIntraRefreshModeFlagBitsKHR = @import("std").mem.zeroes(VideoEncodeIntraRefreshModeFlagBitsKHR),
};
pub const VideoEncodeIntraRefreshInfoKHR = extern struct {
    s_type: StructureType = .video_encode_intra_refresh_info_khr,
    p_next: ?*const anyopaque = null,
    intra_refresh_cycle_duration: u32 = @import("std").mem.zeroes(u32),
    intra_refresh_index: u32 = @import("std").mem.zeroes(u32),
};
pub const VideoReferenceIntraRefreshInfoKHR = extern struct {
    s_type: StructureType = .video_reference_intra_refresh_info_khr,
    p_next: ?*const anyopaque = null,
    dirty_intra_refresh_regions: u32 = @import("std").mem.zeroes(u32),
};
pub const PhysicalDeviceVideoEncodeIntraRefreshFeaturesKHR = extern struct {
    s_type: StructureType = .physical_device_video_encode_intra_refresh_features_khr,
    p_next: ?*anyopaque = null,
    video_encode_intra_refresh: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const VideoEncodeQuantizationMapCapabilitiesKHR = extern struct {
    s_type: StructureType = .video_encode_quantization_map_capabilities_khr,
    p_next: ?*anyopaque = null,
    max_quantization_map_extent: Extent2D = @import("std").mem.zeroes(Extent2D),
};
pub const VideoFormatQuantizationMapPropertiesKHR = extern struct {
    s_type: StructureType = .video_format_quantization_map_properties_khr,
    p_next: ?*anyopaque = null,
    quantization_map_texel_size: Extent2D = @import("std").mem.zeroes(Extent2D),
};
pub const VideoEncodeQuantizationMapInfoKHR = extern struct {
    s_type: StructureType = .video_encode_quantization_map_info_khr,
    p_next: ?*const anyopaque = null,
    quantization_map: ImageView = @import("std").mem.zeroes(ImageView),
    quantization_map_extent: Extent2D = @import("std").mem.zeroes(Extent2D),
};
pub const VideoEncodeQuantizationMapSessionParametersCreateInfoKHR = extern struct {
    s_type: StructureType = .video_encode_quantization_map_session_parameters_create_info_khr,
    p_next: ?*const anyopaque = null,
    quantization_map_texel_size: Extent2D = @import("std").mem.zeroes(Extent2D),
};
pub const PhysicalDeviceVideoEncodeQuantizationMapFeaturesKHR = extern struct {
    s_type: StructureType = .physical_device_video_encode_quantization_map_features_khr,
    p_next: ?*anyopaque = null,
    video_encode_quantization_map: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const VideoEncodeH264QuantizationMapCapabilitiesKHR = extern struct {
    s_type: StructureType = .video_encode_h264_quantization_map_capabilities_khr,
    p_next: ?*anyopaque = null,
    min_qp_delta: i32 = @import("std").mem.zeroes(i32),
    max_qp_delta: i32 = @import("std").mem.zeroes(i32),
};
pub const VideoEncodeH265QuantizationMapCapabilitiesKHR = extern struct {
    s_type: StructureType = .video_encode_h265_quantization_map_capabilities_khr,
    p_next: ?*anyopaque = null,
    min_qp_delta: i32 = @import("std").mem.zeroes(i32),
    max_qp_delta: i32 = @import("std").mem.zeroes(i32),
};
pub const VideoFormatH265QuantizationMapPropertiesKHR = extern struct {
    s_type: StructureType = .video_format_h265_quantization_map_properties_khr,
    p_next: ?*anyopaque = null,
    compatible_ctb_sizes: VideoEncodeH265CtbSizeFlagsKHR = @import("std").mem.zeroes(VideoEncodeH265CtbSizeFlagsKHR),
};
pub const VideoEncodeAV1QuantizationMapCapabilitiesKHR = extern struct {
    s_type: StructureType = .video_encode_av1quantization_map_capabilities_khr,
    p_next: ?*anyopaque = null,
    min_qindex_delta: i32 = @import("std").mem.zeroes(i32),
    max_qindex_delta: i32 = @import("std").mem.zeroes(i32),
};
pub const VideoFormatAV1QuantizationMapPropertiesKHR = extern struct {
    s_type: StructureType = .video_format_av1quantization_map_properties_khr,
    p_next: ?*anyopaque = null,
    compatible_superblock_sizes: VideoEncodeAV1SuperblockSizeFlagsKHR = @import("std").mem.zeroes(VideoEncodeAV1SuperblockSizeFlagsKHR),
};
pub const PhysicalDeviceShaderRelaxedExtendedInstructionFeaturesKHR = extern struct {
    s_type: StructureType = .physical_device_shader_relaxed_extended_instruction_features_khr,
    p_next: ?*anyopaque = null,
    shader_relaxed_extended_instruction: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceMaintenance7FeaturesKHR = extern struct {
    s_type: StructureType = .physical_device_maintenance7features_khr,
    p_next: ?*anyopaque = null,
    maintenance7: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceMaintenance7PropertiesKHR = extern struct {
    s_type: StructureType = .physical_device_maintenance7properties_khr,
    p_next: ?*anyopaque = null,
    robust_fragment_shading_rate_attachment_access: Bool32 = @import("std").mem.zeroes(Bool32),
    separate_depth_stencil_attachment_access: Bool32 = @import("std").mem.zeroes(Bool32),
    max_descriptor_set_total_uniform_buffers_dynamic: u32 = @import("std").mem.zeroes(u32),
    max_descriptor_set_total_storage_buffers_dynamic: u32 = @import("std").mem.zeroes(u32),
    max_descriptor_set_total_buffers_dynamic: u32 = @import("std").mem.zeroes(u32),
    max_descriptor_set_update_after_bind_total_uniform_buffers_dynamic: u32 = @import("std").mem.zeroes(u32),
    max_descriptor_set_update_after_bind_total_storage_buffers_dynamic: u32 = @import("std").mem.zeroes(u32),
    max_descriptor_set_update_after_bind_total_buffers_dynamic: u32 = @import("std").mem.zeroes(u32),
};
pub const PhysicalDeviceLayeredApiPropertiesKHR = extern struct {
    s_type: StructureType = .physical_device_layered_api_properties_khr,
    p_next: ?*anyopaque = null,
    vendor_id: u32 = @import("std").mem.zeroes(u32),
    device_id: u32 = @import("std").mem.zeroes(u32),
    layered_api: PhysicalDeviceLayeredApiKHR = @import("std").mem.zeroes(PhysicalDeviceLayeredApiKHR),
    device_name: [256]u8 = @import("std").mem.zeroes([256]u8),
};
pub const PhysicalDeviceLayeredApiPropertiesListKHR = extern struct {
    s_type: StructureType = .physical_device_layered_api_properties_list_khr,
    p_next: ?*anyopaque = null,
    layered_api_count: u32 = @import("std").mem.zeroes(u32),
    p_layered_apis: [*c]PhysicalDeviceLayeredApiPropertiesKHR = @import("std").mem.zeroes([*c]PhysicalDeviceLayeredApiPropertiesKHR),
};
pub const PhysicalDeviceLayeredApiVulkanPropertiesKHR = extern struct {
    s_type: StructureType = .physical_device_layered_api_vulkan_properties_khr,
    p_next: ?*anyopaque = null,
    properties: PhysicalDeviceProperties2 = @import("std").mem.zeroes(PhysicalDeviceProperties2),
};
pub const PhysicalDeviceMaintenance8FeaturesKHR = extern struct {
    s_type: StructureType = .physical_device_maintenance8features_khr,
    p_next: ?*anyopaque = null,
    maintenance8: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const MemoryBarrierAccessFlags3KHR = extern struct {
    s_type: StructureType = .memory_barrier_access_flags3khr,
    p_next: ?*const anyopaque = null,
    src_access_mask3: AccessFlags3KHR = @import("std").mem.zeroes(AccessFlags3KHR),
    dst_access_mask3: AccessFlags3KHR = @import("std").mem.zeroes(AccessFlags3KHR),
};
pub const PhysicalDeviceMaintenance9FeaturesKHR = extern struct {
    s_type: StructureType = .physical_device_maintenance9features_khr,
    p_next: ?*anyopaque = null,
    maintenance9: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceMaintenance9PropertiesKHR = extern struct {
    s_type: StructureType = .physical_device_maintenance9properties_khr,
    p_next: ?*anyopaque = null,
    image2_dview_of3_dsparse: Bool32 = @import("std").mem.zeroes(Bool32),
    default_vertex_attribute_value: DefaultVertexAttributeValueKHR = @import("std").mem.zeroes(DefaultVertexAttributeValueKHR),
};
pub const QueueFamilyOwnershipTransferPropertiesKHR = extern struct {
    s_type: StructureType = .queue_family_ownership_transfer_properties_khr,
    p_next: ?*anyopaque = null,
    optimal_image_transfer_to_queue_families: u32 = @import("std").mem.zeroes(u32),
};
pub const PhysicalDeviceVideoMaintenance2FeaturesKHR = extern struct {
    s_type: StructureType = .physical_device_video_maintenance2features_khr,
    p_next: ?*anyopaque = null,
    video_maintenance2: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const VideoDecodeH264InlineSessionParametersInfoKHR = extern struct {
    s_type: StructureType = .video_decode_h264_inline_session_parameters_info_khr,
    p_next: ?*const anyopaque = null,
    p_std_sps: ?*const StdVideoH264SequenceParameterSet = @import("std").mem.zeroes(?*const StdVideoH264SequenceParameterSet),
    p_std_pps: ?*const StdVideoH264PictureParameterSet = @import("std").mem.zeroes(?*const StdVideoH264PictureParameterSet),
};
pub const VideoDecodeH265InlineSessionParametersInfoKHR = extern struct {
    s_type: StructureType = .video_decode_h265_inline_session_parameters_info_khr,
    p_next: ?*const anyopaque = null,
    p_std_vps: ?*const StdVideoH265VideoParameterSet = @import("std").mem.zeroes(?*const StdVideoH265VideoParameterSet),
    p_std_sps: ?*const StdVideoH265SequenceParameterSet = @import("std").mem.zeroes(?*const StdVideoH265SequenceParameterSet),
    p_std_pps: ?*const StdVideoH265PictureParameterSet = @import("std").mem.zeroes(?*const StdVideoH265PictureParameterSet),
};
pub const VideoDecodeAV1InlineSessionParametersInfoKHR = extern struct {
    s_type: StructureType = .video_decode_av1inline_session_parameters_info_khr,
    p_next: ?*const anyopaque = null,
    p_std_sequence_header: ?*const StdVideoAV1SequenceHeader = @import("std").mem.zeroes(?*const StdVideoAV1SequenceHeader),
};
pub const PhysicalDeviceDepthClampZeroOneFeaturesKHR = extern struct {
    s_type: StructureType = .physical_device_depth_clamp_zero_one_features_khr,
    p_next: ?*anyopaque = null,
    depth_clamp_zero_one: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceRobustness2FeaturesKHR = extern struct {
    s_type: StructureType = .physical_device_robustness2features_khr,
    p_next: ?*anyopaque = null,
    robust_buffer_access2: Bool32 = @import("std").mem.zeroes(Bool32),
    robust_image_access2: Bool32 = @import("std").mem.zeroes(Bool32),
    null_descriptor: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceRobustness2PropertiesKHR = extern struct {
    s_type: StructureType = .physical_device_robustness2properties_khr,
    p_next: ?*anyopaque = null,
    robust_storage_buffer_access_size_alignment: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    robust_uniform_buffer_access_size_alignment: DeviceSize = @import("std").mem.zeroes(DeviceSize),
};
pub const PhysicalDevicePresentModeFifoLatestReadyFeaturesKHR = extern struct {
    s_type: StructureType = .physical_device_present_mode_fifo_latest_ready_features_khr,
    p_next: ?*anyopaque = null,
    present_mode_fifo_latest_ready: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const DebugReportCallbackCreateInfoEXT = extern struct {
    s_type: StructureType = .debug_report_callback_create_info_ext,
    p_next: ?*const anyopaque = null,
    flags: DebugReportFlagsEXT = @import("std").mem.zeroes(DebugReportFlagsEXT),
    pfn_callback: PFN_vkDebugReportCallbackEXT = @import("std").mem.zeroes(PFN_vkDebugReportCallbackEXT),
    p_user_data: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
};
pub const PipelineRasterizationStateRasterizationOrderAMD = extern struct {
    s_type: StructureType = .pipeline_rasterization_state_rasterization_order_amd,
    p_next: ?*const anyopaque = null,
    rasterization_order: RasterizationOrderAMD = @import("std").mem.zeroes(RasterizationOrderAMD),
};
pub const DebugMarkerObjectNameInfoEXT = extern struct {
    s_type: StructureType = .debug_marker_object_name_info_ext,
    p_next: ?*const anyopaque = null,
    object_type: DebugReportObjectTypeEXT = @import("std").mem.zeroes(DebugReportObjectTypeEXT),
    object: u64 = @import("std").mem.zeroes(u64),
    p_object_name: [*c]const u8 = @import("std").mem.zeroes([*c]const u8),
};
pub const DebugMarkerObjectTagInfoEXT = extern struct {
    s_type: StructureType = .debug_marker_object_tag_info_ext,
    p_next: ?*const anyopaque = null,
    object_type: DebugReportObjectTypeEXT = @import("std").mem.zeroes(DebugReportObjectTypeEXT),
    object: u64 = @import("std").mem.zeroes(u64),
    tag_name: u64 = @import("std").mem.zeroes(u64),
    tag_size: usize = @import("std").mem.zeroes(usize),
    p_tag: ?*const anyopaque = @import("std").mem.zeroes(?*const anyopaque),
};
pub const DebugMarkerMarkerInfoEXT = extern struct {
    s_type: StructureType = .debug_marker_marker_info_ext,
    p_next: ?*const anyopaque = null,
    p_marker_name: [*c]const u8 = @import("std").mem.zeroes([*c]const u8),
    color: [4]f32 = @import("std").mem.zeroes([4]f32),
};
pub const DedicatedAllocationImageCreateInfoNV = extern struct {
    s_type: StructureType = .dedicated_allocation_image_create_info_nv,
    p_next: ?*const anyopaque = null,
    dedicated_allocation: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const DedicatedAllocationBufferCreateInfoNV = extern struct {
    s_type: StructureType = .dedicated_allocation_buffer_create_info_nv,
    p_next: ?*const anyopaque = null,
    dedicated_allocation: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const DedicatedAllocationMemoryAllocateInfoNV = extern struct {
    s_type: StructureType = .dedicated_allocation_memory_allocate_info_nv,
    p_next: ?*const anyopaque = null,
    image: Image = @import("std").mem.zeroes(Image),
    buffer: Buffer = @import("std").mem.zeroes(Buffer),
};
pub const PhysicalDeviceTransformFeedbackFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_transform_feedback_features_ext,
    p_next: ?*anyopaque = null,
    transform_feedback: Bool32 = @import("std").mem.zeroes(Bool32),
    geometry_streams: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceTransformFeedbackPropertiesEXT = extern struct {
    s_type: StructureType = .physical_device_transform_feedback_properties_ext,
    p_next: ?*anyopaque = null,
    max_transform_feedback_streams: u32 = @import("std").mem.zeroes(u32),
    max_transform_feedback_buffers: u32 = @import("std").mem.zeroes(u32),
    max_transform_feedback_buffer_size: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    max_transform_feedback_stream_data_size: u32 = @import("std").mem.zeroes(u32),
    max_transform_feedback_buffer_data_size: u32 = @import("std").mem.zeroes(u32),
    max_transform_feedback_buffer_data_stride: u32 = @import("std").mem.zeroes(u32),
    transform_feedback_queries: Bool32 = @import("std").mem.zeroes(Bool32),
    transform_feedback_streams_lines_triangles: Bool32 = @import("std").mem.zeroes(Bool32),
    transform_feedback_rasterization_stream_select: Bool32 = @import("std").mem.zeroes(Bool32),
    transform_feedback_draw: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PipelineRasterizationStateStreamCreateInfoEXT = extern struct {
    s_type: StructureType = .pipeline_rasterization_state_stream_create_info_ext,
    p_next: ?*const anyopaque = null,
    flags: PipelineRasterizationStateStreamCreateFlagsEXT = @import("std").mem.zeroes(PipelineRasterizationStateStreamCreateFlagsEXT),
    rasterization_stream: u32 = @import("std").mem.zeroes(u32),
};
pub const CuModuleCreateInfoNVX = extern struct {
    s_type: StructureType = .cu_module_create_info_nvx,
    p_next: ?*const anyopaque = null,
    data_size: usize = @import("std").mem.zeroes(usize),
    p_data: ?*const anyopaque = @import("std").mem.zeroes(?*const anyopaque),
};
pub const CuModuleTexturingModeCreateInfoNVX = extern struct {
    s_type: StructureType = .cu_module_texturing_mode_create_info_nvx,
    p_next: ?*const anyopaque = null,
    use64bit_texturing: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const CuFunctionCreateInfoNVX = extern struct {
    s_type: StructureType = .cu_function_create_info_nvx,
    p_next: ?*const anyopaque = null,
    module: CuModuleNVX = @import("std").mem.zeroes(CuModuleNVX),
    p_name: [*c]const u8 = @import("std").mem.zeroes([*c]const u8),
};
pub const CuLaunchInfoNVX = extern struct {
    s_type: StructureType = .cu_launch_info_nvx,
    p_next: ?*const anyopaque = null,
    function: CuFunctionNVX = @import("std").mem.zeroes(CuFunctionNVX),
    grid_dim_x: u32 = @import("std").mem.zeroes(u32),
    grid_dim_y: u32 = @import("std").mem.zeroes(u32),
    grid_dim_z: u32 = @import("std").mem.zeroes(u32),
    block_dim_x: u32 = @import("std").mem.zeroes(u32),
    block_dim_y: u32 = @import("std").mem.zeroes(u32),
    block_dim_z: u32 = @import("std").mem.zeroes(u32),
    shared_mem_bytes: u32 = @import("std").mem.zeroes(u32),
    param_count: usize = @import("std").mem.zeroes(usize),
    p_params: [*c]const ?*const anyopaque = @import("std").mem.zeroes([*c]const ?*const anyopaque),
    extra_count: usize = @import("std").mem.zeroes(usize),
    p_extras: [*c]const ?*const anyopaque = @import("std").mem.zeroes([*c]const ?*const anyopaque),
};
pub const ImageViewHandleInfoNVX = extern struct {
    s_type: StructureType = .image_view_handle_info_nvx,
    p_next: ?*const anyopaque = null,
    image_view: ImageView = @import("std").mem.zeroes(ImageView),
    descriptor_type: DescriptorType = @import("std").mem.zeroes(DescriptorType),
    sampler: Sampler = @import("std").mem.zeroes(Sampler),
};
pub const ImageViewAddressPropertiesNVX = extern struct {
    s_type: StructureType = .image_view_address_properties_nvx,
    p_next: ?*anyopaque = null,
    device_address: DeviceAddress = @import("std").mem.zeroes(DeviceAddress),
    size: DeviceSize = @import("std").mem.zeroes(DeviceSize),
};
pub const TextureLODGatherFormatPropertiesAMD = extern struct {
    s_type: StructureType = .texture_lodgather_format_properties_amd,
    p_next: ?*anyopaque = null,
    supports_texture_gather_lodbias_amd: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const ShaderResourceUsageAMD = extern struct {
    num_used_vgprs: u32 = @import("std").mem.zeroes(u32),
    num_used_sgprs: u32 = @import("std").mem.zeroes(u32),
    lds_size_per_local_work_group: u32 = @import("std").mem.zeroes(u32),
    lds_usage_size_in_bytes: usize = @import("std").mem.zeroes(usize),
    scratch_mem_usage_in_bytes: usize = @import("std").mem.zeroes(usize),
};
pub const ShaderStatisticsInfoAMD = extern struct {
    shader_stage_mask: ShaderStageFlags = @import("std").mem.zeroes(ShaderStageFlags),
    resource_usage: ShaderResourceUsageAMD = @import("std").mem.zeroes(ShaderResourceUsageAMD),
    num_physical_vgprs: u32 = @import("std").mem.zeroes(u32),
    num_physical_sgprs: u32 = @import("std").mem.zeroes(u32),
    num_available_vgprs: u32 = @import("std").mem.zeroes(u32),
    num_available_sgprs: u32 = @import("std").mem.zeroes(u32),
    compute_work_group_size: [3]u32 = @import("std").mem.zeroes([3]u32),
};
pub const PhysicalDeviceCornerSampledImageFeaturesNV = extern struct {
    s_type: StructureType = .physical_device_corner_sampled_image_features_nv,
    p_next: ?*anyopaque = null,
    corner_sampled_image: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const ExternalImageFormatPropertiesNV = extern struct {
    image_format_properties: ImageFormatProperties = @import("std").mem.zeroes(ImageFormatProperties),
    external_memory_features: ExternalMemoryFeatureFlagsNV = @import("std").mem.zeroes(ExternalMemoryFeatureFlagsNV),
    export_from_imported_handle_types: ExternalMemoryHandleTypeFlagsNV = @import("std").mem.zeroes(ExternalMemoryHandleTypeFlagsNV),
    compatible_handle_types: ExternalMemoryHandleTypeFlagsNV = @import("std").mem.zeroes(ExternalMemoryHandleTypeFlagsNV),
};
pub const ExternalMemoryImageCreateInfoNV = extern struct {
    s_type: StructureType = .external_memory_image_create_info_nv,
    p_next: ?*const anyopaque = null,
    handle_types: ExternalMemoryHandleTypeFlagsNV = @import("std").mem.zeroes(ExternalMemoryHandleTypeFlagsNV),
};
pub const ExportMemoryAllocateInfoNV = extern struct {
    s_type: StructureType = .export_memory_allocate_info_nv,
    p_next: ?*const anyopaque = null,
    handle_types: ExternalMemoryHandleTypeFlagsNV = @import("std").mem.zeroes(ExternalMemoryHandleTypeFlagsNV),
};
pub const ValidationFlagsEXT = extern struct {
    s_type: StructureType = .validation_flags_ext,
    p_next: ?*const anyopaque = null,
    disabled_validation_check_count: u32 = @import("std").mem.zeroes(u32),
    p_disabled_validation_checks: [*c]const ValidationCheckEXT = @import("std").mem.zeroes([*c]const ValidationCheckEXT),
};
pub const ImageViewASTCDecodeModeEXT = extern struct {
    s_type: StructureType = .image_view_astcdecode_mode_ext,
    p_next: ?*const anyopaque = null,
    decode_mode: Format = @import("std").mem.zeroes(Format),
};
pub const PhysicalDeviceASTCDecodeFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_astcdecode_features_ext,
    p_next: ?*anyopaque = null,
    decode_mode_shared_exponent: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const ConditionalRenderingBeginInfoEXT = extern struct {
    s_type: StructureType = .conditional_rendering_begin_info_ext,
    p_next: ?*const anyopaque = null,
    buffer: Buffer = @import("std").mem.zeroes(Buffer),
    offset: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    flags: ConditionalRenderingFlagsEXT = @import("std").mem.zeroes(ConditionalRenderingFlagsEXT),
};
pub const PhysicalDeviceConditionalRenderingFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_conditional_rendering_features_ext,
    p_next: ?*anyopaque = null,
    conditional_rendering: Bool32 = @import("std").mem.zeroes(Bool32),
    inherited_conditional_rendering: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const CommandBufferInheritanceConditionalRenderingInfoEXT = extern struct {
    s_type: StructureType = .command_buffer_inheritance_conditional_rendering_info_ext,
    p_next: ?*const anyopaque = null,
    conditional_rendering_enable: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const ViewportWScalingNV = extern struct {
    xcoeff: f32 = @import("std").mem.zeroes(f32),
    ycoeff: f32 = @import("std").mem.zeroes(f32),
};
pub const PipelineViewportWScalingStateCreateInfoNV = extern struct {
    s_type: StructureType = .pipeline_viewport_wscaling_state_create_info_nv,
    p_next: ?*const anyopaque = null,
    viewport_wscaling_enable: Bool32 = @import("std").mem.zeroes(Bool32),
    viewport_count: u32 = @import("std").mem.zeroes(u32),
    p_viewport_wscalings: [*c]const ViewportWScalingNV = @import("std").mem.zeroes([*c]const ViewportWScalingNV),
};
pub const SurfaceCapabilities2EXT = extern struct {
    s_type: StructureType = .surface_capabilities2ext,
    p_next: ?*anyopaque = null,
    min_image_count: u32 = @import("std").mem.zeroes(u32),
    max_image_count: u32 = @import("std").mem.zeroes(u32),
    current_extent: Extent2D = @import("std").mem.zeroes(Extent2D),
    min_image_extent: Extent2D = @import("std").mem.zeroes(Extent2D),
    max_image_extent: Extent2D = @import("std").mem.zeroes(Extent2D),
    max_image_array_layers: u32 = @import("std").mem.zeroes(u32),
    supported_transforms: SurfaceTransformFlagsKHR = @import("std").mem.zeroes(SurfaceTransformFlagsKHR),
    current_transform: SurfaceTransformFlagBitsKHR = @import("std").mem.zeroes(SurfaceTransformFlagBitsKHR),
    supported_composite_alpha: CompositeAlphaFlagsKHR = @import("std").mem.zeroes(CompositeAlphaFlagsKHR),
    supported_usage_flags: ImageUsageFlags = @import("std").mem.zeroes(ImageUsageFlags),
    supported_surface_counters: SurfaceCounterFlagsEXT = @import("std").mem.zeroes(SurfaceCounterFlagsEXT),
};
pub const DisplayPowerInfoEXT = extern struct {
    s_type: StructureType = .display_power_info_ext,
    p_next: ?*const anyopaque = null,
    power_state: DisplayPowerStateEXT = @import("std").mem.zeroes(DisplayPowerStateEXT),
};
pub const DeviceEventInfoEXT = extern struct {
    s_type: StructureType = .device_event_info_ext,
    p_next: ?*const anyopaque = null,
    device_event: DeviceEventTypeEXT = @import("std").mem.zeroes(DeviceEventTypeEXT),
};
pub const DisplayEventInfoEXT = extern struct {
    s_type: StructureType = .display_event_info_ext,
    p_next: ?*const anyopaque = null,
    display_event: DisplayEventTypeEXT = @import("std").mem.zeroes(DisplayEventTypeEXT),
};
pub const SwapchainCounterCreateInfoEXT = extern struct {
    s_type: StructureType = .swapchain_counter_create_info_ext,
    p_next: ?*const anyopaque = null,
    surface_counters: SurfaceCounterFlagsEXT = @import("std").mem.zeroes(SurfaceCounterFlagsEXT),
};
pub const RefreshCycleDurationGOOGLE = extern struct {
    refresh_duration: u64 = @import("std").mem.zeroes(u64),
};
pub const PastPresentationTimingGOOGLE = extern struct {
    present_id: u32 = @import("std").mem.zeroes(u32),
    desired_present_time: u64 = @import("std").mem.zeroes(u64),
    actual_present_time: u64 = @import("std").mem.zeroes(u64),
    earliest_present_time: u64 = @import("std").mem.zeroes(u64),
    present_margin: u64 = @import("std").mem.zeroes(u64),
};
pub const PresentTimeGOOGLE = extern struct {
    present_id: u32 = @import("std").mem.zeroes(u32),
    desired_present_time: u64 = @import("std").mem.zeroes(u64),
};
pub const PresentTimesInfoGOOGLE = extern struct {
    s_type: StructureType = .present_times_info_google,
    p_next: ?*const anyopaque = null,
    swapchain_count: u32 = @import("std").mem.zeroes(u32),
    p_times: [*c]const PresentTimeGOOGLE = @import("std").mem.zeroes([*c]const PresentTimeGOOGLE),
};
pub const PhysicalDeviceMultiviewPerViewAttributesPropertiesNVX = extern struct {
    s_type: StructureType = .physical_device_multiview_per_view_attributes_properties_nvx,
    p_next: ?*anyopaque = null,
    per_view_position_all_components: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const MultiviewPerViewAttributesInfoNVX = extern struct {
    s_type: StructureType = .multiview_per_view_attributes_info_nvx,
    p_next: ?*const anyopaque = null,
    per_view_attributes: Bool32 = @import("std").mem.zeroes(Bool32),
    per_view_attributes_position_xonly: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const ViewportSwizzleNV = extern struct {
    x: ViewportCoordinateSwizzleNV = @import("std").mem.zeroes(ViewportCoordinateSwizzleNV),
    y: ViewportCoordinateSwizzleNV = @import("std").mem.zeroes(ViewportCoordinateSwizzleNV),
    z: ViewportCoordinateSwizzleNV = @import("std").mem.zeroes(ViewportCoordinateSwizzleNV),
    w: ViewportCoordinateSwizzleNV = @import("std").mem.zeroes(ViewportCoordinateSwizzleNV),
};
pub const PipelineViewportSwizzleStateCreateInfoNV = extern struct {
    s_type: StructureType = .pipeline_viewport_swizzle_state_create_info_nv,
    p_next: ?*const anyopaque = null,
    flags: PipelineViewportSwizzleStateCreateFlagsNV = @import("std").mem.zeroes(PipelineViewportSwizzleStateCreateFlagsNV),
    viewport_count: u32 = @import("std").mem.zeroes(u32),
    p_viewport_swizzles: [*c]const ViewportSwizzleNV = @import("std").mem.zeroes([*c]const ViewportSwizzleNV),
};
pub const PhysicalDeviceDiscardRectanglePropertiesEXT = extern struct {
    s_type: StructureType = .physical_device_discard_rectangle_properties_ext,
    p_next: ?*anyopaque = null,
    max_discard_rectangles: u32 = @import("std").mem.zeroes(u32),
};
pub const PipelineDiscardRectangleStateCreateInfoEXT = extern struct {
    s_type: StructureType = .pipeline_discard_rectangle_state_create_info_ext,
    p_next: ?*const anyopaque = null,
    flags: PipelineDiscardRectangleStateCreateFlagsEXT = @import("std").mem.zeroes(PipelineDiscardRectangleStateCreateFlagsEXT),
    discard_rectangle_mode: DiscardRectangleModeEXT = @import("std").mem.zeroes(DiscardRectangleModeEXT),
    discard_rectangle_count: u32 = @import("std").mem.zeroes(u32),
    p_discard_rectangles: [*c]const Rect2D = @import("std").mem.zeroes([*c]const Rect2D),
};
pub const PhysicalDeviceConservativeRasterizationPropertiesEXT = extern struct {
    s_type: StructureType = .physical_device_conservative_rasterization_properties_ext,
    p_next: ?*anyopaque = null,
    primitive_overestimation_size: f32 = @import("std").mem.zeroes(f32),
    max_extra_primitive_overestimation_size: f32 = @import("std").mem.zeroes(f32),
    extra_primitive_overestimation_size_granularity: f32 = @import("std").mem.zeroes(f32),
    primitive_underestimation: Bool32 = @import("std").mem.zeroes(Bool32),
    conservative_point_and_line_rasterization: Bool32 = @import("std").mem.zeroes(Bool32),
    degenerate_triangles_rasterized: Bool32 = @import("std").mem.zeroes(Bool32),
    degenerate_lines_rasterized: Bool32 = @import("std").mem.zeroes(Bool32),
    fully_covered_fragment_shader_input_variable: Bool32 = @import("std").mem.zeroes(Bool32),
    conservative_rasterization_post_depth_coverage: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PipelineRasterizationConservativeStateCreateInfoEXT = extern struct {
    s_type: StructureType = .pipeline_rasterization_conservative_state_create_info_ext,
    p_next: ?*const anyopaque = null,
    flags: PipelineRasterizationConservativeStateCreateFlagsEXT = @import("std").mem.zeroes(PipelineRasterizationConservativeStateCreateFlagsEXT),
    conservative_rasterization_mode: ConservativeRasterizationModeEXT = @import("std").mem.zeroes(ConservativeRasterizationModeEXT),
    extra_primitive_overestimation_size: f32 = @import("std").mem.zeroes(f32),
};
pub const PhysicalDeviceDepthClipEnableFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_depth_clip_enable_features_ext,
    p_next: ?*anyopaque = null,
    depth_clip_enable: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PipelineRasterizationDepthClipStateCreateInfoEXT = extern struct {
    s_type: StructureType = .pipeline_rasterization_depth_clip_state_create_info_ext,
    p_next: ?*const anyopaque = null,
    flags: PipelineRasterizationDepthClipStateCreateFlagsEXT = @import("std").mem.zeroes(PipelineRasterizationDepthClipStateCreateFlagsEXT),
    depth_clip_enable: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const XYColorEXT = extern struct {
    x: f32 = @import("std").mem.zeroes(f32),
    y: f32 = @import("std").mem.zeroes(f32),
};
pub const HdrMetadataEXT = extern struct {
    s_type: StructureType = .hdr_metadata_ext,
    p_next: ?*const anyopaque = null,
    display_primary_red: XYColorEXT = @import("std").mem.zeroes(XYColorEXT),
    display_primary_green: XYColorEXT = @import("std").mem.zeroes(XYColorEXT),
    display_primary_blue: XYColorEXT = @import("std").mem.zeroes(XYColorEXT),
    white_point: XYColorEXT = @import("std").mem.zeroes(XYColorEXT),
    max_luminance: f32 = @import("std").mem.zeroes(f32),
    min_luminance: f32 = @import("std").mem.zeroes(f32),
    max_content_light_level: f32 = @import("std").mem.zeroes(f32),
    max_frame_average_light_level: f32 = @import("std").mem.zeroes(f32),
};
pub const PhysicalDeviceRelaxedLineRasterizationFeaturesIMG = extern struct {
    s_type: StructureType = .physical_device_relaxed_line_rasterization_features_img,
    p_next: ?*anyopaque = null,
    relaxed_line_rasterization: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const DebugUtilsLabelEXT = extern struct {
    s_type: StructureType = .debug_utils_label_ext,
    p_next: ?*const anyopaque = null,
    p_label_name: [*c]const u8 = @import("std").mem.zeroes([*c]const u8),
    color: [4]f32 = @import("std").mem.zeroes([4]f32),
};
pub const DebugUtilsObjectNameInfoEXT = extern struct {
    s_type: StructureType = .debug_utils_object_name_info_ext,
    p_next: ?*const anyopaque = null,
    object_type: ObjectType = @import("std").mem.zeroes(ObjectType),
    object_handle: u64 = @import("std").mem.zeroes(u64),
    p_object_name: [*c]const u8 = @import("std").mem.zeroes([*c]const u8),
};
pub const DebugUtilsMessengerCallbackDataEXT = extern struct {
    s_type: StructureType = .debug_utils_messenger_callback_data_ext,
    p_next: ?*const anyopaque = null,
    flags: DebugUtilsMessengerCallbackDataFlagsEXT = @import("std").mem.zeroes(DebugUtilsMessengerCallbackDataFlagsEXT),
    p_message_id_name: [*c]const u8 = @import("std").mem.zeroes([*c]const u8),
    message_id_number: i32 = @import("std").mem.zeroes(i32),
    p_message: [*c]const u8 = @import("std").mem.zeroes([*c]const u8),
    queue_label_count: u32 = @import("std").mem.zeroes(u32),
    p_queue_labels: [*c]const DebugUtilsLabelEXT = @import("std").mem.zeroes([*c]const DebugUtilsLabelEXT),
    cmd_buf_label_count: u32 = @import("std").mem.zeroes(u32),
    p_cmd_buf_labels: [*c]const DebugUtilsLabelEXT = @import("std").mem.zeroes([*c]const DebugUtilsLabelEXT),
    object_count: u32 = @import("std").mem.zeroes(u32),
    p_objects: [*c]const DebugUtilsObjectNameInfoEXT = @import("std").mem.zeroes([*c]const DebugUtilsObjectNameInfoEXT),
};
pub const DebugUtilsMessengerCreateInfoEXT = extern struct {
    s_type: StructureType = .debug_utils_messenger_create_info_ext,
    p_next: ?*const anyopaque = null,
    flags: DebugUtilsMessengerCreateFlagsEXT = @import("std").mem.zeroes(DebugUtilsMessengerCreateFlagsEXT),
    message_severity: DebugUtilsMessageSeverityFlagsEXT = @import("std").mem.zeroes(DebugUtilsMessageSeverityFlagsEXT),
    message_type: DebugUtilsMessageTypeFlagsEXT = @import("std").mem.zeroes(DebugUtilsMessageTypeFlagsEXT),
    pfn_user_callback: PFN_vkDebugUtilsMessengerCallbackEXT = @import("std").mem.zeroes(PFN_vkDebugUtilsMessengerCallbackEXT),
    p_user_data: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
};
pub const DebugUtilsObjectTagInfoEXT = extern struct {
    s_type: StructureType = .debug_utils_object_tag_info_ext,
    p_next: ?*const anyopaque = null,
    object_type: ObjectType = @import("std").mem.zeroes(ObjectType),
    object_handle: u64 = @import("std").mem.zeroes(u64),
    tag_name: u64 = @import("std").mem.zeroes(u64),
    tag_size: usize = @import("std").mem.zeroes(usize),
    p_tag: ?*const anyopaque = @import("std").mem.zeroes(?*const anyopaque),
};
pub const AttachmentSampleCountInfoAMD = extern struct {
    s_type: StructureType = .attachment_sample_count_info_amd,
    p_next: ?*const anyopaque = null,
    color_attachment_count: u32 = @import("std").mem.zeroes(u32),
    p_color_attachment_samples: [*c]const SampleCountFlagBits = @import("std").mem.zeroes([*c]const SampleCountFlagBits),
    depth_stencil_attachment_samples: SampleCountFlagBits = @import("std").mem.zeroes(SampleCountFlagBits),
};
pub const SampleLocationEXT = extern struct {
    x: f32 = @import("std").mem.zeroes(f32),
    y: f32 = @import("std").mem.zeroes(f32),
};
pub const SampleLocationsInfoEXT = extern struct {
    s_type: StructureType = .sample_locations_info_ext,
    p_next: ?*const anyopaque = null,
    sample_locations_per_pixel: SampleCountFlagBits = @import("std").mem.zeroes(SampleCountFlagBits),
    sample_location_grid_size: Extent2D = @import("std").mem.zeroes(Extent2D),
    sample_locations_count: u32 = @import("std").mem.zeroes(u32),
    p_sample_locations: [*c]const SampleLocationEXT = @import("std").mem.zeroes([*c]const SampleLocationEXT),
};
pub const AttachmentSampleLocationsEXT = extern struct {
    attachment_index: u32 = @import("std").mem.zeroes(u32),
    sample_locations_info: SampleLocationsInfoEXT = @import("std").mem.zeroes(SampleLocationsInfoEXT),
};
pub const SubpassSampleLocationsEXT = extern struct {
    subpass_index: u32 = @import("std").mem.zeroes(u32),
    sample_locations_info: SampleLocationsInfoEXT = @import("std").mem.zeroes(SampleLocationsInfoEXT),
};
pub const RenderPassSampleLocationsBeginInfoEXT = extern struct {
    s_type: StructureType = .render_pass_sample_locations_begin_info_ext,
    p_next: ?*const anyopaque = null,
    attachment_initial_sample_locations_count: u32 = @import("std").mem.zeroes(u32),
    p_attachment_initial_sample_locations: [*c]const AttachmentSampleLocationsEXT = @import("std").mem.zeroes([*c]const AttachmentSampleLocationsEXT),
    post_subpass_sample_locations_count: u32 = @import("std").mem.zeroes(u32),
    p_post_subpass_sample_locations: [*c]const SubpassSampleLocationsEXT = @import("std").mem.zeroes([*c]const SubpassSampleLocationsEXT),
};
pub const PipelineSampleLocationsStateCreateInfoEXT = extern struct {
    s_type: StructureType = .pipeline_sample_locations_state_create_info_ext,
    p_next: ?*const anyopaque = null,
    sample_locations_enable: Bool32 = @import("std").mem.zeroes(Bool32),
    sample_locations_info: SampleLocationsInfoEXT = @import("std").mem.zeroes(SampleLocationsInfoEXT),
};
pub const PhysicalDeviceSampleLocationsPropertiesEXT = extern struct {
    s_type: StructureType = .physical_device_sample_locations_properties_ext,
    p_next: ?*anyopaque = null,
    sample_location_sample_counts: SampleCountFlags = @import("std").mem.zeroes(SampleCountFlags),
    max_sample_location_grid_size: Extent2D = @import("std").mem.zeroes(Extent2D),
    sample_location_coordinate_range: [2]f32 = @import("std").mem.zeroes([2]f32),
    sample_location_sub_pixel_bits: u32 = @import("std").mem.zeroes(u32),
    variable_sample_locations: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const MultisamplePropertiesEXT = extern struct {
    s_type: StructureType = .multisample_properties_ext,
    p_next: ?*anyopaque = null,
    max_sample_location_grid_size: Extent2D = @import("std").mem.zeroes(Extent2D),
};
pub const PhysicalDeviceBlendOperationAdvancedFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_blend_operation_advanced_features_ext,
    p_next: ?*anyopaque = null,
    advanced_blend_coherent_operations: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceBlendOperationAdvancedPropertiesEXT = extern struct {
    s_type: StructureType = .physical_device_blend_operation_advanced_properties_ext,
    p_next: ?*anyopaque = null,
    advanced_blend_max_color_attachments: u32 = @import("std").mem.zeroes(u32),
    advanced_blend_independent_blend: Bool32 = @import("std").mem.zeroes(Bool32),
    advanced_blend_non_premultiplied_src_color: Bool32 = @import("std").mem.zeroes(Bool32),
    advanced_blend_non_premultiplied_dst_color: Bool32 = @import("std").mem.zeroes(Bool32),
    advanced_blend_correlated_overlap: Bool32 = @import("std").mem.zeroes(Bool32),
    advanced_blend_all_operations: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PipelineColorBlendAdvancedStateCreateInfoEXT = extern struct {
    s_type: StructureType = .pipeline_color_blend_advanced_state_create_info_ext,
    p_next: ?*const anyopaque = null,
    src_premultiplied: Bool32 = @import("std").mem.zeroes(Bool32),
    dst_premultiplied: Bool32 = @import("std").mem.zeroes(Bool32),
    blend_overlap: BlendOverlapEXT = @import("std").mem.zeroes(BlendOverlapEXT),
};
pub const PipelineCoverageToColorStateCreateInfoNV = extern struct {
    s_type: StructureType = .pipeline_coverage_to_color_state_create_info_nv,
    p_next: ?*const anyopaque = null,
    flags: PipelineCoverageToColorStateCreateFlagsNV = @import("std").mem.zeroes(PipelineCoverageToColorStateCreateFlagsNV),
    coverage_to_color_enable: Bool32 = @import("std").mem.zeroes(Bool32),
    coverage_to_color_location: u32 = @import("std").mem.zeroes(u32),
};
pub const PipelineCoverageModulationStateCreateInfoNV = extern struct {
    s_type: StructureType = .pipeline_coverage_modulation_state_create_info_nv,
    p_next: ?*const anyopaque = null,
    flags: PipelineCoverageModulationStateCreateFlagsNV = @import("std").mem.zeroes(PipelineCoverageModulationStateCreateFlagsNV),
    coverage_modulation_mode: CoverageModulationModeNV = @import("std").mem.zeroes(CoverageModulationModeNV),
    coverage_modulation_table_enable: Bool32 = @import("std").mem.zeroes(Bool32),
    coverage_modulation_table_count: u32 = @import("std").mem.zeroes(u32),
    p_coverage_modulation_table: [*c]const f32 = @import("std").mem.zeroes([*c]const f32),
};
pub const PhysicalDeviceShaderSMBuiltinsPropertiesNV = extern struct {
    s_type: StructureType = .physical_device_shader_smbuiltins_properties_nv,
    p_next: ?*anyopaque = null,
    shader_smcount: u32 = @import("std").mem.zeroes(u32),
    shader_warps_per_sm: u32 = @import("std").mem.zeroes(u32),
};
pub const PhysicalDeviceShaderSMBuiltinsFeaturesNV = extern struct {
    s_type: StructureType = .physical_device_shader_smbuiltins_features_nv,
    p_next: ?*anyopaque = null,
    shader_smbuiltins: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const DrmFormatModifierPropertiesEXT = extern struct {
    drm_format_modifier: u64 = @import("std").mem.zeroes(u64),
    drm_format_modifier_plane_count: u32 = @import("std").mem.zeroes(u32),
    drm_format_modifier_tiling_features: FormatFeatureFlags = @import("std").mem.zeroes(FormatFeatureFlags),
};
pub const DrmFormatModifierPropertiesListEXT = extern struct {
    s_type: StructureType = .drm_format_modifier_properties_list_ext,
    p_next: ?*anyopaque = null,
    drm_format_modifier_count: u32 = @import("std").mem.zeroes(u32),
    p_drm_format_modifier_properties: [*c]DrmFormatModifierPropertiesEXT = @import("std").mem.zeroes([*c]DrmFormatModifierPropertiesEXT),
};
pub const PhysicalDeviceImageDrmFormatModifierInfoEXT = extern struct {
    s_type: StructureType = .physical_device_image_drm_format_modifier_info_ext,
    p_next: ?*const anyopaque = null,
    drm_format_modifier: u64 = @import("std").mem.zeroes(u64),
    sharing_mode: SharingMode = @import("std").mem.zeroes(SharingMode),
    queue_family_index_count: u32 = @import("std").mem.zeroes(u32),
    p_queue_family_indices: [*c]const u32 = @import("std").mem.zeroes([*c]const u32),
};
pub const ImageDrmFormatModifierListCreateInfoEXT = extern struct {
    s_type: StructureType = .image_drm_format_modifier_list_create_info_ext,
    p_next: ?*const anyopaque = null,
    drm_format_modifier_count: u32 = @import("std").mem.zeroes(u32),
    p_drm_format_modifiers: [*c]const u64 = @import("std").mem.zeroes([*c]const u64),
};
pub const ImageDrmFormatModifierExplicitCreateInfoEXT = extern struct {
    s_type: StructureType = .image_drm_format_modifier_explicit_create_info_ext,
    p_next: ?*const anyopaque = null,
    drm_format_modifier: u64 = @import("std").mem.zeroes(u64),
    drm_format_modifier_plane_count: u32 = @import("std").mem.zeroes(u32),
    p_plane_layouts: [*c]const SubresourceLayout = @import("std").mem.zeroes([*c]const SubresourceLayout),
};
pub const ImageDrmFormatModifierPropertiesEXT = extern struct {
    s_type: StructureType = .image_drm_format_modifier_properties_ext,
    p_next: ?*anyopaque = null,
    drm_format_modifier: u64 = @import("std").mem.zeroes(u64),
};
pub const DrmFormatModifierProperties2EXT = extern struct {
    drm_format_modifier: u64 = @import("std").mem.zeroes(u64),
    drm_format_modifier_plane_count: u32 = @import("std").mem.zeroes(u32),
    drm_format_modifier_tiling_features: FormatFeatureFlags2 = @import("std").mem.zeroes(FormatFeatureFlags2),
};
pub const DrmFormatModifierPropertiesList2EXT = extern struct {
    s_type: StructureType = .drm_format_modifier_properties_list2ext,
    p_next: ?*anyopaque = null,
    drm_format_modifier_count: u32 = @import("std").mem.zeroes(u32),
    p_drm_format_modifier_properties: [*c]DrmFormatModifierProperties2EXT = @import("std").mem.zeroes([*c]DrmFormatModifierProperties2EXT),
};
pub const ValidationCacheCreateInfoEXT = extern struct {
    s_type: StructureType = .validation_cache_create_info_ext,
    p_next: ?*const anyopaque = null,
    flags: ValidationCacheCreateFlagsEXT = @import("std").mem.zeroes(ValidationCacheCreateFlagsEXT),
    initial_data_size: usize = @import("std").mem.zeroes(usize),
    p_initial_data: ?*const anyopaque = @import("std").mem.zeroes(?*const anyopaque),
};
pub const ShaderModuleValidationCacheCreateInfoEXT = extern struct {
    s_type: StructureType = .shader_module_validation_cache_create_info_ext,
    p_next: ?*const anyopaque = null,
    validation_cache: ValidationCacheEXT = @import("std").mem.zeroes(ValidationCacheEXT),
};
pub const ShadingRatePaletteNV = extern struct {
    shading_rate_palette_entry_count: u32 = @import("std").mem.zeroes(u32),
    p_shading_rate_palette_entries: [*c]const ShadingRatePaletteEntryNV = @import("std").mem.zeroes([*c]const ShadingRatePaletteEntryNV),
};
pub const PipelineViewportShadingRateImageStateCreateInfoNV = extern struct {
    s_type: StructureType = .pipeline_viewport_shading_rate_image_state_create_info_nv,
    p_next: ?*const anyopaque = null,
    shading_rate_image_enable: Bool32 = @import("std").mem.zeroes(Bool32),
    viewport_count: u32 = @import("std").mem.zeroes(u32),
    p_shading_rate_palettes: [*c]const ShadingRatePaletteNV = @import("std").mem.zeroes([*c]const ShadingRatePaletteNV),
};
pub const PhysicalDeviceShadingRateImageFeaturesNV = extern struct {
    s_type: StructureType = .physical_device_shading_rate_image_features_nv,
    p_next: ?*anyopaque = null,
    shading_rate_image: Bool32 = @import("std").mem.zeroes(Bool32),
    shading_rate_coarse_sample_order: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceShadingRateImagePropertiesNV = extern struct {
    s_type: StructureType = .physical_device_shading_rate_image_properties_nv,
    p_next: ?*anyopaque = null,
    shading_rate_texel_size: Extent2D = @import("std").mem.zeroes(Extent2D),
    shading_rate_palette_size: u32 = @import("std").mem.zeroes(u32),
    shading_rate_max_coarse_samples: u32 = @import("std").mem.zeroes(u32),
};
pub const CoarseSampleLocationNV = extern struct {
    pixel_x: u32 = @import("std").mem.zeroes(u32),
    pixel_y: u32 = @import("std").mem.zeroes(u32),
    sample: u32 = @import("std").mem.zeroes(u32),
};
pub const CoarseSampleOrderCustomNV = extern struct {
    shading_rate: ShadingRatePaletteEntryNV = @import("std").mem.zeroes(ShadingRatePaletteEntryNV),
    sample_count: u32 = @import("std").mem.zeroes(u32),
    sample_location_count: u32 = @import("std").mem.zeroes(u32),
    p_sample_locations: [*c]const CoarseSampleLocationNV = @import("std").mem.zeroes([*c]const CoarseSampleLocationNV),
};
pub const PipelineViewportCoarseSampleOrderStateCreateInfoNV = extern struct {
    s_type: StructureType = .pipeline_viewport_coarse_sample_order_state_create_info_nv,
    p_next: ?*const anyopaque = null,
    sample_order_type: CoarseSampleOrderTypeNV = @import("std").mem.zeroes(CoarseSampleOrderTypeNV),
    custom_sample_order_count: u32 = @import("std").mem.zeroes(u32),
    p_custom_sample_orders: [*c]const CoarseSampleOrderCustomNV = @import("std").mem.zeroes([*c]const CoarseSampleOrderCustomNV),
};
pub const RayTracingShaderGroupCreateInfoNV = extern struct {
    s_type: StructureType = .ray_tracing_shader_group_create_info_nv,
    p_next: ?*const anyopaque = null,
    type: RayTracingShaderGroupTypeKHR = @import("std").mem.zeroes(RayTracingShaderGroupTypeKHR),
    general_shader: u32 = @import("std").mem.zeroes(u32),
    closest_hit_shader: u32 = @import("std").mem.zeroes(u32),
    any_hit_shader: u32 = @import("std").mem.zeroes(u32),
    intersection_shader: u32 = @import("std").mem.zeroes(u32),
};
pub const RayTracingPipelineCreateInfoNV = extern struct {
    s_type: StructureType = .ray_tracing_pipeline_create_info_nv,
    p_next: ?*const anyopaque = null,
    flags: PipelineCreateFlags = @import("std").mem.zeroes(PipelineCreateFlags),
    stage_count: u32 = @import("std").mem.zeroes(u32),
    p_stages: [*c]const PipelineShaderStageCreateInfo = @import("std").mem.zeroes([*c]const PipelineShaderStageCreateInfo),
    group_count: u32 = @import("std").mem.zeroes(u32),
    p_groups: [*c]const RayTracingShaderGroupCreateInfoNV = @import("std").mem.zeroes([*c]const RayTracingShaderGroupCreateInfoNV),
    max_recursion_depth: u32 = @import("std").mem.zeroes(u32),
    layout: PipelineLayout = @import("std").mem.zeroes(PipelineLayout),
    base_pipeline_handle: Pipeline = @import("std").mem.zeroes(Pipeline),
    base_pipeline_index: i32 = @import("std").mem.zeroes(i32),
};
pub const GeometryTrianglesNV = extern struct {
    s_type: StructureType = .geometry_triangles_nv,
    p_next: ?*const anyopaque = null,
    vertex_data: Buffer = @import("std").mem.zeroes(Buffer),
    vertex_offset: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    vertex_count: u32 = @import("std").mem.zeroes(u32),
    vertex_stride: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    vertex_format: Format = @import("std").mem.zeroes(Format),
    index_data: Buffer = @import("std").mem.zeroes(Buffer),
    index_offset: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    index_count: u32 = @import("std").mem.zeroes(u32),
    index_type: IndexType = @import("std").mem.zeroes(IndexType),
    transform_data: Buffer = @import("std").mem.zeroes(Buffer),
    transform_offset: DeviceSize = @import("std").mem.zeroes(DeviceSize),
};
pub const GeometryAABBNV = extern struct {
    s_type: StructureType = .geometry_aabbnv,
    p_next: ?*const anyopaque = null,
    aabb_data: Buffer = @import("std").mem.zeroes(Buffer),
    num_aabbs: u32 = @import("std").mem.zeroes(u32),
    stride: u32 = @import("std").mem.zeroes(u32),
    offset: DeviceSize = @import("std").mem.zeroes(DeviceSize),
};
pub const GeometryDataNV = extern struct {
    triangles: GeometryTrianglesNV = @import("std").mem.zeroes(GeometryTrianglesNV),
    aabbs: GeometryAABBNV = @import("std").mem.zeroes(GeometryAABBNV),
};
pub const GeometryNV = extern struct {
    s_type: StructureType = .geometry_nv,
    p_next: ?*const anyopaque = null,
    geometry_type: GeometryTypeKHR = @import("std").mem.zeroes(GeometryTypeKHR),
    geometry: GeometryDataNV = @import("std").mem.zeroes(GeometryDataNV),
    flags: GeometryFlagsKHR = @import("std").mem.zeroes(GeometryFlagsKHR),
};
pub const AccelerationStructureInfoNV = extern struct {
    s_type: StructureType = .acceleration_structure_info_nv,
    p_next: ?*const anyopaque = null,
    type: AccelerationStructureTypeNV = @import("std").mem.zeroes(AccelerationStructureTypeNV),
    flags: BuildAccelerationStructureFlagsNV = @import("std").mem.zeroes(BuildAccelerationStructureFlagsNV),
    instance_count: u32 = @import("std").mem.zeroes(u32),
    geometry_count: u32 = @import("std").mem.zeroes(u32),
    p_geometries: [*c]const GeometryNV = @import("std").mem.zeroes([*c]const GeometryNV),
};
pub const AccelerationStructureCreateInfoNV = extern struct {
    s_type: StructureType = .acceleration_structure_create_info_nv,
    p_next: ?*const anyopaque = null,
    compacted_size: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    info: AccelerationStructureInfoNV = @import("std").mem.zeroes(AccelerationStructureInfoNV),
};
pub const BindAccelerationStructureMemoryInfoNV = extern struct {
    s_type: StructureType = .bind_acceleration_structure_memory_info_nv,
    p_next: ?*const anyopaque = null,
    acceleration_structure: AccelerationStructureNV = @import("std").mem.zeroes(AccelerationStructureNV),
    memory: DeviceMemory = @import("std").mem.zeroes(DeviceMemory),
    memory_offset: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    device_index_count: u32 = @import("std").mem.zeroes(u32),
    p_device_indices: [*c]const u32 = @import("std").mem.zeroes([*c]const u32),
};
pub const WriteDescriptorSetAccelerationStructureNV = extern struct {
    s_type: StructureType = .write_descriptor_set_acceleration_structure_nv,
    p_next: ?*const anyopaque = null,
    acceleration_structure_count: u32 = @import("std").mem.zeroes(u32),
    p_acceleration_structures: [*c]const AccelerationStructureNV = @import("std").mem.zeroes([*c]const AccelerationStructureNV),
};
pub const AccelerationStructureMemoryRequirementsInfoNV = extern struct {
    s_type: StructureType = .acceleration_structure_memory_requirements_info_nv,
    p_next: ?*const anyopaque = null,
    type: AccelerationStructureMemoryRequirementsTypeNV = @import("std").mem.zeroes(AccelerationStructureMemoryRequirementsTypeNV),
    acceleration_structure: AccelerationStructureNV = @import("std").mem.zeroes(AccelerationStructureNV),
};
pub const PhysicalDeviceRayTracingPropertiesNV = extern struct {
    s_type: StructureType = .physical_device_ray_tracing_properties_nv,
    p_next: ?*anyopaque = null,
    shader_group_handle_size: u32 = @import("std").mem.zeroes(u32),
    max_recursion_depth: u32 = @import("std").mem.zeroes(u32),
    max_shader_group_stride: u32 = @import("std").mem.zeroes(u32),
    shader_group_base_alignment: u32 = @import("std").mem.zeroes(u32),
    max_geometry_count: u64 = @import("std").mem.zeroes(u64),
    max_instance_count: u64 = @import("std").mem.zeroes(u64),
    max_triangle_count: u64 = @import("std").mem.zeroes(u64),
    max_descriptor_set_acceleration_structures: u32 = @import("std").mem.zeroes(u32),
};
pub const TransformMatrixKHR = extern struct {
    matrix: [3][4]f32 = @import("std").mem.zeroes([3][4]f32),
};
pub const AabbPositionsKHR = extern struct {
    min_x: f32 = @import("std").mem.zeroes(f32),
    min_y: f32 = @import("std").mem.zeroes(f32),
    min_z: f32 = @import("std").mem.zeroes(f32),
    max_x: f32 = @import("std").mem.zeroes(f32),
    max_y: f32 = @import("std").mem.zeroes(f32),
    max_z: f32 = @import("std").mem.zeroes(f32),
};
pub const PhysicalDeviceRepresentativeFragmentTestFeaturesNV = extern struct {
    s_type: StructureType = .physical_device_representative_fragment_test_features_nv,
    p_next: ?*anyopaque = null,
    representative_fragment_test: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PipelineRepresentativeFragmentTestStateCreateInfoNV = extern struct {
    s_type: StructureType = .pipeline_representative_fragment_test_state_create_info_nv,
    p_next: ?*const anyopaque = null,
    representative_fragment_test_enable: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceImageViewImageFormatInfoEXT = extern struct {
    s_type: StructureType = .physical_device_image_view_image_format_info_ext,
    p_next: ?*anyopaque = null,
    image_view_type: ImageViewType = @import("std").mem.zeroes(ImageViewType),
};
pub const FilterCubicImageViewImageFormatPropertiesEXT = extern struct {
    s_type: StructureType = .filter_cubic_image_view_image_format_properties_ext,
    p_next: ?*anyopaque = null,
    filter_cubic: Bool32 = @import("std").mem.zeroes(Bool32),
    filter_cubic_minmax: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const ImportMemoryHostPointerInfoEXT = extern struct {
    s_type: StructureType = .import_memory_host_pointer_info_ext,
    p_next: ?*const anyopaque = null,
    handle_type: ExternalMemoryHandleTypeFlagBits = @import("std").mem.zeroes(ExternalMemoryHandleTypeFlagBits),
    p_host_pointer: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
};
pub const MemoryHostPointerPropertiesEXT = extern struct {
    s_type: StructureType = .memory_host_pointer_properties_ext,
    p_next: ?*anyopaque = null,
    memory_type_bits: u32 = @import("std").mem.zeroes(u32),
};
pub const PhysicalDeviceExternalMemoryHostPropertiesEXT = extern struct {
    s_type: StructureType = .physical_device_external_memory_host_properties_ext,
    p_next: ?*anyopaque = null,
    min_imported_host_pointer_alignment: DeviceSize = @import("std").mem.zeroes(DeviceSize),
};
pub const PipelineCompilerControlCreateInfoAMD = extern struct {
    s_type: StructureType = .pipeline_compiler_control_create_info_amd,
    p_next: ?*const anyopaque = null,
    compiler_control_flags: PipelineCompilerControlFlagsAMD = @import("std").mem.zeroes(PipelineCompilerControlFlagsAMD),
};
pub const PhysicalDeviceShaderCorePropertiesAMD = extern struct {
    s_type: StructureType = .physical_device_shader_core_properties_amd,
    p_next: ?*anyopaque = null,
    shader_engine_count: u32 = @import("std").mem.zeroes(u32),
    shader_arrays_per_engine_count: u32 = @import("std").mem.zeroes(u32),
    compute_units_per_shader_array: u32 = @import("std").mem.zeroes(u32),
    simd_per_compute_unit: u32 = @import("std").mem.zeroes(u32),
    wavefronts_per_simd: u32 = @import("std").mem.zeroes(u32),
    wavefront_size: u32 = @import("std").mem.zeroes(u32),
    sgprs_per_simd: u32 = @import("std").mem.zeroes(u32),
    min_sgpr_allocation: u32 = @import("std").mem.zeroes(u32),
    max_sgpr_allocation: u32 = @import("std").mem.zeroes(u32),
    sgpr_allocation_granularity: u32 = @import("std").mem.zeroes(u32),
    vgprs_per_simd: u32 = @import("std").mem.zeroes(u32),
    min_vgpr_allocation: u32 = @import("std").mem.zeroes(u32),
    max_vgpr_allocation: u32 = @import("std").mem.zeroes(u32),
    vgpr_allocation_granularity: u32 = @import("std").mem.zeroes(u32),
};
pub const DeviceMemoryOverallocationCreateInfoAMD = extern struct {
    s_type: StructureType = .device_memory_overallocation_create_info_amd,
    p_next: ?*const anyopaque = null,
    overallocation_behavior: MemoryOverallocationBehaviorAMD = @import("std").mem.zeroes(MemoryOverallocationBehaviorAMD),
};
pub const PhysicalDeviceVertexAttributeDivisorPropertiesEXT = extern struct {
    s_type: StructureType = .physical_device_vertex_attribute_divisor_properties_ext,
    p_next: ?*anyopaque = null,
    max_vertex_attrib_divisor: u32 = @import("std").mem.zeroes(u32),
};
pub const PhysicalDeviceMeshShaderFeaturesNV = extern struct {
    s_type: StructureType = .physical_device_mesh_shader_features_nv,
    p_next: ?*anyopaque = null,
    task_shader: Bool32 = @import("std").mem.zeroes(Bool32),
    mesh_shader: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceMeshShaderPropertiesNV = extern struct {
    s_type: StructureType = .physical_device_mesh_shader_properties_nv,
    p_next: ?*anyopaque = null,
    max_draw_mesh_tasks_count: u32 = @import("std").mem.zeroes(u32),
    max_task_work_group_invocations: u32 = @import("std").mem.zeroes(u32),
    max_task_work_group_size: [3]u32 = @import("std").mem.zeroes([3]u32),
    max_task_total_memory_size: u32 = @import("std").mem.zeroes(u32),
    max_task_output_count: u32 = @import("std").mem.zeroes(u32),
    max_mesh_work_group_invocations: u32 = @import("std").mem.zeroes(u32),
    max_mesh_work_group_size: [3]u32 = @import("std").mem.zeroes([3]u32),
    max_mesh_total_memory_size: u32 = @import("std").mem.zeroes(u32),
    max_mesh_output_vertices: u32 = @import("std").mem.zeroes(u32),
    max_mesh_output_primitives: u32 = @import("std").mem.zeroes(u32),
    max_mesh_multiview_view_count: u32 = @import("std").mem.zeroes(u32),
    mesh_output_per_vertex_granularity: u32 = @import("std").mem.zeroes(u32),
    mesh_output_per_primitive_granularity: u32 = @import("std").mem.zeroes(u32),
};
pub const DrawMeshTasksIndirectCommandNV = extern struct {
    task_count: u32 = @import("std").mem.zeroes(u32),
    first_task: u32 = @import("std").mem.zeroes(u32),
};
pub const PhysicalDeviceShaderImageFootprintFeaturesNV = extern struct {
    s_type: StructureType = .physical_device_shader_image_footprint_features_nv,
    p_next: ?*anyopaque = null,
    image_footprint: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PipelineViewportExclusiveScissorStateCreateInfoNV = extern struct {
    s_type: StructureType = .pipeline_viewport_exclusive_scissor_state_create_info_nv,
    p_next: ?*const anyopaque = null,
    exclusive_scissor_count: u32 = @import("std").mem.zeroes(u32),
    p_exclusive_scissors: [*c]const Rect2D = @import("std").mem.zeroes([*c]const Rect2D),
};
pub const PhysicalDeviceExclusiveScissorFeaturesNV = extern struct {
    s_type: StructureType = .physical_device_exclusive_scissor_features_nv,
    p_next: ?*anyopaque = null,
    exclusive_scissor: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const QueueFamilyCheckpointPropertiesNV = extern struct {
    s_type: StructureType = .queue_family_checkpoint_properties_nv,
    p_next: ?*anyopaque = null,
    checkpoint_execution_stage_mask: PipelineStageFlags = @import("std").mem.zeroes(PipelineStageFlags),
};
pub const CheckpointDataNV = extern struct {
    s_type: StructureType = .checkpoint_data_nv,
    p_next: ?*anyopaque = null,
    stage: PipelineStageFlagBits = @import("std").mem.zeroes(PipelineStageFlagBits),
    p_checkpoint_marker: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
};
pub const QueueFamilyCheckpointProperties2NV = extern struct {
    s_type: StructureType = .queue_family_checkpoint_properties2nv,
    p_next: ?*anyopaque = null,
    checkpoint_execution_stage_mask: PipelineStageFlags2 = @import("std").mem.zeroes(PipelineStageFlags2),
};
pub const CheckpointData2NV = extern struct {
    s_type: StructureType = .checkpoint_data2nv,
    p_next: ?*anyopaque = null,
    stage: PipelineStageFlags2 = @import("std").mem.zeroes(PipelineStageFlags2),
    p_checkpoint_marker: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
};
pub const PhysicalDeviceShaderIntegerFunctions2FeaturesINTEL = extern struct {
    s_type: StructureType = .physical_device_shader_integer_functions2features_intel,
    p_next: ?*anyopaque = null,
    shader_integer_functions2: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PerformanceValueINTEL = extern struct {
    type: PerformanceValueTypeINTEL = @import("std").mem.zeroes(PerformanceValueTypeINTEL),
    data: PerformanceValueDataINTEL = @import("std").mem.zeroes(PerformanceValueDataINTEL),
};
pub const InitializePerformanceApiInfoINTEL = extern struct {
    s_type: StructureType = .initialize_performance_api_info_intel,
    p_next: ?*const anyopaque = null,
    p_user_data: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
};
pub const QueryPoolPerformanceQueryCreateInfoINTEL = extern struct {
    s_type: StructureType = .query_pool_performance_query_create_info_intel,
    p_next: ?*const anyopaque = null,
    performance_counters_sampling: QueryPoolSamplingModeINTEL = @import("std").mem.zeroes(QueryPoolSamplingModeINTEL),
};
pub const PerformanceMarkerInfoINTEL = extern struct {
    s_type: StructureType = .performance_marker_info_intel,
    p_next: ?*const anyopaque = null,
    marker: u64 = @import("std").mem.zeroes(u64),
};
pub const PerformanceStreamMarkerInfoINTEL = extern struct {
    s_type: StructureType = .performance_stream_marker_info_intel,
    p_next: ?*const anyopaque = null,
    marker: u32 = @import("std").mem.zeroes(u32),
};
pub const PerformanceOverrideInfoINTEL = extern struct {
    s_type: StructureType = .performance_override_info_intel,
    p_next: ?*const anyopaque = null,
    type: PerformanceOverrideTypeINTEL = @import("std").mem.zeroes(PerformanceOverrideTypeINTEL),
    enable: Bool32 = @import("std").mem.zeroes(Bool32),
    parameter: u64 = @import("std").mem.zeroes(u64),
};
pub const PerformanceConfigurationAcquireInfoINTEL = extern struct {
    s_type: StructureType = .performance_configuration_acquire_info_intel,
    p_next: ?*const anyopaque = null,
    type: PerformanceConfigurationTypeINTEL = @import("std").mem.zeroes(PerformanceConfigurationTypeINTEL),
};
pub const PhysicalDevicePCIBusInfoPropertiesEXT = extern struct {
    s_type: StructureType = .physical_device_pcibus_info_properties_ext,
    p_next: ?*anyopaque = null,
    pci_domain: u32 = @import("std").mem.zeroes(u32),
    pci_bus: u32 = @import("std").mem.zeroes(u32),
    pci_device: u32 = @import("std").mem.zeroes(u32),
    pci_function: u32 = @import("std").mem.zeroes(u32),
};
pub const DisplayNativeHdrSurfaceCapabilitiesAMD = extern struct {
    s_type: StructureType = .display_native_hdr_surface_capabilities_amd,
    p_next: ?*anyopaque = null,
    local_dimming_support: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const SwapchainDisplayNativeHdrCreateInfoAMD = extern struct {
    s_type: StructureType = .swapchain_display_native_hdr_create_info_amd,
    p_next: ?*const anyopaque = null,
    local_dimming_enable: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceFragmentDensityMapFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_fragment_density_map_features_ext,
    p_next: ?*anyopaque = null,
    fragment_density_map: Bool32 = @import("std").mem.zeroes(Bool32),
    fragment_density_map_dynamic: Bool32 = @import("std").mem.zeroes(Bool32),
    fragment_density_map_non_subsampled_images: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceFragmentDensityMapPropertiesEXT = extern struct {
    s_type: StructureType = .physical_device_fragment_density_map_properties_ext,
    p_next: ?*anyopaque = null,
    min_fragment_density_texel_size: Extent2D = @import("std").mem.zeroes(Extent2D),
    max_fragment_density_texel_size: Extent2D = @import("std").mem.zeroes(Extent2D),
    fragment_density_invocations: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const RenderPassFragmentDensityMapCreateInfoEXT = extern struct {
    s_type: StructureType = .render_pass_fragment_density_map_create_info_ext,
    p_next: ?*const anyopaque = null,
    fragment_density_map_attachment: AttachmentReference = @import("std").mem.zeroes(AttachmentReference),
};
pub const RenderingFragmentDensityMapAttachmentInfoEXT = extern struct {
    s_type: StructureType = .rendering_fragment_density_map_attachment_info_ext,
    p_next: ?*const anyopaque = null,
    image_view: ImageView = @import("std").mem.zeroes(ImageView),
    image_layout: ImageLayout = @import("std").mem.zeroes(ImageLayout),
};
pub const PhysicalDeviceShaderCoreProperties2AMD = extern struct {
    s_type: StructureType = .physical_device_shader_core_properties2amd,
    p_next: ?*anyopaque = null,
    shader_core_features: ShaderCorePropertiesFlagsAMD = @import("std").mem.zeroes(ShaderCorePropertiesFlagsAMD),
    active_compute_unit_count: u32 = @import("std").mem.zeroes(u32),
};
pub const PhysicalDeviceCoherentMemoryFeaturesAMD = extern struct {
    s_type: StructureType = .physical_device_coherent_memory_features_amd,
    p_next: ?*anyopaque = null,
    device_coherent_memory: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceShaderImageAtomicInt64FeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_shader_image_atomic_int64_features_ext,
    p_next: ?*anyopaque = null,
    shader_image_int64_atomics: Bool32 = @import("std").mem.zeroes(Bool32),
    sparse_image_int64_atomics: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceMemoryBudgetPropertiesEXT = extern struct {
    s_type: StructureType = .physical_device_memory_budget_properties_ext,
    p_next: ?*anyopaque = null,
    heap_budget: [16]DeviceSize = @import("std").mem.zeroes([16]DeviceSize),
    heap_usage: [16]DeviceSize = @import("std").mem.zeroes([16]DeviceSize),
};
pub const PhysicalDeviceMemoryPriorityFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_memory_priority_features_ext,
    p_next: ?*anyopaque = null,
    memory_priority: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const MemoryPriorityAllocateInfoEXT = extern struct {
    s_type: StructureType = .memory_priority_allocate_info_ext,
    p_next: ?*const anyopaque = null,
    priority: f32 = @import("std").mem.zeroes(f32),
};
pub const PhysicalDeviceDedicatedAllocationImageAliasingFeaturesNV = extern struct {
    s_type: StructureType = .physical_device_dedicated_allocation_image_aliasing_features_nv,
    p_next: ?*anyopaque = null,
    dedicated_allocation_image_aliasing: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceBufferDeviceAddressFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_buffer_device_address_features_ext,
    p_next: ?*anyopaque = null,
    buffer_device_address: Bool32 = @import("std").mem.zeroes(Bool32),
    buffer_device_address_capture_replay: Bool32 = @import("std").mem.zeroes(Bool32),
    buffer_device_address_multi_device: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const BufferDeviceAddressCreateInfoEXT = extern struct {
    s_type: StructureType = .buffer_device_address_create_info_ext,
    p_next: ?*const anyopaque = null,
    device_address: DeviceAddress = @import("std").mem.zeroes(DeviceAddress),
};
pub const ValidationFeaturesEXT = extern struct {
    s_type: StructureType = .validation_features_ext,
    p_next: ?*const anyopaque = null,
    enabled_validation_feature_count: u32 = @import("std").mem.zeroes(u32),
    p_enabled_validation_features: [*c]const ValidationFeatureEnableEXT = @import("std").mem.zeroes([*c]const ValidationFeatureEnableEXT),
    disabled_validation_feature_count: u32 = @import("std").mem.zeroes(u32),
    p_disabled_validation_features: [*c]const ValidationFeatureDisableEXT = @import("std").mem.zeroes([*c]const ValidationFeatureDisableEXT),
};
pub const CooperativeMatrixPropertiesNV = extern struct {
    s_type: StructureType = .cooperative_matrix_properties_nv,
    p_next: ?*anyopaque = null,
    msize: u32 = @import("std").mem.zeroes(u32),
    nsize: u32 = @import("std").mem.zeroes(u32),
    ksize: u32 = @import("std").mem.zeroes(u32),
    atype: ComponentTypeNV = @import("std").mem.zeroes(ComponentTypeNV),
    btype: ComponentTypeNV = @import("std").mem.zeroes(ComponentTypeNV),
    ctype: ComponentTypeNV = @import("std").mem.zeroes(ComponentTypeNV),
    dtype: ComponentTypeNV = @import("std").mem.zeroes(ComponentTypeNV),
    scope: ScopeNV = @import("std").mem.zeroes(ScopeNV),
};
pub const PhysicalDeviceCooperativeMatrixFeaturesNV = extern struct {
    s_type: StructureType = .physical_device_cooperative_matrix_features_nv,
    p_next: ?*anyopaque = null,
    cooperative_matrix: Bool32 = @import("std").mem.zeroes(Bool32),
    cooperative_matrix_robust_buffer_access: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceCooperativeMatrixPropertiesNV = extern struct {
    s_type: StructureType = .physical_device_cooperative_matrix_properties_nv,
    p_next: ?*anyopaque = null,
    cooperative_matrix_supported_stages: ShaderStageFlags = @import("std").mem.zeroes(ShaderStageFlags),
};
pub const PhysicalDeviceCoverageReductionModeFeaturesNV = extern struct {
    s_type: StructureType = .physical_device_coverage_reduction_mode_features_nv,
    p_next: ?*anyopaque = null,
    coverage_reduction_mode: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PipelineCoverageReductionStateCreateInfoNV = extern struct {
    s_type: StructureType = .pipeline_coverage_reduction_state_create_info_nv,
    p_next: ?*const anyopaque = null,
    flags: PipelineCoverageReductionStateCreateFlagsNV = @import("std").mem.zeroes(PipelineCoverageReductionStateCreateFlagsNV),
    coverage_reduction_mode: CoverageReductionModeNV = @import("std").mem.zeroes(CoverageReductionModeNV),
};
pub const FramebufferMixedSamplesCombinationNV = extern struct {
    s_type: StructureType = .framebuffer_mixed_samples_combination_nv,
    p_next: ?*anyopaque = null,
    coverage_reduction_mode: CoverageReductionModeNV = @import("std").mem.zeroes(CoverageReductionModeNV),
    rasterization_samples: SampleCountFlagBits = @import("std").mem.zeroes(SampleCountFlagBits),
    depth_stencil_samples: SampleCountFlags = @import("std").mem.zeroes(SampleCountFlags),
    color_samples: SampleCountFlags = @import("std").mem.zeroes(SampleCountFlags),
};
pub const PhysicalDeviceFragmentShaderInterlockFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_fragment_shader_interlock_features_ext,
    p_next: ?*anyopaque = null,
    fragment_shader_sample_interlock: Bool32 = @import("std").mem.zeroes(Bool32),
    fragment_shader_pixel_interlock: Bool32 = @import("std").mem.zeroes(Bool32),
    fragment_shader_shading_rate_interlock: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceYcbcrImageArraysFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_ycbcr_image_arrays_features_ext,
    p_next: ?*anyopaque = null,
    ycbcr_image_arrays: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceProvokingVertexFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_provoking_vertex_features_ext,
    p_next: ?*anyopaque = null,
    provoking_vertex_last: Bool32 = @import("std").mem.zeroes(Bool32),
    transform_feedback_preserves_provoking_vertex: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceProvokingVertexPropertiesEXT = extern struct {
    s_type: StructureType = .physical_device_provoking_vertex_properties_ext,
    p_next: ?*anyopaque = null,
    provoking_vertex_mode_per_pipeline: Bool32 = @import("std").mem.zeroes(Bool32),
    transform_feedback_preserves_triangle_fan_provoking_vertex: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PipelineRasterizationProvokingVertexStateCreateInfoEXT = extern struct {
    s_type: StructureType = .pipeline_rasterization_provoking_vertex_state_create_info_ext,
    p_next: ?*const anyopaque = null,
    provoking_vertex_mode: ProvokingVertexModeEXT = @import("std").mem.zeroes(ProvokingVertexModeEXT),
};
pub const HeadlessSurfaceCreateInfoEXT = extern struct {
    s_type: StructureType = .headless_surface_create_info_ext,
    p_next: ?*const anyopaque = null,
    flags: HeadlessSurfaceCreateFlagsEXT = @import("std").mem.zeroes(HeadlessSurfaceCreateFlagsEXT),
};
pub const PhysicalDeviceShaderAtomicFloatFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_shader_atomic_float_features_ext,
    p_next: ?*anyopaque = null,
    shader_buffer_float32_atomics: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_buffer_float32_atomic_add: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_buffer_float64_atomics: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_buffer_float64_atomic_add: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_shared_float32_atomics: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_shared_float32_atomic_add: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_shared_float64_atomics: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_shared_float64_atomic_add: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_image_float32_atomics: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_image_float32_atomic_add: Bool32 = @import("std").mem.zeroes(Bool32),
    sparse_image_float32_atomics: Bool32 = @import("std").mem.zeroes(Bool32),
    sparse_image_float32_atomic_add: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceExtendedDynamicStateFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_extended_dynamic_state_features_ext,
    p_next: ?*anyopaque = null,
    extended_dynamic_state: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceMapMemoryPlacedFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_map_memory_placed_features_ext,
    p_next: ?*anyopaque = null,
    memory_map_placed: Bool32 = @import("std").mem.zeroes(Bool32),
    memory_map_range_placed: Bool32 = @import("std").mem.zeroes(Bool32),
    memory_unmap_reserve: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceMapMemoryPlacedPropertiesEXT = extern struct {
    s_type: StructureType = .physical_device_map_memory_placed_properties_ext,
    p_next: ?*anyopaque = null,
    min_placed_memory_map_alignment: DeviceSize = @import("std").mem.zeroes(DeviceSize),
};
pub const MemoryMapPlacedInfoEXT = extern struct {
    s_type: StructureType = .memory_map_placed_info_ext,
    p_next: ?*const anyopaque = null,
    p_placed_address: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
};
pub const PhysicalDeviceShaderAtomicFloat2FeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_shader_atomic_float2features_ext,
    p_next: ?*anyopaque = null,
    shader_buffer_float16_atomics: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_buffer_float16_atomic_add: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_buffer_float16_atomic_min_max: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_buffer_float32_atomic_min_max: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_buffer_float64_atomic_min_max: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_shared_float16_atomics: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_shared_float16_atomic_add: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_shared_float16_atomic_min_max: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_shared_float32_atomic_min_max: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_shared_float64_atomic_min_max: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_image_float32_atomic_min_max: Bool32 = @import("std").mem.zeroes(Bool32),
    sparse_image_float32_atomic_min_max: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceDeviceGeneratedCommandsPropertiesNV = extern struct {
    s_type: StructureType = .physical_device_device_generated_commands_properties_nv,
    p_next: ?*anyopaque = null,
    max_graphics_shader_group_count: u32 = @import("std").mem.zeroes(u32),
    max_indirect_sequence_count: u32 = @import("std").mem.zeroes(u32),
    max_indirect_commands_token_count: u32 = @import("std").mem.zeroes(u32),
    max_indirect_commands_stream_count: u32 = @import("std").mem.zeroes(u32),
    max_indirect_commands_token_offset: u32 = @import("std").mem.zeroes(u32),
    max_indirect_commands_stream_stride: u32 = @import("std").mem.zeroes(u32),
    min_sequences_count_buffer_offset_alignment: u32 = @import("std").mem.zeroes(u32),
    min_sequences_index_buffer_offset_alignment: u32 = @import("std").mem.zeroes(u32),
    min_indirect_commands_buffer_offset_alignment: u32 = @import("std").mem.zeroes(u32),
};
pub const PhysicalDeviceDeviceGeneratedCommandsFeaturesNV = extern struct {
    s_type: StructureType = .physical_device_device_generated_commands_features_nv,
    p_next: ?*anyopaque = null,
    device_generated_commands: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const GraphicsShaderGroupCreateInfoNV = extern struct {
    s_type: StructureType = .graphics_shader_group_create_info_nv,
    p_next: ?*const anyopaque = null,
    stage_count: u32 = @import("std").mem.zeroes(u32),
    p_stages: [*c]const PipelineShaderStageCreateInfo = @import("std").mem.zeroes([*c]const PipelineShaderStageCreateInfo),
    p_vertex_input_state: [*c]const PipelineVertexInputStateCreateInfo = @import("std").mem.zeroes([*c]const PipelineVertexInputStateCreateInfo),
    p_tessellation_state: [*c]const PipelineTessellationStateCreateInfo = @import("std").mem.zeroes([*c]const PipelineTessellationStateCreateInfo),
};
pub const GraphicsPipelineShaderGroupsCreateInfoNV = extern struct {
    s_type: StructureType = .graphics_pipeline_shader_groups_create_info_nv,
    p_next: ?*const anyopaque = null,
    group_count: u32 = @import("std").mem.zeroes(u32),
    p_groups: [*c]const GraphicsShaderGroupCreateInfoNV = @import("std").mem.zeroes([*c]const GraphicsShaderGroupCreateInfoNV),
    pipeline_count: u32 = @import("std").mem.zeroes(u32),
    p_pipelines: [*c]const Pipeline = @import("std").mem.zeroes([*c]const Pipeline),
};
pub const BindShaderGroupIndirectCommandNV = extern struct {
    group_index: u32 = @import("std").mem.zeroes(u32),
};
pub const BindIndexBufferIndirectCommandNV = extern struct {
    buffer_address: DeviceAddress = @import("std").mem.zeroes(DeviceAddress),
    size: u32 = @import("std").mem.zeroes(u32),
    index_type: IndexType = @import("std").mem.zeroes(IndexType),
};
pub const BindVertexBufferIndirectCommandNV = extern struct {
    buffer_address: DeviceAddress = @import("std").mem.zeroes(DeviceAddress),
    size: u32 = @import("std").mem.zeroes(u32),
    stride: u32 = @import("std").mem.zeroes(u32),
};
pub const SetStateFlagsIndirectCommandNV = extern struct {
    data: u32 = @import("std").mem.zeroes(u32),
};
pub const IndirectCommandsStreamNV = extern struct {
    buffer: Buffer = @import("std").mem.zeroes(Buffer),
    offset: DeviceSize = @import("std").mem.zeroes(DeviceSize),
};
pub const IndirectCommandsLayoutTokenNV = extern struct {
    s_type: StructureType = .indirect_commands_layout_token_nv,
    p_next: ?*const anyopaque = null,
    token_type: IndirectCommandsTokenTypeNV = @import("std").mem.zeroes(IndirectCommandsTokenTypeNV),
    stream: u32 = @import("std").mem.zeroes(u32),
    offset: u32 = @import("std").mem.zeroes(u32),
    vertex_binding_unit: u32 = @import("std").mem.zeroes(u32),
    vertex_dynamic_stride: Bool32 = @import("std").mem.zeroes(Bool32),
    pushconstant_pipeline_layout: PipelineLayout = @import("std").mem.zeroes(PipelineLayout),
    pushconstant_shader_stage_flags: ShaderStageFlags = @import("std").mem.zeroes(ShaderStageFlags),
    pushconstant_offset: u32 = @import("std").mem.zeroes(u32),
    pushconstant_size: u32 = @import("std").mem.zeroes(u32),
    indirect_state_flags: IndirectStateFlagsNV = @import("std").mem.zeroes(IndirectStateFlagsNV),
    index_type_count: u32 = @import("std").mem.zeroes(u32),
    p_index_types: [*c]const IndexType = @import("std").mem.zeroes([*c]const IndexType),
    p_index_type_values: [*c]const u32 = @import("std").mem.zeroes([*c]const u32),
};
pub const IndirectCommandsLayoutCreateInfoNV = extern struct {
    s_type: StructureType = .indirect_commands_layout_create_info_nv,
    p_next: ?*const anyopaque = null,
    flags: IndirectCommandsLayoutUsageFlagsNV = @import("std").mem.zeroes(IndirectCommandsLayoutUsageFlagsNV),
    pipeline_bind_point: PipelineBindPoint = @import("std").mem.zeroes(PipelineBindPoint),
    token_count: u32 = @import("std").mem.zeroes(u32),
    p_tokens: [*c]const IndirectCommandsLayoutTokenNV = @import("std").mem.zeroes([*c]const IndirectCommandsLayoutTokenNV),
    stream_count: u32 = @import("std").mem.zeroes(u32),
    p_stream_strides: [*c]const u32 = @import("std").mem.zeroes([*c]const u32),
};
pub const GeneratedCommandsInfoNV = extern struct {
    s_type: StructureType = .generated_commands_info_nv,
    p_next: ?*const anyopaque = null,
    pipeline_bind_point: PipelineBindPoint = @import("std").mem.zeroes(PipelineBindPoint),
    pipeline: Pipeline = @import("std").mem.zeroes(Pipeline),
    indirect_commands_layout: IndirectCommandsLayoutNV = @import("std").mem.zeroes(IndirectCommandsLayoutNV),
    stream_count: u32 = @import("std").mem.zeroes(u32),
    p_streams: [*c]const IndirectCommandsStreamNV = @import("std").mem.zeroes([*c]const IndirectCommandsStreamNV),
    sequences_count: u32 = @import("std").mem.zeroes(u32),
    preprocess_buffer: Buffer = @import("std").mem.zeroes(Buffer),
    preprocess_offset: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    preprocess_size: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    sequences_count_buffer: Buffer = @import("std").mem.zeroes(Buffer),
    sequences_count_offset: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    sequences_index_buffer: Buffer = @import("std").mem.zeroes(Buffer),
    sequences_index_offset: DeviceSize = @import("std").mem.zeroes(DeviceSize),
};
pub const GeneratedCommandsMemoryRequirementsInfoNV = extern struct {
    s_type: StructureType = .generated_commands_memory_requirements_info_nv,
    p_next: ?*const anyopaque = null,
    pipeline_bind_point: PipelineBindPoint = @import("std").mem.zeroes(PipelineBindPoint),
    pipeline: Pipeline = @import("std").mem.zeroes(Pipeline),
    indirect_commands_layout: IndirectCommandsLayoutNV = @import("std").mem.zeroes(IndirectCommandsLayoutNV),
    max_sequences_count: u32 = @import("std").mem.zeroes(u32),
};
pub const PhysicalDeviceInheritedViewportScissorFeaturesNV = extern struct {
    s_type: StructureType = .physical_device_inherited_viewport_scissor_features_nv,
    p_next: ?*anyopaque = null,
    inherited_viewport_scissor2_d: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const CommandBufferInheritanceViewportScissorInfoNV = extern struct {
    s_type: StructureType = .command_buffer_inheritance_viewport_scissor_info_nv,
    p_next: ?*const anyopaque = null,
    viewport_scissor2_d: Bool32 = @import("std").mem.zeroes(Bool32),
    viewport_depth_count: u32 = @import("std").mem.zeroes(u32),
    p_viewport_depths: [*c]const Viewport = @import("std").mem.zeroes([*c]const Viewport),
};
pub const PhysicalDeviceTexelBufferAlignmentFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_texel_buffer_alignment_features_ext,
    p_next: ?*anyopaque = null,
    texel_buffer_alignment: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const RenderPassTransformBeginInfoQCOM = extern struct {
    s_type: StructureType = .render_pass_transform_begin_info_qcom,
    p_next: ?*const anyopaque = null,
    transform: SurfaceTransformFlagBitsKHR = @import("std").mem.zeroes(SurfaceTransformFlagBitsKHR),
};
pub const CommandBufferInheritanceRenderPassTransformInfoQCOM = extern struct {
    s_type: StructureType = .command_buffer_inheritance_render_pass_transform_info_qcom,
    p_next: ?*const anyopaque = null,
    transform: SurfaceTransformFlagBitsKHR = @import("std").mem.zeroes(SurfaceTransformFlagBitsKHR),
    render_area: Rect2D = @import("std").mem.zeroes(Rect2D),
};
pub const PhysicalDeviceDepthBiasControlFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_depth_bias_control_features_ext,
    p_next: ?*anyopaque = null,
    depth_bias_control: Bool32 = @import("std").mem.zeroes(Bool32),
    least_representable_value_force_unorm_representation: Bool32 = @import("std").mem.zeroes(Bool32),
    float_representation: Bool32 = @import("std").mem.zeroes(Bool32),
    depth_bias_exact: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const DepthBiasInfoEXT = extern struct {
    s_type: StructureType = .depth_bias_info_ext,
    p_next: ?*const anyopaque = null,
    depth_bias_constant_factor: f32 = @import("std").mem.zeroes(f32),
    depth_bias_clamp: f32 = @import("std").mem.zeroes(f32),
    depth_bias_slope_factor: f32 = @import("std").mem.zeroes(f32),
};
pub const DepthBiasRepresentationInfoEXT = extern struct {
    s_type: StructureType = .depth_bias_representation_info_ext,
    p_next: ?*const anyopaque = null,
    depth_bias_representation: DepthBiasRepresentationEXT = @import("std").mem.zeroes(DepthBiasRepresentationEXT),
    depth_bias_exact: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceDeviceMemoryReportFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_device_memory_report_features_ext,
    p_next: ?*anyopaque = null,
    device_memory_report: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const DeviceMemoryReportCallbackDataEXT = extern struct {
    s_type: StructureType = .device_memory_report_callback_data_ext,
    p_next: ?*anyopaque = null,
    flags: DeviceMemoryReportFlagsEXT = @import("std").mem.zeroes(DeviceMemoryReportFlagsEXT),
    type: DeviceMemoryReportEventTypeEXT = @import("std").mem.zeroes(DeviceMemoryReportEventTypeEXT),
    memory_object_id: u64 = @import("std").mem.zeroes(u64),
    size: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    object_type: ObjectType = @import("std").mem.zeroes(ObjectType),
    object_handle: u64 = @import("std").mem.zeroes(u64),
    heap_index: u32 = @import("std").mem.zeroes(u32),
};
pub const DeviceDeviceMemoryReportCreateInfoEXT = extern struct {
    s_type: StructureType = .device_device_memory_report_create_info_ext,
    p_next: ?*const anyopaque = null,
    flags: DeviceMemoryReportFlagsEXT = @import("std").mem.zeroes(DeviceMemoryReportFlagsEXT),
    pfn_user_callback: PFN_vkDeviceMemoryReportCallbackEXT = @import("std").mem.zeroes(PFN_vkDeviceMemoryReportCallbackEXT),
    p_user_data: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
};
pub const SamplerCustomBorderColorCreateInfoEXT = extern struct {
    s_type: StructureType = .sampler_custom_border_color_create_info_ext,
    p_next: ?*const anyopaque = null,
    custom_border_color: ClearColorValue = @import("std").mem.zeroes(ClearColorValue),
    format: Format = @import("std").mem.zeroes(Format),
};
pub const PhysicalDeviceCustomBorderColorPropertiesEXT = extern struct {
    s_type: StructureType = .physical_device_custom_border_color_properties_ext,
    p_next: ?*anyopaque = null,
    max_custom_border_color_samplers: u32 = @import("std").mem.zeroes(u32),
};
pub const PhysicalDeviceCustomBorderColorFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_custom_border_color_features_ext,
    p_next: ?*anyopaque = null,
    custom_border_colors: Bool32 = @import("std").mem.zeroes(Bool32),
    custom_border_color_without_format: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDevicePresentBarrierFeaturesNV = extern struct {
    s_type: StructureType = .physical_device_present_barrier_features_nv,
    p_next: ?*anyopaque = null,
    present_barrier: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const SurfaceCapabilitiesPresentBarrierNV = extern struct {
    s_type: StructureType = .surface_capabilities_present_barrier_nv,
    p_next: ?*anyopaque = null,
    present_barrier_supported: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const SwapchainPresentBarrierCreateInfoNV = extern struct {
    s_type: StructureType = .swapchain_present_barrier_create_info_nv,
    p_next: ?*anyopaque = null,
    present_barrier_enable: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceDiagnosticsConfigFeaturesNV = extern struct {
    s_type: StructureType = .physical_device_diagnostics_config_features_nv,
    p_next: ?*anyopaque = null,
    diagnostics_config: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const DeviceDiagnosticsConfigCreateInfoNV = extern struct {
    s_type: StructureType = .device_diagnostics_config_create_info_nv,
    p_next: ?*const anyopaque = null,
    flags: DeviceDiagnosticsConfigFlagsNV = @import("std").mem.zeroes(DeviceDiagnosticsConfigFlagsNV),
};
pub const PhysicalDeviceTileShadingFeaturesQCOM = extern struct {
    s_type: StructureType = .physical_device_tile_shading_features_qcom,
    p_next: ?*anyopaque = null,
    tile_shading: Bool32 = @import("std").mem.zeroes(Bool32),
    tile_shading_fragment_stage: Bool32 = @import("std").mem.zeroes(Bool32),
    tile_shading_color_attachments: Bool32 = @import("std").mem.zeroes(Bool32),
    tile_shading_depth_attachments: Bool32 = @import("std").mem.zeroes(Bool32),
    tile_shading_stencil_attachments: Bool32 = @import("std").mem.zeroes(Bool32),
    tile_shading_input_attachments: Bool32 = @import("std").mem.zeroes(Bool32),
    tile_shading_sampled_attachments: Bool32 = @import("std").mem.zeroes(Bool32),
    tile_shading_per_tile_draw: Bool32 = @import("std").mem.zeroes(Bool32),
    tile_shading_per_tile_dispatch: Bool32 = @import("std").mem.zeroes(Bool32),
    tile_shading_dispatch_tile: Bool32 = @import("std").mem.zeroes(Bool32),
    tile_shading_apron: Bool32 = @import("std").mem.zeroes(Bool32),
    tile_shading_anisotropic_apron: Bool32 = @import("std").mem.zeroes(Bool32),
    tile_shading_atomic_ops: Bool32 = @import("std").mem.zeroes(Bool32),
    tile_shading_image_processing: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceTileShadingPropertiesQCOM = extern struct {
    s_type: StructureType = .physical_device_tile_shading_properties_qcom,
    p_next: ?*anyopaque = null,
    max_apron_size: u32 = @import("std").mem.zeroes(u32),
    prefer_non_coherent: Bool32 = @import("std").mem.zeroes(Bool32),
    tile_granularity: Extent2D = @import("std").mem.zeroes(Extent2D),
    max_tile_shading_rate: Extent2D = @import("std").mem.zeroes(Extent2D),
};
pub const RenderPassTileShadingCreateInfoQCOM = extern struct {
    s_type: StructureType = .render_pass_tile_shading_create_info_qcom,
    p_next: ?*const anyopaque = null,
    flags: TileShadingRenderPassFlagsQCOM = @import("std").mem.zeroes(TileShadingRenderPassFlagsQCOM),
    tile_apron_size: Extent2D = @import("std").mem.zeroes(Extent2D),
};
pub const PerTileBeginInfoQCOM = extern struct {
    s_type: StructureType = .per_tile_begin_info_qcom,
    p_next: ?*const anyopaque = null,
};
pub const PerTileEndInfoQCOM = extern struct {
    s_type: StructureType = .per_tile_end_info_qcom,
    p_next: ?*const anyopaque = null,
};
pub const DispatchTileInfoQCOM = extern struct {
    s_type: StructureType = .dispatch_tile_info_qcom,
    p_next: ?*const anyopaque = null,
};
pub const QueryLowLatencySupportNV = extern struct {
    s_type: StructureType = .query_low_latency_support_nv,
    p_next: ?*const anyopaque = null,
    p_queried_low_latency_data: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
};
pub const PhysicalDeviceDescriptorBufferPropertiesEXT = extern struct {
    s_type: StructureType = .physical_device_descriptor_buffer_properties_ext,
    p_next: ?*anyopaque = null,
    combined_image_sampler_descriptor_single_array: Bool32 = @import("std").mem.zeroes(Bool32),
    bufferless_push_descriptors: Bool32 = @import("std").mem.zeroes(Bool32),
    allow_sampler_image_view_post_submit_creation: Bool32 = @import("std").mem.zeroes(Bool32),
    descriptor_buffer_offset_alignment: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    max_descriptor_buffer_bindings: u32 = @import("std").mem.zeroes(u32),
    max_resource_descriptor_buffer_bindings: u32 = @import("std").mem.zeroes(u32),
    max_sampler_descriptor_buffer_bindings: u32 = @import("std").mem.zeroes(u32),
    max_embedded_immutable_sampler_bindings: u32 = @import("std").mem.zeroes(u32),
    max_embedded_immutable_samplers: u32 = @import("std").mem.zeroes(u32),
    buffer_capture_replay_descriptor_data_size: usize = @import("std").mem.zeroes(usize),
    image_capture_replay_descriptor_data_size: usize = @import("std").mem.zeroes(usize),
    image_view_capture_replay_descriptor_data_size: usize = @import("std").mem.zeroes(usize),
    sampler_capture_replay_descriptor_data_size: usize = @import("std").mem.zeroes(usize),
    acceleration_structure_capture_replay_descriptor_data_size: usize = @import("std").mem.zeroes(usize),
    sampler_descriptor_size: usize = @import("std").mem.zeroes(usize),
    combined_image_sampler_descriptor_size: usize = @import("std").mem.zeroes(usize),
    sampled_image_descriptor_size: usize = @import("std").mem.zeroes(usize),
    storage_image_descriptor_size: usize = @import("std").mem.zeroes(usize),
    uniform_texel_buffer_descriptor_size: usize = @import("std").mem.zeroes(usize),
    robust_uniform_texel_buffer_descriptor_size: usize = @import("std").mem.zeroes(usize),
    storage_texel_buffer_descriptor_size: usize = @import("std").mem.zeroes(usize),
    robust_storage_texel_buffer_descriptor_size: usize = @import("std").mem.zeroes(usize),
    uniform_buffer_descriptor_size: usize = @import("std").mem.zeroes(usize),
    robust_uniform_buffer_descriptor_size: usize = @import("std").mem.zeroes(usize),
    storage_buffer_descriptor_size: usize = @import("std").mem.zeroes(usize),
    robust_storage_buffer_descriptor_size: usize = @import("std").mem.zeroes(usize),
    input_attachment_descriptor_size: usize = @import("std").mem.zeroes(usize),
    acceleration_structure_descriptor_size: usize = @import("std").mem.zeroes(usize),
    max_sampler_descriptor_buffer_range: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    max_resource_descriptor_buffer_range: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    sampler_descriptor_buffer_address_space_size: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    resource_descriptor_buffer_address_space_size: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    descriptor_buffer_address_space_size: DeviceSize = @import("std").mem.zeroes(DeviceSize),
};
pub const PhysicalDeviceDescriptorBufferDensityMapPropertiesEXT = extern struct {
    s_type: StructureType = .physical_device_descriptor_buffer_density_map_properties_ext,
    p_next: ?*anyopaque = null,
    combined_image_sampler_density_map_descriptor_size: usize = @import("std").mem.zeroes(usize),
};
pub const PhysicalDeviceDescriptorBufferFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_descriptor_buffer_features_ext,
    p_next: ?*anyopaque = null,
    descriptor_buffer: Bool32 = @import("std").mem.zeroes(Bool32),
    descriptor_buffer_capture_replay: Bool32 = @import("std").mem.zeroes(Bool32),
    descriptor_buffer_image_layout_ignored: Bool32 = @import("std").mem.zeroes(Bool32),
    descriptor_buffer_push_descriptors: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const DescriptorAddressInfoEXT = extern struct {
    s_type: StructureType = .descriptor_address_info_ext,
    p_next: ?*anyopaque = null,
    address: DeviceAddress = @import("std").mem.zeroes(DeviceAddress),
    range: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    format: Format = @import("std").mem.zeroes(Format),
};
pub const DescriptorBufferBindingInfoEXT = extern struct {
    s_type: StructureType = .descriptor_buffer_binding_info_ext,
    p_next: ?*const anyopaque = null,
    address: DeviceAddress = @import("std").mem.zeroes(DeviceAddress),
    usage: BufferUsageFlags = @import("std").mem.zeroes(BufferUsageFlags),
};
pub const DescriptorBufferBindingPushDescriptorBufferHandleEXT = extern struct {
    s_type: StructureType = .descriptor_buffer_binding_push_descriptor_buffer_handle_ext,
    p_next: ?*const anyopaque = null,
    buffer: Buffer = @import("std").mem.zeroes(Buffer),
};
pub const DescriptorGetInfoEXT = extern struct {
    s_type: StructureType = .descriptor_get_info_ext,
    p_next: ?*const anyopaque = null,
    type: DescriptorType = @import("std").mem.zeroes(DescriptorType),
    data: DescriptorDataEXT = @import("std").mem.zeroes(DescriptorDataEXT),
};
pub const BufferCaptureDescriptorDataInfoEXT = extern struct {
    s_type: StructureType = .buffer_capture_descriptor_data_info_ext,
    p_next: ?*const anyopaque = null,
    buffer: Buffer = @import("std").mem.zeroes(Buffer),
};
pub const ImageCaptureDescriptorDataInfoEXT = extern struct {
    s_type: StructureType = .image_capture_descriptor_data_info_ext,
    p_next: ?*const anyopaque = null,
    image: Image = @import("std").mem.zeroes(Image),
};
pub const ImageViewCaptureDescriptorDataInfoEXT = extern struct {
    s_type: StructureType = .image_view_capture_descriptor_data_info_ext,
    p_next: ?*const anyopaque = null,
    image_view: ImageView = @import("std").mem.zeroes(ImageView),
};
pub const SamplerCaptureDescriptorDataInfoEXT = extern struct {
    s_type: StructureType = .sampler_capture_descriptor_data_info_ext,
    p_next: ?*const anyopaque = null,
    sampler: Sampler = @import("std").mem.zeroes(Sampler),
};
pub const OpaqueCaptureDescriptorDataCreateInfoEXT = extern struct {
    s_type: StructureType = .opaque_capture_descriptor_data_create_info_ext,
    p_next: ?*const anyopaque = null,
    opaque_capture_descriptor_data: ?*const anyopaque = @import("std").mem.zeroes(?*const anyopaque),
};
pub const AccelerationStructureCaptureDescriptorDataInfoEXT = extern struct {
    s_type: StructureType = .acceleration_structure_capture_descriptor_data_info_ext,
    p_next: ?*const anyopaque = null,
    acceleration_structure: AccelerationStructureKHR = @import("std").mem.zeroes(AccelerationStructureKHR),
    acceleration_structure_nv: AccelerationStructureNV = @import("std").mem.zeroes(AccelerationStructureNV),
};
pub const PhysicalDeviceGraphicsPipelineLibraryFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_graphics_pipeline_library_features_ext,
    p_next: ?*anyopaque = null,
    graphics_pipeline_library: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceGraphicsPipelineLibraryPropertiesEXT = extern struct {
    s_type: StructureType = .physical_device_graphics_pipeline_library_properties_ext,
    p_next: ?*anyopaque = null,
    graphics_pipeline_library_fast_linking: Bool32 = @import("std").mem.zeroes(Bool32),
    graphics_pipeline_library_independent_interpolation_decoration: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const GraphicsPipelineLibraryCreateInfoEXT = extern struct {
    s_type: StructureType = .graphics_pipeline_library_create_info_ext,
    p_next: ?*const anyopaque = null,
    flags: GraphicsPipelineLibraryFlagsEXT = @import("std").mem.zeroes(GraphicsPipelineLibraryFlagsEXT),
};
pub const PhysicalDeviceShaderEarlyAndLateFragmentTestsFeaturesAMD = extern struct {
    s_type: StructureType = .physical_device_shader_early_and_late_fragment_tests_features_amd,
    p_next: ?*anyopaque = null,
    shader_early_and_late_fragment_tests: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceFragmentShadingRateEnumsFeaturesNV = extern struct {
    s_type: StructureType = .physical_device_fragment_shading_rate_enums_features_nv,
    p_next: ?*anyopaque = null,
    fragment_shading_rate_enums: Bool32 = @import("std").mem.zeroes(Bool32),
    supersample_fragment_shading_rates: Bool32 = @import("std").mem.zeroes(Bool32),
    no_invocation_fragment_shading_rates: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceFragmentShadingRateEnumsPropertiesNV = extern struct {
    s_type: StructureType = .physical_device_fragment_shading_rate_enums_properties_nv,
    p_next: ?*anyopaque = null,
    max_fragment_shading_rate_invocation_count: SampleCountFlagBits = @import("std").mem.zeroes(SampleCountFlagBits),
};
pub const PipelineFragmentShadingRateEnumStateCreateInfoNV = extern struct {
    s_type: StructureType = .pipeline_fragment_shading_rate_enum_state_create_info_nv,
    p_next: ?*const anyopaque = null,
    shading_rate_type: FragmentShadingRateTypeNV = @import("std").mem.zeroes(FragmentShadingRateTypeNV),
    shading_rate: FragmentShadingRateNV = @import("std").mem.zeroes(FragmentShadingRateNV),
    combiner_ops: [2]FragmentShadingRateCombinerOpKHR = @import("std").mem.zeroes([2]FragmentShadingRateCombinerOpKHR),
};
pub const AccelerationStructureGeometryMotionTrianglesDataNV = extern struct {
    s_type: StructureType = .acceleration_structure_geometry_motion_triangles_data_nv,
    p_next: ?*const anyopaque = null,
    vertex_data: DeviceOrHostAddressConstKHR = @import("std").mem.zeroes(DeviceOrHostAddressConstKHR),
};
pub const AccelerationStructureMotionInfoNV = extern struct {
    s_type: StructureType = .acceleration_structure_motion_info_nv,
    p_next: ?*const anyopaque = null,
    max_instances: u32 = @import("std").mem.zeroes(u32),
    flags: AccelerationStructureMotionInfoFlagsNV = @import("std").mem.zeroes(AccelerationStructureMotionInfoFlagsNV),
};
pub const SRTDataNV = extern struct {
    sx: f32 = @import("std").mem.zeroes(f32),
    a: f32 = @import("std").mem.zeroes(f32),
    b: f32 = @import("std").mem.zeroes(f32),
    pvx: f32 = @import("std").mem.zeroes(f32),
    sy: f32 = @import("std").mem.zeroes(f32),
    c: f32 = @import("std").mem.zeroes(f32),
    pvy: f32 = @import("std").mem.zeroes(f32),
    sz: f32 = @import("std").mem.zeroes(f32),
    pvz: f32 = @import("std").mem.zeroes(f32),
    qx: f32 = @import("std").mem.zeroes(f32),
    qy: f32 = @import("std").mem.zeroes(f32),
    qz: f32 = @import("std").mem.zeroes(f32),
    qw: f32 = @import("std").mem.zeroes(f32),
    tx: f32 = @import("std").mem.zeroes(f32),
    ty: f32 = @import("std").mem.zeroes(f32),
    tz: f32 = @import("std").mem.zeroes(f32),
};
pub const AccelerationStructureMotionInstanceNV = extern struct {
    type: AccelerationStructureMotionInstanceTypeNV = @import("std").mem.zeroes(AccelerationStructureMotionInstanceTypeNV),
    flags: AccelerationStructureMotionInstanceFlagsNV = @import("std").mem.zeroes(AccelerationStructureMotionInstanceFlagsNV),
    data: AccelerationStructureMotionInstanceDataNV = @import("std").mem.zeroes(AccelerationStructureMotionInstanceDataNV),
};
pub const PhysicalDeviceRayTracingMotionBlurFeaturesNV = extern struct {
    s_type: StructureType = .physical_device_ray_tracing_motion_blur_features_nv,
    p_next: ?*anyopaque = null,
    ray_tracing_motion_blur: Bool32 = @import("std").mem.zeroes(Bool32),
    ray_tracing_motion_blur_pipeline_trace_rays_indirect: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceYcbcr2Plane444FormatsFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_ycbcr2plane444_formats_features_ext,
    p_next: ?*anyopaque = null,
    ycbcr2plane444_formats: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceFragmentDensityMap2FeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_fragment_density_map2features_ext,
    p_next: ?*anyopaque = null,
    fragment_density_map_deferred: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceFragmentDensityMap2PropertiesEXT = extern struct {
    s_type: StructureType = .physical_device_fragment_density_map2properties_ext,
    p_next: ?*anyopaque = null,
    subsampled_loads: Bool32 = @import("std").mem.zeroes(Bool32),
    subsampled_coarse_reconstruction_early_access: Bool32 = @import("std").mem.zeroes(Bool32),
    max_subsampled_array_layers: u32 = @import("std").mem.zeroes(u32),
    max_descriptor_set_subsampled_samplers: u32 = @import("std").mem.zeroes(u32),
};
pub const CopyCommandTransformInfoQCOM = extern struct {
    s_type: StructureType = .copy_command_transform_info_qcom,
    p_next: ?*const anyopaque = null,
    transform: SurfaceTransformFlagBitsKHR = @import("std").mem.zeroes(SurfaceTransformFlagBitsKHR),
};
pub const PhysicalDeviceImageCompressionControlFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_image_compression_control_features_ext,
    p_next: ?*anyopaque = null,
    image_compression_control: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const ImageCompressionControlEXT = extern struct {
    s_type: StructureType = .image_compression_control_ext,
    p_next: ?*const anyopaque = null,
    flags: ImageCompressionFlagsEXT = @import("std").mem.zeroes(ImageCompressionFlagsEXT),
    compression_control_plane_count: u32 = @import("std").mem.zeroes(u32),
    p_fixed_rate_flags: [*c]ImageCompressionFixedRateFlagsEXT = @import("std").mem.zeroes([*c]ImageCompressionFixedRateFlagsEXT),
};
pub const ImageCompressionPropertiesEXT = extern struct {
    s_type: StructureType = .image_compression_properties_ext,
    p_next: ?*anyopaque = null,
    image_compression_flags: ImageCompressionFlagsEXT = @import("std").mem.zeroes(ImageCompressionFlagsEXT),
    image_compression_fixed_rate_flags: ImageCompressionFixedRateFlagsEXT = @import("std").mem.zeroes(ImageCompressionFixedRateFlagsEXT),
};
pub const PhysicalDeviceAttachmentFeedbackLoopLayoutFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_attachment_feedback_loop_layout_features_ext,
    p_next: ?*anyopaque = null,
    attachment_feedback_loop_layout: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDevice4444FormatsFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device4444_formats_features_ext,
    p_next: ?*anyopaque = null,
    format_a4r4_g4_b4: Bool32 = @import("std").mem.zeroes(Bool32),
    format_a4b4_g4_r4: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceFaultFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_fault_features_ext,
    p_next: ?*anyopaque = null,
    device_fault: Bool32 = @import("std").mem.zeroes(Bool32),
    device_fault_vendor_binary: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const DeviceFaultCountsEXT = extern struct {
    s_type: StructureType = .device_fault_counts_ext,
    p_next: ?*anyopaque = null,
    address_info_count: u32 = @import("std").mem.zeroes(u32),
    vendor_info_count: u32 = @import("std").mem.zeroes(u32),
    vendor_binary_size: DeviceSize = @import("std").mem.zeroes(DeviceSize),
};
pub const DeviceFaultAddressInfoEXT = extern struct {
    address_type: DeviceFaultAddressTypeEXT = @import("std").mem.zeroes(DeviceFaultAddressTypeEXT),
    reported_address: DeviceAddress = @import("std").mem.zeroes(DeviceAddress),
    address_precision: DeviceSize = @import("std").mem.zeroes(DeviceSize),
};
pub const DeviceFaultVendorInfoEXT = extern struct {
    description: [256]u8 = @import("std").mem.zeroes([256]u8),
    vendor_fault_code: u64 = @import("std").mem.zeroes(u64),
    vendor_fault_data: u64 = @import("std").mem.zeroes(u64),
};
pub const DeviceFaultInfoEXT = extern struct {
    s_type: StructureType = .device_fault_info_ext,
    p_next: ?*anyopaque = null,
    description: [256]u8 = @import("std").mem.zeroes([256]u8),
    p_address_infos: [*c]DeviceFaultAddressInfoEXT = @import("std").mem.zeroes([*c]DeviceFaultAddressInfoEXT),
    p_vendor_infos: [*c]DeviceFaultVendorInfoEXT = @import("std").mem.zeroes([*c]DeviceFaultVendorInfoEXT),
    p_vendor_binary_data: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
};
pub const DeviceFaultVendorBinaryHeaderVersionOneEXT = extern struct {
    header_size: u32 = @import("std").mem.zeroes(u32),
    header_version: DeviceFaultVendorBinaryHeaderVersionEXT = @import("std").mem.zeroes(DeviceFaultVendorBinaryHeaderVersionEXT),
    vendor_id: u32 = @import("std").mem.zeroes(u32),
    device_id: u32 = @import("std").mem.zeroes(u32),
    driver_version: u32 = @import("std").mem.zeroes(u32),
    pipeline_cache_uuid: [16]u8 = @import("std").mem.zeroes([16]u8),
    application_name_offset: u32 = @import("std").mem.zeroes(u32),
    application_version: u32 = @import("std").mem.zeroes(u32),
    engine_name_offset: u32 = @import("std").mem.zeroes(u32),
    engine_version: u32 = @import("std").mem.zeroes(u32),
    api_version: u32 = @import("std").mem.zeroes(u32),
};
pub const PhysicalDeviceRasterizationOrderAttachmentAccessFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_rasterization_order_attachment_access_features_ext,
    p_next: ?*anyopaque = null,
    rasterization_order_color_attachment_access: Bool32 = @import("std").mem.zeroes(Bool32),
    rasterization_order_depth_attachment_access: Bool32 = @import("std").mem.zeroes(Bool32),
    rasterization_order_stencil_attachment_access: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceRGBA10X6FormatsFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_rgba10_x6_formats_features_ext,
    p_next: ?*anyopaque = null,
    format_rgba10x6_without_ycb_cr_sampler: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceMutableDescriptorTypeFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_mutable_descriptor_type_features_ext,
    p_next: ?*anyopaque = null,
    mutable_descriptor_type: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const MutableDescriptorTypeListEXT = extern struct {
    descriptor_type_count: u32 = @import("std").mem.zeroes(u32),
    p_descriptor_types: [*c]const DescriptorType = @import("std").mem.zeroes([*c]const DescriptorType),
};
pub const MutableDescriptorTypeCreateInfoEXT = extern struct {
    s_type: StructureType = .mutable_descriptor_type_create_info_ext,
    p_next: ?*const anyopaque = null,
    mutable_descriptor_type_list_count: u32 = @import("std").mem.zeroes(u32),
    p_mutable_descriptor_type_lists: [*c]const MutableDescriptorTypeListEXT = @import("std").mem.zeroes([*c]const MutableDescriptorTypeListEXT),
};
pub const PhysicalDeviceVertexInputDynamicStateFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_vertex_input_dynamic_state_features_ext,
    p_next: ?*anyopaque = null,
    vertex_input_dynamic_state: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const VertexInputBindingDescription2EXT = extern struct {
    s_type: StructureType = .vertex_input_binding_description2ext,
    p_next: ?*anyopaque = null,
    binding: u32 = @import("std").mem.zeroes(u32),
    stride: u32 = @import("std").mem.zeroes(u32),
    input_rate: VertexInputRate = @import("std").mem.zeroes(VertexInputRate),
    divisor: u32 = @import("std").mem.zeroes(u32),
};
pub const VertexInputAttributeDescription2EXT = extern struct {
    s_type: StructureType = .vertex_input_attribute_description2ext,
    p_next: ?*anyopaque = null,
    location: u32 = @import("std").mem.zeroes(u32),
    binding: u32 = @import("std").mem.zeroes(u32),
    format: Format = @import("std").mem.zeroes(Format),
    offset: u32 = @import("std").mem.zeroes(u32),
};
pub const PhysicalDeviceDrmPropertiesEXT = extern struct {
    s_type: StructureType = .physical_device_drm_properties_ext,
    p_next: ?*anyopaque = null,
    has_primary: Bool32 = @import("std").mem.zeroes(Bool32),
    has_render: Bool32 = @import("std").mem.zeroes(Bool32),
    primary_major: i64 = @import("std").mem.zeroes(i64),
    primary_minor: i64 = @import("std").mem.zeroes(i64),
    render_major: i64 = @import("std").mem.zeroes(i64),
    render_minor: i64 = @import("std").mem.zeroes(i64),
};
pub const PhysicalDeviceAddressBindingReportFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_address_binding_report_features_ext,
    p_next: ?*anyopaque = null,
    report_address_binding: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const DeviceAddressBindingCallbackDataEXT = extern struct {
    s_type: StructureType = .device_address_binding_callback_data_ext,
    p_next: ?*anyopaque = null,
    flags: DeviceAddressBindingFlagsEXT = @import("std").mem.zeroes(DeviceAddressBindingFlagsEXT),
    base_address: DeviceAddress = @import("std").mem.zeroes(DeviceAddress),
    size: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    binding_type: DeviceAddressBindingTypeEXT = @import("std").mem.zeroes(DeviceAddressBindingTypeEXT),
};
pub const PhysicalDeviceDepthClipControlFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_depth_clip_control_features_ext,
    p_next: ?*anyopaque = null,
    depth_clip_control: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PipelineViewportDepthClipControlCreateInfoEXT = extern struct {
    s_type: StructureType = .pipeline_viewport_depth_clip_control_create_info_ext,
    p_next: ?*const anyopaque = null,
    negative_one_to_one: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDevicePrimitiveTopologyListRestartFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_primitive_topology_list_restart_features_ext,
    p_next: ?*anyopaque = null,
    primitive_topology_list_restart: Bool32 = @import("std").mem.zeroes(Bool32),
    primitive_topology_patch_list_restart: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const SubpassShadingPipelineCreateInfoHUAWEI = extern struct {
    s_type: StructureType = .subpass_shading_pipeline_create_info_huawei,
    p_next: ?*anyopaque = null,
    render_pass: RenderPass = @import("std").mem.zeroes(RenderPass),
    subpass: u32 = @import("std").mem.zeroes(u32),
};
pub const PhysicalDeviceSubpassShadingFeaturesHUAWEI = extern struct {
    s_type: StructureType = .physical_device_subpass_shading_features_huawei,
    p_next: ?*anyopaque = null,
    subpass_shading: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceSubpassShadingPropertiesHUAWEI = extern struct {
    s_type: StructureType = .physical_device_subpass_shading_properties_huawei,
    p_next: ?*anyopaque = null,
    max_subpass_shading_workgroup_size_aspect_ratio: u32 = @import("std").mem.zeroes(u32),
};
pub const PhysicalDeviceInvocationMaskFeaturesHUAWEI = extern struct {
    s_type: StructureType = .physical_device_invocation_mask_features_huawei,
    p_next: ?*anyopaque = null,
    invocation_mask: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const MemoryGetRemoteAddressInfoNV = extern struct {
    s_type: StructureType = .memory_get_remote_address_info_nv,
    p_next: ?*const anyopaque = null,
    memory: DeviceMemory = @import("std").mem.zeroes(DeviceMemory),
    handle_type: ExternalMemoryHandleTypeFlagBits = @import("std").mem.zeroes(ExternalMemoryHandleTypeFlagBits),
};
pub const PhysicalDeviceExternalMemoryRDMAFeaturesNV = extern struct {
    s_type: StructureType = .physical_device_external_memory_rdmafeatures_nv,
    p_next: ?*anyopaque = null,
    external_memory_rdma: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PipelinePropertiesIdentifierEXT = extern struct {
    s_type: StructureType = .pipeline_properties_identifier_ext,
    p_next: ?*anyopaque = null,
    pipeline_identifier: [16]u8 = @import("std").mem.zeroes([16]u8),
};
pub const PhysicalDevicePipelinePropertiesFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_pipeline_properties_features_ext,
    p_next: ?*anyopaque = null,
    pipeline_properties_identifier: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceFrameBoundaryFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_frame_boundary_features_ext,
    p_next: ?*anyopaque = null,
    frame_boundary: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const FrameBoundaryEXT = extern struct {
    s_type: StructureType = .frame_boundary_ext,
    p_next: ?*const anyopaque = null,
    flags: FrameBoundaryFlagsEXT = @import("std").mem.zeroes(FrameBoundaryFlagsEXT),
    frame_id: u64 = @import("std").mem.zeroes(u64),
    image_count: u32 = @import("std").mem.zeroes(u32),
    p_images: [*c]const Image = @import("std").mem.zeroes([*c]const Image),
    buffer_count: u32 = @import("std").mem.zeroes(u32),
    p_buffers: [*c]const Buffer = @import("std").mem.zeroes([*c]const Buffer),
    tag_name: u64 = @import("std").mem.zeroes(u64),
    tag_size: usize = @import("std").mem.zeroes(usize),
    p_tag: ?*const anyopaque = @import("std").mem.zeroes(?*const anyopaque),
};
pub const PhysicalDeviceMultisampledRenderToSingleSampledFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_multisampled_render_to_single_sampled_features_ext,
    p_next: ?*anyopaque = null,
    multisampled_render_to_single_sampled: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const SubpassResolvePerformanceQueryEXT = extern struct {
    s_type: StructureType = .subpass_resolve_performance_query_ext,
    p_next: ?*anyopaque = null,
    optimal: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const MultisampledRenderToSingleSampledInfoEXT = extern struct {
    s_type: StructureType = .multisampled_render_to_single_sampled_info_ext,
    p_next: ?*const anyopaque = null,
    multisampled_render_to_single_sampled_enable: Bool32 = @import("std").mem.zeroes(Bool32),
    rasterization_samples: SampleCountFlagBits = @import("std").mem.zeroes(SampleCountFlagBits),
};
pub const PhysicalDeviceExtendedDynamicState2FeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_extended_dynamic_state2features_ext,
    p_next: ?*anyopaque = null,
    extended_dynamic_state2: Bool32 = @import("std").mem.zeroes(Bool32),
    extended_dynamic_state2logic_op: Bool32 = @import("std").mem.zeroes(Bool32),
    extended_dynamic_state2patch_control_points: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceColorWriteEnableFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_color_write_enable_features_ext,
    p_next: ?*anyopaque = null,
    color_write_enable: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PipelineColorWriteCreateInfoEXT = extern struct {
    s_type: StructureType = .pipeline_color_write_create_info_ext,
    p_next: ?*const anyopaque = null,
    attachment_count: u32 = @import("std").mem.zeroes(u32),
    p_color_write_enables: [*c]const Bool32 = @import("std").mem.zeroes([*c]const Bool32),
};
pub const PhysicalDevicePrimitivesGeneratedQueryFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_primitives_generated_query_features_ext,
    p_next: ?*anyopaque = null,
    primitives_generated_query: Bool32 = @import("std").mem.zeroes(Bool32),
    primitives_generated_query_with_rasterizer_discard: Bool32 = @import("std").mem.zeroes(Bool32),
    primitives_generated_query_with_non_zero_streams: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceImageViewMinLodFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_image_view_min_lod_features_ext,
    p_next: ?*anyopaque = null,
    min_lod: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const ImageViewMinLodCreateInfoEXT = extern struct {
    s_type: StructureType = .image_view_min_lod_create_info_ext,
    p_next: ?*const anyopaque = null,
    min_lod: f32 = @import("std").mem.zeroes(f32),
};
pub const PhysicalDeviceMultiDrawFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_multi_draw_features_ext,
    p_next: ?*anyopaque = null,
    multi_draw: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceMultiDrawPropertiesEXT = extern struct {
    s_type: StructureType = .physical_device_multi_draw_properties_ext,
    p_next: ?*anyopaque = null,
    max_multi_draw_count: u32 = @import("std").mem.zeroes(u32),
};
pub const MultiDrawInfoEXT = extern struct {
    first_vertex: u32 = @import("std").mem.zeroes(u32),
    vertex_count: u32 = @import("std").mem.zeroes(u32),
};
pub const MultiDrawIndexedInfoEXT = extern struct {
    first_index: u32 = @import("std").mem.zeroes(u32),
    index_count: u32 = @import("std").mem.zeroes(u32),
    vertex_offset: i32 = @import("std").mem.zeroes(i32),
};
pub const PhysicalDeviceImage2DViewOf3DFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_image2_dview_of3_dfeatures_ext,
    p_next: ?*anyopaque = null,
    image2_dview_of3_d: Bool32 = @import("std").mem.zeroes(Bool32),
    sampler2_dview_of3_d: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceShaderTileImageFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_shader_tile_image_features_ext,
    p_next: ?*anyopaque = null,
    shader_tile_image_color_read_access: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_tile_image_depth_read_access: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_tile_image_stencil_read_access: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceShaderTileImagePropertiesEXT = extern struct {
    s_type: StructureType = .physical_device_shader_tile_image_properties_ext,
    p_next: ?*anyopaque = null,
    shader_tile_image_coherent_read_accelerated: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_tile_image_read_sample_from_pixel_rate_invocation: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_tile_image_read_from_helper_invocation: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const MicromapUsageEXT = extern struct {
    count: u32 = @import("std").mem.zeroes(u32),
    subdivision_level: u32 = @import("std").mem.zeroes(u32),
    format: u32 = @import("std").mem.zeroes(u32),
};
pub const MicromapBuildInfoEXT = extern struct {
    s_type: StructureType = .micromap_build_info_ext,
    p_next: ?*const anyopaque = null,
    type: MicromapTypeEXT = @import("std").mem.zeroes(MicromapTypeEXT),
    flags: BuildMicromapFlagsEXT = @import("std").mem.zeroes(BuildMicromapFlagsEXT),
    mode: BuildMicromapModeEXT = @import("std").mem.zeroes(BuildMicromapModeEXT),
    dst_micromap: MicromapEXT = @import("std").mem.zeroes(MicromapEXT),
    usage_counts_count: u32 = @import("std").mem.zeroes(u32),
    p_usage_counts: [*c]const MicromapUsageEXT = @import("std").mem.zeroes([*c]const MicromapUsageEXT),
    pp_usage_counts: [*c]const [*c]const MicromapUsageEXT = @import("std").mem.zeroes([*c]const [*c]const MicromapUsageEXT),
    data: DeviceOrHostAddressConstKHR = @import("std").mem.zeroes(DeviceOrHostAddressConstKHR),
    scratch_data: DeviceOrHostAddressKHR = @import("std").mem.zeroes(DeviceOrHostAddressKHR),
    triangle_array: DeviceOrHostAddressConstKHR = @import("std").mem.zeroes(DeviceOrHostAddressConstKHR),
    triangle_array_stride: DeviceSize = @import("std").mem.zeroes(DeviceSize),
};
pub const MicromapCreateInfoEXT = extern struct {
    s_type: StructureType = .micromap_create_info_ext,
    p_next: ?*const anyopaque = null,
    create_flags: MicromapCreateFlagsEXT = @import("std").mem.zeroes(MicromapCreateFlagsEXT),
    buffer: Buffer = @import("std").mem.zeroes(Buffer),
    offset: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    size: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    type: MicromapTypeEXT = @import("std").mem.zeroes(MicromapTypeEXT),
    device_address: DeviceAddress = @import("std").mem.zeroes(DeviceAddress),
};
pub const PhysicalDeviceOpacityMicromapFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_opacity_micromap_features_ext,
    p_next: ?*anyopaque = null,
    micromap: Bool32 = @import("std").mem.zeroes(Bool32),
    micromap_capture_replay: Bool32 = @import("std").mem.zeroes(Bool32),
    micromap_host_commands: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceOpacityMicromapPropertiesEXT = extern struct {
    s_type: StructureType = .physical_device_opacity_micromap_properties_ext,
    p_next: ?*anyopaque = null,
    max_opacity2state_subdivision_level: u32 = @import("std").mem.zeroes(u32),
    max_opacity4state_subdivision_level: u32 = @import("std").mem.zeroes(u32),
};
pub const MicromapVersionInfoEXT = extern struct {
    s_type: StructureType = .micromap_version_info_ext,
    p_next: ?*const anyopaque = null,
    p_version_data: [*c]const u8 = @import("std").mem.zeroes([*c]const u8),
};
pub const CopyMicromapToMemoryInfoEXT = extern struct {
    s_type: StructureType = .copy_micromap_to_memory_info_ext,
    p_next: ?*const anyopaque = null,
    src: MicromapEXT = @import("std").mem.zeroes(MicromapEXT),
    dst: DeviceOrHostAddressKHR = @import("std").mem.zeroes(DeviceOrHostAddressKHR),
    mode: CopyMicromapModeEXT = @import("std").mem.zeroes(CopyMicromapModeEXT),
};
pub const CopyMemoryToMicromapInfoEXT = extern struct {
    s_type: StructureType = .copy_memory_to_micromap_info_ext,
    p_next: ?*const anyopaque = null,
    src: DeviceOrHostAddressConstKHR = @import("std").mem.zeroes(DeviceOrHostAddressConstKHR),
    dst: MicromapEXT = @import("std").mem.zeroes(MicromapEXT),
    mode: CopyMicromapModeEXT = @import("std").mem.zeroes(CopyMicromapModeEXT),
};
pub const CopyMicromapInfoEXT = extern struct {
    s_type: StructureType = .copy_micromap_info_ext,
    p_next: ?*const anyopaque = null,
    src: MicromapEXT = @import("std").mem.zeroes(MicromapEXT),
    dst: MicromapEXT = @import("std").mem.zeroes(MicromapEXT),
    mode: CopyMicromapModeEXT = @import("std").mem.zeroes(CopyMicromapModeEXT),
};
pub const MicromapBuildSizesInfoEXT = extern struct {
    s_type: StructureType = .micromap_build_sizes_info_ext,
    p_next: ?*const anyopaque = null,
    micromap_size: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    build_scratch_size: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    discardable: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const AccelerationStructureTrianglesOpacityMicromapEXT = extern struct {
    s_type: StructureType = .acceleration_structure_triangles_opacity_micromap_ext,
    p_next: ?*anyopaque = null,
    index_type: IndexType = @import("std").mem.zeroes(IndexType),
    index_buffer: DeviceOrHostAddressConstKHR = @import("std").mem.zeroes(DeviceOrHostAddressConstKHR),
    index_stride: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    base_triangle: u32 = @import("std").mem.zeroes(u32),
    usage_counts_count: u32 = @import("std").mem.zeroes(u32),
    p_usage_counts: [*c]const MicromapUsageEXT = @import("std").mem.zeroes([*c]const MicromapUsageEXT),
    pp_usage_counts: [*c]const [*c]const MicromapUsageEXT = @import("std").mem.zeroes([*c]const [*c]const MicromapUsageEXT),
    micromap: MicromapEXT = @import("std").mem.zeroes(MicromapEXT),
};
pub const MicromapTriangleEXT = extern struct {
    data_offset: u32 = @import("std").mem.zeroes(u32),
    subdivision_level: u16 = @import("std").mem.zeroes(u16),
    format: u16 = @import("std").mem.zeroes(u16),
};
pub const PhysicalDeviceClusterCullingShaderFeaturesHUAWEI = extern struct {
    s_type: StructureType = .physical_device_cluster_culling_shader_features_huawei,
    p_next: ?*anyopaque = null,
    clusterculling_shader: Bool32 = @import("std").mem.zeroes(Bool32),
    multiview_cluster_culling_shader: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceClusterCullingShaderPropertiesHUAWEI = extern struct {
    s_type: StructureType = .physical_device_cluster_culling_shader_properties_huawei,
    p_next: ?*anyopaque = null,
    max_work_group_count: [3]u32 = @import("std").mem.zeroes([3]u32),
    max_work_group_size: [3]u32 = @import("std").mem.zeroes([3]u32),
    max_output_cluster_count: u32 = @import("std").mem.zeroes(u32),
    indirect_buffer_offset_alignment: DeviceSize = @import("std").mem.zeroes(DeviceSize),
};
pub const PhysicalDeviceClusterCullingShaderVrsFeaturesHUAWEI = extern struct {
    s_type: StructureType = .physical_device_cluster_culling_shader_vrs_features_huawei,
    p_next: ?*anyopaque = null,
    cluster_shading_rate: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceBorderColorSwizzleFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_border_color_swizzle_features_ext,
    p_next: ?*anyopaque = null,
    border_color_swizzle: Bool32 = @import("std").mem.zeroes(Bool32),
    border_color_swizzle_from_image: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const SamplerBorderColorComponentMappingCreateInfoEXT = extern struct {
    s_type: StructureType = .sampler_border_color_component_mapping_create_info_ext,
    p_next: ?*const anyopaque = null,
    components: ComponentMapping = @import("std").mem.zeroes(ComponentMapping),
    srgb: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDevicePageableDeviceLocalMemoryFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_pageable_device_local_memory_features_ext,
    p_next: ?*anyopaque = null,
    pageable_device_local_memory: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceShaderCorePropertiesARM = extern struct {
    s_type: StructureType = .physical_device_shader_core_properties_arm,
    p_next: ?*anyopaque = null,
    pixel_rate: u32 = @import("std").mem.zeroes(u32),
    texel_rate: u32 = @import("std").mem.zeroes(u32),
    fma_rate: u32 = @import("std").mem.zeroes(u32),
};
pub const DeviceQueueShaderCoreControlCreateInfoARM = extern struct {
    s_type: StructureType = .device_queue_shader_core_control_create_info_arm,
    p_next: ?*anyopaque = null,
    shader_core_count: u32 = @import("std").mem.zeroes(u32),
};
pub const PhysicalDeviceSchedulingControlsFeaturesARM = extern struct {
    s_type: StructureType = .physical_device_scheduling_controls_features_arm,
    p_next: ?*anyopaque = null,
    scheduling_controls: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceSchedulingControlsPropertiesARM = extern struct {
    s_type: StructureType = .physical_device_scheduling_controls_properties_arm,
    p_next: ?*anyopaque = null,
    scheduling_controls_flags: PhysicalDeviceSchedulingControlsFlagsARM = @import("std").mem.zeroes(PhysicalDeviceSchedulingControlsFlagsARM),
};
pub const PhysicalDeviceImageSlicedViewOf3DFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_image_sliced_view_of3_dfeatures_ext,
    p_next: ?*anyopaque = null,
    image_sliced_view_of3_d: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const ImageViewSlicedCreateInfoEXT = extern struct {
    s_type: StructureType = .image_view_sliced_create_info_ext,
    p_next: ?*const anyopaque = null,
    slice_offset: u32 = @import("std").mem.zeroes(u32),
    slice_count: u32 = @import("std").mem.zeroes(u32),
};
pub const PhysicalDeviceDescriptorSetHostMappingFeaturesVALVE = extern struct {
    s_type: StructureType = .physical_device_descriptor_set_host_mapping_features_valve,
    p_next: ?*anyopaque = null,
    descriptor_set_host_mapping: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const DescriptorSetBindingReferenceVALVE = extern struct {
    s_type: StructureType = .descriptor_set_binding_reference_valve,
    p_next: ?*const anyopaque = null,
    descriptor_set_layout: DescriptorSetLayout = @import("std").mem.zeroes(DescriptorSetLayout),
    binding: u32 = @import("std").mem.zeroes(u32),
};
pub const DescriptorSetLayoutHostMappingInfoVALVE = extern struct {
    s_type: StructureType = .descriptor_set_layout_host_mapping_info_valve,
    p_next: ?*anyopaque = null,
    descriptor_offset: usize = @import("std").mem.zeroes(usize),
    descriptor_size: u32 = @import("std").mem.zeroes(u32),
};
pub const PhysicalDeviceNonSeamlessCubeMapFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_non_seamless_cube_map_features_ext,
    p_next: ?*anyopaque = null,
    non_seamless_cube_map: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceRenderPassStripedFeaturesARM = extern struct {
    s_type: StructureType = .physical_device_render_pass_striped_features_arm,
    p_next: ?*anyopaque = null,
    render_pass_striped: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceRenderPassStripedPropertiesARM = extern struct {
    s_type: StructureType = .physical_device_render_pass_striped_properties_arm,
    p_next: ?*anyopaque = null,
    render_pass_stripe_granularity: Extent2D = @import("std").mem.zeroes(Extent2D),
    max_render_pass_stripes: u32 = @import("std").mem.zeroes(u32),
};
pub const RenderPassStripeInfoARM = extern struct {
    s_type: StructureType = .render_pass_stripe_info_arm,
    p_next: ?*const anyopaque = null,
    stripe_area: Rect2D = @import("std").mem.zeroes(Rect2D),
};
pub const RenderPassStripeBeginInfoARM = extern struct {
    s_type: StructureType = .render_pass_stripe_begin_info_arm,
    p_next: ?*const anyopaque = null,
    stripe_info_count: u32 = @import("std").mem.zeroes(u32),
    p_stripe_infos: [*c]const RenderPassStripeInfoARM = @import("std").mem.zeroes([*c]const RenderPassStripeInfoARM),
};
pub const RenderPassStripeSubmitInfoARM = extern struct {
    s_type: StructureType = .render_pass_stripe_submit_info_arm,
    p_next: ?*const anyopaque = null,
    stripe_semaphore_info_count: u32 = @import("std").mem.zeroes(u32),
    p_stripe_semaphore_infos: [*c]const SemaphoreSubmitInfo = @import("std").mem.zeroes([*c]const SemaphoreSubmitInfo),
};
pub const PhysicalDeviceFragmentDensityMapOffsetFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_fragment_density_map_offset_features_ext,
    p_next: ?*anyopaque = null,
    fragment_density_map_offset: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceFragmentDensityMapOffsetPropertiesEXT = extern struct {
    s_type: StructureType = .physical_device_fragment_density_map_offset_properties_ext,
    p_next: ?*anyopaque = null,
    fragment_density_offset_granularity: Extent2D = @import("std").mem.zeroes(Extent2D),
};
pub const RenderPassFragmentDensityMapOffsetEndInfoEXT = extern struct {
    s_type: StructureType = .render_pass_fragment_density_map_offset_end_info_ext,
    p_next: ?*const anyopaque = null,
    fragment_density_offset_count: u32 = @import("std").mem.zeroes(u32),
    p_fragment_density_offsets: [*c]const Offset2D = @import("std").mem.zeroes([*c]const Offset2D),
};
pub const CopyMemoryIndirectCommandNV = extern struct {
    src_address: DeviceAddress = @import("std").mem.zeroes(DeviceAddress),
    dst_address: DeviceAddress = @import("std").mem.zeroes(DeviceAddress),
    size: DeviceSize = @import("std").mem.zeroes(DeviceSize),
};
pub const CopyMemoryToImageIndirectCommandNV = extern struct {
    src_address: DeviceAddress = @import("std").mem.zeroes(DeviceAddress),
    buffer_row_length: u32 = @import("std").mem.zeroes(u32),
    buffer_image_height: u32 = @import("std").mem.zeroes(u32),
    image_subresource: ImageSubresourceLayers = @import("std").mem.zeroes(ImageSubresourceLayers),
    image_offset: Offset3D = @import("std").mem.zeroes(Offset3D),
    image_extent: Extent3D = @import("std").mem.zeroes(Extent3D),
};
pub const PhysicalDeviceCopyMemoryIndirectFeaturesNV = extern struct {
    s_type: StructureType = .physical_device_copy_memory_indirect_features_nv,
    p_next: ?*anyopaque = null,
    indirect_copy: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceCopyMemoryIndirectPropertiesNV = extern struct {
    s_type: StructureType = .physical_device_copy_memory_indirect_properties_nv,
    p_next: ?*anyopaque = null,
    supported_queues: QueueFlags = @import("std").mem.zeroes(QueueFlags),
};
pub const DecompressMemoryRegionNV = extern struct {
    src_address: DeviceAddress = @import("std").mem.zeroes(DeviceAddress),
    dst_address: DeviceAddress = @import("std").mem.zeroes(DeviceAddress),
    compressed_size: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    decompressed_size: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    decompression_method: MemoryDecompressionMethodFlagsNV = @import("std").mem.zeroes(MemoryDecompressionMethodFlagsNV),
};
pub const PhysicalDeviceMemoryDecompressionFeaturesNV = extern struct {
    s_type: StructureType = .physical_device_memory_decompression_features_nv,
    p_next: ?*anyopaque = null,
    memory_decompression: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceMemoryDecompressionPropertiesNV = extern struct {
    s_type: StructureType = .physical_device_memory_decompression_properties_nv,
    p_next: ?*anyopaque = null,
    decompression_methods: MemoryDecompressionMethodFlagsNV = @import("std").mem.zeroes(MemoryDecompressionMethodFlagsNV),
    max_decompression_indirect_count: u64 = @import("std").mem.zeroes(u64),
};
pub const PhysicalDeviceDeviceGeneratedCommandsComputeFeaturesNV = extern struct {
    s_type: StructureType = .physical_device_device_generated_commands_compute_features_nv,
    p_next: ?*anyopaque = null,
    device_generated_compute: Bool32 = @import("std").mem.zeroes(Bool32),
    device_generated_compute_pipelines: Bool32 = @import("std").mem.zeroes(Bool32),
    device_generated_compute_capture_replay: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const ComputePipelineIndirectBufferInfoNV = extern struct {
    s_type: StructureType = .compute_pipeline_indirect_buffer_info_nv,
    p_next: ?*const anyopaque = null,
    device_address: DeviceAddress = @import("std").mem.zeroes(DeviceAddress),
    size: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    pipeline_device_address_capture_replay: DeviceAddress = @import("std").mem.zeroes(DeviceAddress),
};
pub const PipelineIndirectDeviceAddressInfoNV = extern struct {
    s_type: StructureType = .pipeline_indirect_device_address_info_nv,
    p_next: ?*const anyopaque = null,
    pipeline_bind_point: PipelineBindPoint = @import("std").mem.zeroes(PipelineBindPoint),
    pipeline: Pipeline = @import("std").mem.zeroes(Pipeline),
};
pub const BindPipelineIndirectCommandNV = extern struct {
    pipeline_address: DeviceAddress = @import("std").mem.zeroes(DeviceAddress),
};
pub const PhysicalDeviceRayTracingLinearSweptSpheresFeaturesNV = extern struct {
    s_type: StructureType = .physical_device_ray_tracing_linear_swept_spheres_features_nv,
    p_next: ?*anyopaque = null,
    spheres: Bool32 = @import("std").mem.zeroes(Bool32),
    linear_swept_spheres: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const AccelerationStructureGeometryLinearSweptSpheresDataNV = extern struct {
    s_type: StructureType = .acceleration_structure_geometry_linear_swept_spheres_data_nv,
    p_next: ?*const anyopaque = null,
    vertex_format: Format = @import("std").mem.zeroes(Format),
    vertex_data: DeviceOrHostAddressConstKHR = @import("std").mem.zeroes(DeviceOrHostAddressConstKHR),
    vertex_stride: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    radius_format: Format = @import("std").mem.zeroes(Format),
    radius_data: DeviceOrHostAddressConstKHR = @import("std").mem.zeroes(DeviceOrHostAddressConstKHR),
    radius_stride: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    index_type: IndexType = @import("std").mem.zeroes(IndexType),
    index_data: DeviceOrHostAddressConstKHR = @import("std").mem.zeroes(DeviceOrHostAddressConstKHR),
    index_stride: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    indexing_mode: RayTracingLssIndexingModeNV = @import("std").mem.zeroes(RayTracingLssIndexingModeNV),
    end_caps_mode: RayTracingLssPrimitiveEndCapsModeNV = @import("std").mem.zeroes(RayTracingLssPrimitiveEndCapsModeNV),
};
pub const AccelerationStructureGeometrySpheresDataNV = extern struct {
    s_type: StructureType = .acceleration_structure_geometry_spheres_data_nv,
    p_next: ?*const anyopaque = null,
    vertex_format: Format = @import("std").mem.zeroes(Format),
    vertex_data: DeviceOrHostAddressConstKHR = @import("std").mem.zeroes(DeviceOrHostAddressConstKHR),
    vertex_stride: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    radius_format: Format = @import("std").mem.zeroes(Format),
    radius_data: DeviceOrHostAddressConstKHR = @import("std").mem.zeroes(DeviceOrHostAddressConstKHR),
    radius_stride: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    index_type: IndexType = @import("std").mem.zeroes(IndexType),
    index_data: DeviceOrHostAddressConstKHR = @import("std").mem.zeroes(DeviceOrHostAddressConstKHR),
    index_stride: DeviceSize = @import("std").mem.zeroes(DeviceSize),
};
pub const PhysicalDeviceLinearColorAttachmentFeaturesNV = extern struct {
    s_type: StructureType = .physical_device_linear_color_attachment_features_nv,
    p_next: ?*anyopaque = null,
    linear_color_attachment: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceImageCompressionControlSwapchainFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_image_compression_control_swapchain_features_ext,
    p_next: ?*anyopaque = null,
    image_compression_control_swapchain: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const ImageViewSampleWeightCreateInfoQCOM = extern struct {
    s_type: StructureType = .image_view_sample_weight_create_info_qcom,
    p_next: ?*const anyopaque = null,
    filter_center: Offset2D = @import("std").mem.zeroes(Offset2D),
    filter_size: Extent2D = @import("std").mem.zeroes(Extent2D),
    num_phases: u32 = @import("std").mem.zeroes(u32),
};
pub const PhysicalDeviceImageProcessingFeaturesQCOM = extern struct {
    s_type: StructureType = .physical_device_image_processing_features_qcom,
    p_next: ?*anyopaque = null,
    texture_sample_weighted: Bool32 = @import("std").mem.zeroes(Bool32),
    texture_box_filter: Bool32 = @import("std").mem.zeroes(Bool32),
    texture_block_match: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceImageProcessingPropertiesQCOM = extern struct {
    s_type: StructureType = .physical_device_image_processing_properties_qcom,
    p_next: ?*anyopaque = null,
    max_weight_filter_phases: u32 = @import("std").mem.zeroes(u32),
    max_weight_filter_dimension: Extent2D = @import("std").mem.zeroes(Extent2D),
    max_block_match_region: Extent2D = @import("std").mem.zeroes(Extent2D),
    max_box_filter_block_size: Extent2D = @import("std").mem.zeroes(Extent2D),
};
pub const PhysicalDeviceNestedCommandBufferFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_nested_command_buffer_features_ext,
    p_next: ?*anyopaque = null,
    nested_command_buffer: Bool32 = @import("std").mem.zeroes(Bool32),
    nested_command_buffer_rendering: Bool32 = @import("std").mem.zeroes(Bool32),
    nested_command_buffer_simultaneous_use: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceNestedCommandBufferPropertiesEXT = extern struct {
    s_type: StructureType = .physical_device_nested_command_buffer_properties_ext,
    p_next: ?*anyopaque = null,
    max_command_buffer_nesting_level: u32 = @import("std").mem.zeroes(u32),
};
pub const ExternalMemoryAcquireUnmodifiedEXT = extern struct {
    s_type: StructureType = .external_memory_acquire_unmodified_ext,
    p_next: ?*const anyopaque = null,
    acquire_unmodified_memory: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceExtendedDynamicState3FeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_extended_dynamic_state3features_ext,
    p_next: ?*anyopaque = null,
    extended_dynamic_state3tessellation_domain_origin: Bool32 = @import("std").mem.zeroes(Bool32),
    extended_dynamic_state3_depth_clamp_enable: Bool32 = @import("std").mem.zeroes(Bool32),
    extended_dynamic_state3polygon_mode: Bool32 = @import("std").mem.zeroes(Bool32),
    extended_dynamic_state3rasterization_samples: Bool32 = @import("std").mem.zeroes(Bool32),
    extended_dynamic_state3sample_mask: Bool32 = @import("std").mem.zeroes(Bool32),
    extended_dynamic_state3alpha_to_coverage_enable: Bool32 = @import("std").mem.zeroes(Bool32),
    extended_dynamic_state3alpha_to_one_enable: Bool32 = @import("std").mem.zeroes(Bool32),
    extended_dynamic_state3logic_op_enable: Bool32 = @import("std").mem.zeroes(Bool32),
    extended_dynamic_state3color_blend_enable: Bool32 = @import("std").mem.zeroes(Bool32),
    extended_dynamic_state3color_blend_equation: Bool32 = @import("std").mem.zeroes(Bool32),
    extended_dynamic_state3color_write_mask: Bool32 = @import("std").mem.zeroes(Bool32),
    extended_dynamic_state3rasterization_stream: Bool32 = @import("std").mem.zeroes(Bool32),
    extended_dynamic_state3conservative_rasterization_mode: Bool32 = @import("std").mem.zeroes(Bool32),
    extended_dynamic_state3extra_primitive_overestimation_size: Bool32 = @import("std").mem.zeroes(Bool32),
    extended_dynamic_state3_depth_clip_enable: Bool32 = @import("std").mem.zeroes(Bool32),
    extended_dynamic_state3sample_locations_enable: Bool32 = @import("std").mem.zeroes(Bool32),
    extended_dynamic_state3color_blend_advanced: Bool32 = @import("std").mem.zeroes(Bool32),
    extended_dynamic_state3provoking_vertex_mode: Bool32 = @import("std").mem.zeroes(Bool32),
    extended_dynamic_state3line_rasterization_mode: Bool32 = @import("std").mem.zeroes(Bool32),
    extended_dynamic_state3line_stipple_enable: Bool32 = @import("std").mem.zeroes(Bool32),
    extended_dynamic_state3_depth_clip_negative_one_to_one: Bool32 = @import("std").mem.zeroes(Bool32),
    extended_dynamic_state3viewport_wscaling_enable: Bool32 = @import("std").mem.zeroes(Bool32),
    extended_dynamic_state3viewport_swizzle: Bool32 = @import("std").mem.zeroes(Bool32),
    extended_dynamic_state3coverage_to_color_enable: Bool32 = @import("std").mem.zeroes(Bool32),
    extended_dynamic_state3coverage_to_color_location: Bool32 = @import("std").mem.zeroes(Bool32),
    extended_dynamic_state3coverage_modulation_mode: Bool32 = @import("std").mem.zeroes(Bool32),
    extended_dynamic_state3coverage_modulation_table_enable: Bool32 = @import("std").mem.zeroes(Bool32),
    extended_dynamic_state3coverage_modulation_table: Bool32 = @import("std").mem.zeroes(Bool32),
    extended_dynamic_state3coverage_reduction_mode: Bool32 = @import("std").mem.zeroes(Bool32),
    extended_dynamic_state3representative_fragment_test_enable: Bool32 = @import("std").mem.zeroes(Bool32),
    extended_dynamic_state3shading_rate_image_enable: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceExtendedDynamicState3PropertiesEXT = extern struct {
    s_type: StructureType = .physical_device_extended_dynamic_state3properties_ext,
    p_next: ?*anyopaque = null,
    dynamic_primitive_topology_unrestricted: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const ColorBlendEquationEXT = extern struct {
    src_color_blend_factor: BlendFactor = @import("std").mem.zeroes(BlendFactor),
    dst_color_blend_factor: BlendFactor = @import("std").mem.zeroes(BlendFactor),
    color_blend_op: BlendOp = @import("std").mem.zeroes(BlendOp),
    src_alpha_blend_factor: BlendFactor = @import("std").mem.zeroes(BlendFactor),
    dst_alpha_blend_factor: BlendFactor = @import("std").mem.zeroes(BlendFactor),
    alpha_blend_op: BlendOp = @import("std").mem.zeroes(BlendOp),
};
pub const ColorBlendAdvancedEXT = extern struct {
    advanced_blend_op: BlendOp = @import("std").mem.zeroes(BlendOp),
    src_premultiplied: Bool32 = @import("std").mem.zeroes(Bool32),
    dst_premultiplied: Bool32 = @import("std").mem.zeroes(Bool32),
    blend_overlap: BlendOverlapEXT = @import("std").mem.zeroes(BlendOverlapEXT),
    clamp_results: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceSubpassMergeFeedbackFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_subpass_merge_feedback_features_ext,
    p_next: ?*anyopaque = null,
    subpass_merge_feedback: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const RenderPassCreationControlEXT = extern struct {
    s_type: StructureType = .render_pass_creation_control_ext,
    p_next: ?*const anyopaque = null,
    disallow_merging: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const RenderPassCreationFeedbackInfoEXT = extern struct {
    post_merge_subpass_count: u32 = @import("std").mem.zeroes(u32),
};
pub const RenderPassCreationFeedbackCreateInfoEXT = extern struct {
    s_type: StructureType = .render_pass_creation_feedback_create_info_ext,
    p_next: ?*const anyopaque = null,
    p_render_pass_feedback: [*c]RenderPassCreationFeedbackInfoEXT = @import("std").mem.zeroes([*c]RenderPassCreationFeedbackInfoEXT),
};
pub const RenderPassSubpassFeedbackInfoEXT = extern struct {
    subpass_merge_status: SubpassMergeStatusEXT = @import("std").mem.zeroes(SubpassMergeStatusEXT),
    description: [256]u8 = @import("std").mem.zeroes([256]u8),
    post_merge_index: u32 = @import("std").mem.zeroes(u32),
};
pub const RenderPassSubpassFeedbackCreateInfoEXT = extern struct {
    s_type: StructureType = .render_pass_subpass_feedback_create_info_ext,
    p_next: ?*const anyopaque = null,
    p_subpass_feedback: [*c]RenderPassSubpassFeedbackInfoEXT = @import("std").mem.zeroes([*c]RenderPassSubpassFeedbackInfoEXT),
};
pub const DirectDriverLoadingInfoLUNARG = extern struct {
    s_type: StructureType = .direct_driver_loading_info_lunarg,
    p_next: ?*anyopaque = null,
    flags: DirectDriverLoadingFlagsLUNARG = @import("std").mem.zeroes(DirectDriverLoadingFlagsLUNARG),
    pfn_get_instance_proc_addr: PFN_vkGetInstanceProcAddrLUNARG = @import("std").mem.zeroes(PFN_vkGetInstanceProcAddrLUNARG),
};
pub const DirectDriverLoadingListLUNARG = extern struct {
    s_type: StructureType = .direct_driver_loading_list_lunarg,
    p_next: ?*const anyopaque = null,
    mode: DirectDriverLoadingModeLUNARG = @import("std").mem.zeroes(DirectDriverLoadingModeLUNARG),
    driver_count: u32 = @import("std").mem.zeroes(u32),
    p_drivers: [*c]const DirectDriverLoadingInfoLUNARG = @import("std").mem.zeroes([*c]const DirectDriverLoadingInfoLUNARG),
};
pub const TensorDescriptionARM = extern struct {
    s_type: StructureType = .tensor_description_arm,
    p_next: ?*const anyopaque = null,
    tiling: TensorTilingARM = @import("std").mem.zeroes(TensorTilingARM),
    format: Format = @import("std").mem.zeroes(Format),
    dimension_count: u32 = @import("std").mem.zeroes(u32),
    p_dimensions: [*c]const i64 = @import("std").mem.zeroes([*c]const i64),
    p_strides: [*c]const i64 = @import("std").mem.zeroes([*c]const i64),
    usage: TensorUsageFlagsARM = @import("std").mem.zeroes(TensorUsageFlagsARM),
};
pub const TensorCreateInfoARM = extern struct {
    s_type: StructureType = .tensor_create_info_arm,
    p_next: ?*const anyopaque = null,
    flags: TensorCreateFlagsARM = @import("std").mem.zeroes(TensorCreateFlagsARM),
    p_description: [*c]const TensorDescriptionARM = @import("std").mem.zeroes([*c]const TensorDescriptionARM),
    sharing_mode: SharingMode = @import("std").mem.zeroes(SharingMode),
    queue_family_index_count: u32 = @import("std").mem.zeroes(u32),
    p_queue_family_indices: [*c]const u32 = @import("std").mem.zeroes([*c]const u32),
};
pub const TensorViewCreateInfoARM = extern struct {
    s_type: StructureType = .tensor_view_create_info_arm,
    p_next: ?*const anyopaque = null,
    flags: TensorViewCreateFlagsARM = @import("std").mem.zeroes(TensorViewCreateFlagsARM),
    tensor: TensorARM = @import("std").mem.zeroes(TensorARM),
    format: Format = @import("std").mem.zeroes(Format),
};
pub const TensorMemoryRequirementsInfoARM = extern struct {
    s_type: StructureType = .tensor_memory_requirements_info_arm,
    p_next: ?*const anyopaque = null,
    tensor: TensorARM = @import("std").mem.zeroes(TensorARM),
};
pub const BindTensorMemoryInfoARM = extern struct {
    s_type: StructureType = .bind_tensor_memory_info_arm,
    p_next: ?*const anyopaque = null,
    tensor: TensorARM = @import("std").mem.zeroes(TensorARM),
    memory: DeviceMemory = @import("std").mem.zeroes(DeviceMemory),
    memory_offset: DeviceSize = @import("std").mem.zeroes(DeviceSize),
};
pub const WriteDescriptorSetTensorARM = extern struct {
    s_type: StructureType = .write_descriptor_set_tensor_arm,
    p_next: ?*const anyopaque = null,
    tensor_view_count: u32 = @import("std").mem.zeroes(u32),
    p_tensor_views: [*c]const TensorViewARM = @import("std").mem.zeroes([*c]const TensorViewARM),
};
pub const TensorFormatPropertiesARM = extern struct {
    s_type: StructureType = .tensor_format_properties_arm,
    p_next: ?*const anyopaque = null,
    optimal_tiling_tensor_features: FormatFeatureFlags2 = @import("std").mem.zeroes(FormatFeatureFlags2),
    linear_tiling_tensor_features: FormatFeatureFlags2 = @import("std").mem.zeroes(FormatFeatureFlags2),
};
pub const PhysicalDeviceTensorPropertiesARM = extern struct {
    s_type: StructureType = .physical_device_tensor_properties_arm,
    p_next: ?*anyopaque = null,
    max_tensor_dimension_count: u32 = @import("std").mem.zeroes(u32),
    max_tensor_elements: u64 = @import("std").mem.zeroes(u64),
    max_per_dimension_tensor_elements: u64 = @import("std").mem.zeroes(u64),
    max_tensor_stride: i64 = @import("std").mem.zeroes(i64),
    max_tensor_size: u64 = @import("std").mem.zeroes(u64),
    max_tensor_shader_access_array_length: u32 = @import("std").mem.zeroes(u32),
    max_tensor_shader_access_size: u32 = @import("std").mem.zeroes(u32),
    max_descriptor_set_storage_tensors: u32 = @import("std").mem.zeroes(u32),
    max_per_stage_descriptor_set_storage_tensors: u32 = @import("std").mem.zeroes(u32),
    max_descriptor_set_update_after_bind_storage_tensors: u32 = @import("std").mem.zeroes(u32),
    max_per_stage_descriptor_update_after_bind_storage_tensors: u32 = @import("std").mem.zeroes(u32),
    shader_storage_tensor_array_non_uniform_indexing_native: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_tensor_supported_stages: ShaderStageFlags = @import("std").mem.zeroes(ShaderStageFlags),
};
pub const TensorMemoryBarrierARM = extern struct {
    s_type: StructureType = .tensor_memory_barrier_arm,
    p_next: ?*const anyopaque = null,
    src_stage_mask: PipelineStageFlags2 = @import("std").mem.zeroes(PipelineStageFlags2),
    src_access_mask: AccessFlags2 = @import("std").mem.zeroes(AccessFlags2),
    dst_stage_mask: PipelineStageFlags2 = @import("std").mem.zeroes(PipelineStageFlags2),
    dst_access_mask: AccessFlags2 = @import("std").mem.zeroes(AccessFlags2),
    src_queue_family_index: u32 = @import("std").mem.zeroes(u32),
    dst_queue_family_index: u32 = @import("std").mem.zeroes(u32),
    tensor: TensorARM = @import("std").mem.zeroes(TensorARM),
};
pub const TensorDependencyInfoARM = extern struct {
    s_type: StructureType = .tensor_dependency_info_arm,
    p_next: ?*const anyopaque = null,
    tensor_memory_barrier_count: u32 = @import("std").mem.zeroes(u32),
    p_tensor_memory_barriers: [*c]const TensorMemoryBarrierARM = @import("std").mem.zeroes([*c]const TensorMemoryBarrierARM),
};
pub const PhysicalDeviceTensorFeaturesARM = extern struct {
    s_type: StructureType = .physical_device_tensor_features_arm,
    p_next: ?*anyopaque = null,
    tensor_non_packed: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_tensor_access: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_storage_tensor_array_dynamic_indexing: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_storage_tensor_array_non_uniform_indexing: Bool32 = @import("std").mem.zeroes(Bool32),
    descriptor_binding_storage_tensor_update_after_bind: Bool32 = @import("std").mem.zeroes(Bool32),
    tensors: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const DeviceTensorMemoryRequirementsARM = extern struct {
    s_type: StructureType = .device_tensor_memory_requirements_arm,
    p_next: ?*const anyopaque = null,
    p_create_info: [*c]const TensorCreateInfoARM = @import("std").mem.zeroes([*c]const TensorCreateInfoARM),
};
pub const TensorCopyARM = extern struct {
    s_type: StructureType = .tensor_copy_arm,
    p_next: ?*const anyopaque = null,
    dimension_count: u32 = @import("std").mem.zeroes(u32),
    p_src_offset: [*c]const u64 = @import("std").mem.zeroes([*c]const u64),
    p_dst_offset: [*c]const u64 = @import("std").mem.zeroes([*c]const u64),
    p_extent: [*c]const u64 = @import("std").mem.zeroes([*c]const u64),
};
pub const CopyTensorInfoARM = extern struct {
    s_type: StructureType = .copy_tensor_info_arm,
    p_next: ?*const anyopaque = null,
    src_tensor: TensorARM = @import("std").mem.zeroes(TensorARM),
    dst_tensor: TensorARM = @import("std").mem.zeroes(TensorARM),
    region_count: u32 = @import("std").mem.zeroes(u32),
    p_regions: [*c]const TensorCopyARM = @import("std").mem.zeroes([*c]const TensorCopyARM),
};
pub const MemoryDedicatedAllocateInfoTensorARM = extern struct {
    s_type: StructureType = .memory_dedicated_allocate_info_tensor_arm,
    p_next: ?*const anyopaque = null,
    tensor: TensorARM = @import("std").mem.zeroes(TensorARM),
};
pub const PhysicalDeviceExternalTensorInfoARM = extern struct {
    s_type: StructureType = .physical_device_external_tensor_info_arm,
    p_next: ?*const anyopaque = null,
    flags: TensorCreateFlagsARM = @import("std").mem.zeroes(TensorCreateFlagsARM),
    p_description: [*c]const TensorDescriptionARM = @import("std").mem.zeroes([*c]const TensorDescriptionARM),
    handle_type: ExternalMemoryHandleTypeFlagBits = @import("std").mem.zeroes(ExternalMemoryHandleTypeFlagBits),
};
pub const ExternalTensorPropertiesARM = extern struct {
    s_type: StructureType = .external_tensor_properties_arm,
    p_next: ?*const anyopaque = null,
    external_memory_properties: ExternalMemoryProperties = @import("std").mem.zeroes(ExternalMemoryProperties),
};
pub const ExternalMemoryTensorCreateInfoARM = extern struct {
    s_type: StructureType = .external_memory_tensor_create_info_arm,
    p_next: ?*const anyopaque = null,
    handle_types: ExternalMemoryHandleTypeFlags = @import("std").mem.zeroes(ExternalMemoryHandleTypeFlags),
};
pub const PhysicalDeviceDescriptorBufferTensorFeaturesARM = extern struct {
    s_type: StructureType = .physical_device_descriptor_buffer_tensor_features_arm,
    p_next: ?*anyopaque = null,
    descriptor_buffer_tensor_descriptors: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceDescriptorBufferTensorPropertiesARM = extern struct {
    s_type: StructureType = .physical_device_descriptor_buffer_tensor_properties_arm,
    p_next: ?*anyopaque = null,
    tensor_capture_replay_descriptor_data_size: usize = @import("std").mem.zeroes(usize),
    tensor_view_capture_replay_descriptor_data_size: usize = @import("std").mem.zeroes(usize),
    tensor_descriptor_size: usize = @import("std").mem.zeroes(usize),
};
pub const DescriptorGetTensorInfoARM = extern struct {
    s_type: StructureType = .descriptor_get_tensor_info_arm,
    p_next: ?*const anyopaque = null,
    tensor_view: TensorViewARM = @import("std").mem.zeroes(TensorViewARM),
};
pub const TensorCaptureDescriptorDataInfoARM = extern struct {
    s_type: StructureType = .tensor_capture_descriptor_data_info_arm,
    p_next: ?*const anyopaque = null,
    tensor: TensorARM = @import("std").mem.zeroes(TensorARM),
};
pub const TensorViewCaptureDescriptorDataInfoARM = extern struct {
    s_type: StructureType = .tensor_view_capture_descriptor_data_info_arm,
    p_next: ?*const anyopaque = null,
    tensor_view: TensorViewARM = @import("std").mem.zeroes(TensorViewARM),
};
pub const FrameBoundaryTensorsARM = extern struct {
    s_type: StructureType = .frame_boundary_tensors_arm,
    p_next: ?*const anyopaque = null,
    tensor_count: u32 = @import("std").mem.zeroes(u32),
    p_tensors: [*c]const TensorARM = @import("std").mem.zeroes([*c]const TensorARM),
};
pub const PhysicalDeviceShaderModuleIdentifierFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_shader_module_identifier_features_ext,
    p_next: ?*anyopaque = null,
    shader_module_identifier: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceShaderModuleIdentifierPropertiesEXT = extern struct {
    s_type: StructureType = .physical_device_shader_module_identifier_properties_ext,
    p_next: ?*anyopaque = null,
    shader_module_identifier_algorithm_uuid: [16]u8 = @import("std").mem.zeroes([16]u8),
};
pub const PipelineShaderStageModuleIdentifierCreateInfoEXT = extern struct {
    s_type: StructureType = .pipeline_shader_stage_module_identifier_create_info_ext,
    p_next: ?*const anyopaque = null,
    identifier_size: u32 = @import("std").mem.zeroes(u32),
    p_identifier: [*c]const u8 = @import("std").mem.zeroes([*c]const u8),
};
pub const ShaderModuleIdentifierEXT = extern struct {
    s_type: StructureType = .shader_module_identifier_ext,
    p_next: ?*anyopaque = null,
    identifier_size: u32 = @import("std").mem.zeroes(u32),
    identifier: [32]u8 = @import("std").mem.zeroes([32]u8),
};
pub const PhysicalDeviceOpticalFlowFeaturesNV = extern struct {
    s_type: StructureType = .physical_device_optical_flow_features_nv,
    p_next: ?*anyopaque = null,
    optical_flow: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceOpticalFlowPropertiesNV = extern struct {
    s_type: StructureType = .physical_device_optical_flow_properties_nv,
    p_next: ?*anyopaque = null,
    supported_output_grid_sizes: OpticalFlowGridSizeFlagsNV = @import("std").mem.zeroes(OpticalFlowGridSizeFlagsNV),
    supported_hint_grid_sizes: OpticalFlowGridSizeFlagsNV = @import("std").mem.zeroes(OpticalFlowGridSizeFlagsNV),
    hint_supported: Bool32 = @import("std").mem.zeroes(Bool32),
    cost_supported: Bool32 = @import("std").mem.zeroes(Bool32),
    bidirectional_flow_supported: Bool32 = @import("std").mem.zeroes(Bool32),
    global_flow_supported: Bool32 = @import("std").mem.zeroes(Bool32),
    min_width: u32 = @import("std").mem.zeroes(u32),
    min_height: u32 = @import("std").mem.zeroes(u32),
    max_width: u32 = @import("std").mem.zeroes(u32),
    max_height: u32 = @import("std").mem.zeroes(u32),
    max_num_regions_of_interest: u32 = @import("std").mem.zeroes(u32),
};
pub const OpticalFlowImageFormatInfoNV = extern struct {
    s_type: StructureType = .optical_flow_image_format_info_nv,
    p_next: ?*const anyopaque = null,
    usage: OpticalFlowUsageFlagsNV = @import("std").mem.zeroes(OpticalFlowUsageFlagsNV),
};
pub const OpticalFlowImageFormatPropertiesNV = extern struct {
    s_type: StructureType = .optical_flow_image_format_properties_nv,
    p_next: ?*const anyopaque = null,
    format: Format = @import("std").mem.zeroes(Format),
};
pub const OpticalFlowSessionCreateInfoNV = extern struct {
    s_type: StructureType = .optical_flow_session_create_info_nv,
    p_next: ?*anyopaque = null,
    width: u32 = @import("std").mem.zeroes(u32),
    height: u32 = @import("std").mem.zeroes(u32),
    image_format: Format = @import("std").mem.zeroes(Format),
    flow_vector_format: Format = @import("std").mem.zeroes(Format),
    cost_format: Format = @import("std").mem.zeroes(Format),
    output_grid_size: OpticalFlowGridSizeFlagsNV = @import("std").mem.zeroes(OpticalFlowGridSizeFlagsNV),
    hint_grid_size: OpticalFlowGridSizeFlagsNV = @import("std").mem.zeroes(OpticalFlowGridSizeFlagsNV),
    performance_level: OpticalFlowPerformanceLevelNV = @import("std").mem.zeroes(OpticalFlowPerformanceLevelNV),
    flags: OpticalFlowSessionCreateFlagsNV = @import("std").mem.zeroes(OpticalFlowSessionCreateFlagsNV),
};
pub const OpticalFlowSessionCreatePrivateDataInfoNV = extern struct {
    s_type: StructureType = .optical_flow_session_create_private_data_info_nv,
    p_next: ?*anyopaque = null,
    id: u32 = @import("std").mem.zeroes(u32),
    size: u32 = @import("std").mem.zeroes(u32),
    p_private_data: ?*const anyopaque = @import("std").mem.zeroes(?*const anyopaque),
};
pub const OpticalFlowExecuteInfoNV = extern struct {
    s_type: StructureType = .optical_flow_execute_info_nv,
    p_next: ?*anyopaque = null,
    flags: OpticalFlowExecuteFlagsNV = @import("std").mem.zeroes(OpticalFlowExecuteFlagsNV),
    region_count: u32 = @import("std").mem.zeroes(u32),
    p_regions: [*c]const Rect2D = @import("std").mem.zeroes([*c]const Rect2D),
};
pub const PhysicalDeviceLegacyDitheringFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_legacy_dithering_features_ext,
    p_next: ?*anyopaque = null,
    legacy_dithering: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceAntiLagFeaturesAMD = extern struct {
    s_type: StructureType = .physical_device_anti_lag_features_amd,
    p_next: ?*anyopaque = null,
    anti_lag: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const AntiLagPresentationInfoAMD = extern struct {
    s_type: StructureType = .anti_lag_presentation_info_amd,
    p_next: ?*anyopaque = null,
    stage: AntiLagStageAMD = @import("std").mem.zeroes(AntiLagStageAMD),
    frame_index: u64 = @import("std").mem.zeroes(u64),
};
pub const AntiLagDataAMD = extern struct {
    s_type: StructureType = .anti_lag_data_amd,
    p_next: ?*const anyopaque = null,
    mode: AntiLagModeAMD = @import("std").mem.zeroes(AntiLagModeAMD),
    max_fps: u32 = @import("std").mem.zeroes(u32),
    p_presentation_info: [*c]const AntiLagPresentationInfoAMD = @import("std").mem.zeroes([*c]const AntiLagPresentationInfoAMD),
};
pub const PhysicalDeviceShaderObjectFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_shader_object_features_ext,
    p_next: ?*anyopaque = null,
    shader_object: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceShaderObjectPropertiesEXT = extern struct {
    s_type: StructureType = .physical_device_shader_object_properties_ext,
    p_next: ?*anyopaque = null,
    shader_binary_uuid: [16]u8 = @import("std").mem.zeroes([16]u8),
    shader_binary_version: u32 = @import("std").mem.zeroes(u32),
};
pub const ShaderCreateInfoEXT = extern struct {
    s_type: StructureType = .shader_create_info_ext,
    p_next: ?*const anyopaque = null,
    flags: ShaderCreateFlagsEXT = @import("std").mem.zeroes(ShaderCreateFlagsEXT),
    stage: ShaderStageFlagBits = @import("std").mem.zeroes(ShaderStageFlagBits),
    next_stage: ShaderStageFlags = @import("std").mem.zeroes(ShaderStageFlags),
    code_type: ShaderCodeTypeEXT = @import("std").mem.zeroes(ShaderCodeTypeEXT),
    code_size: usize = @import("std").mem.zeroes(usize),
    p_code: ?*const anyopaque = @import("std").mem.zeroes(?*const anyopaque),
    p_name: [*c]const u8 = @import("std").mem.zeroes([*c]const u8),
    set_layout_count: u32 = @import("std").mem.zeroes(u32),
    p_set_layouts: [*c]const DescriptorSetLayout = @import("std").mem.zeroes([*c]const DescriptorSetLayout),
    push_constant_range_count: u32 = @import("std").mem.zeroes(u32),
    p_push_constant_ranges: [*c]const PushConstantRange = @import("std").mem.zeroes([*c]const PushConstantRange),
    p_specialization_info: [*c]const SpecializationInfo = @import("std").mem.zeroes([*c]const SpecializationInfo),
};
pub const DepthClampRangeEXT = extern struct {
    min_depth_clamp: f32 = @import("std").mem.zeroes(f32),
    max_depth_clamp: f32 = @import("std").mem.zeroes(f32),
};
pub const PhysicalDeviceTilePropertiesFeaturesQCOM = extern struct {
    s_type: StructureType = .physical_device_tile_properties_features_qcom,
    p_next: ?*anyopaque = null,
    tile_properties: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const TilePropertiesQCOM = extern struct {
    s_type: StructureType = .tile_properties_qcom,
    p_next: ?*anyopaque = null,
    tile_size: Extent3D = @import("std").mem.zeroes(Extent3D),
    apron_size: Extent2D = @import("std").mem.zeroes(Extent2D),
    origin: Offset2D = @import("std").mem.zeroes(Offset2D),
};
pub const PhysicalDeviceAmigoProfilingFeaturesSEC = extern struct {
    s_type: StructureType = .physical_device_amigo_profiling_features_sec,
    p_next: ?*anyopaque = null,
    amigo_profiling: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const AmigoProfilingSubmitInfoSEC = extern struct {
    s_type: StructureType = .amigo_profiling_submit_info_sec,
    p_next: ?*const anyopaque = null,
    first_draw_timestamp: u64 = @import("std").mem.zeroes(u64),
    swap_buffer_timestamp: u64 = @import("std").mem.zeroes(u64),
};
pub const PhysicalDeviceMultiviewPerViewViewportsFeaturesQCOM = extern struct {
    s_type: StructureType = .physical_device_multiview_per_view_viewports_features_qcom,
    p_next: ?*anyopaque = null,
    multiview_per_view_viewports: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceRayTracingInvocationReorderPropertiesNV = extern struct {
    s_type: StructureType = .physical_device_ray_tracing_invocation_reorder_properties_nv,
    p_next: ?*anyopaque = null,
    ray_tracing_invocation_reorder_reordering_hint: RayTracingInvocationReorderModeNV = @import("std").mem.zeroes(RayTracingInvocationReorderModeNV),
};
pub const PhysicalDeviceRayTracingInvocationReorderFeaturesNV = extern struct {
    s_type: StructureType = .physical_device_ray_tracing_invocation_reorder_features_nv,
    p_next: ?*anyopaque = null,
    ray_tracing_invocation_reorder: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceCooperativeVectorPropertiesNV = extern struct {
    s_type: StructureType = .physical_device_cooperative_vector_properties_nv,
    p_next: ?*anyopaque = null,
    cooperative_vector_supported_stages: ShaderStageFlags = @import("std").mem.zeroes(ShaderStageFlags),
    cooperative_vector_training_float16_accumulation: Bool32 = @import("std").mem.zeroes(Bool32),
    cooperative_vector_training_float32_accumulation: Bool32 = @import("std").mem.zeroes(Bool32),
    max_cooperative_vector_components: u32 = @import("std").mem.zeroes(u32),
};
pub const PhysicalDeviceCooperativeVectorFeaturesNV = extern struct {
    s_type: StructureType = .physical_device_cooperative_vector_features_nv,
    p_next: ?*anyopaque = null,
    cooperative_vector: Bool32 = @import("std").mem.zeroes(Bool32),
    cooperative_vector_training: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const CooperativeVectorPropertiesNV = extern struct {
    s_type: StructureType = .cooperative_vector_properties_nv,
    p_next: ?*anyopaque = null,
    input_type: ComponentTypeKHR = @import("std").mem.zeroes(ComponentTypeKHR),
    input_interpretation: ComponentTypeKHR = @import("std").mem.zeroes(ComponentTypeKHR),
    matrix_interpretation: ComponentTypeKHR = @import("std").mem.zeroes(ComponentTypeKHR),
    bias_interpretation: ComponentTypeKHR = @import("std").mem.zeroes(ComponentTypeKHR),
    result_type: ComponentTypeKHR = @import("std").mem.zeroes(ComponentTypeKHR),
    transpose: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const ConvertCooperativeVectorMatrixInfoNV = extern struct {
    s_type: StructureType = .convert_cooperative_vector_matrix_info_nv,
    p_next: ?*const anyopaque = null,
    src_size: usize = @import("std").mem.zeroes(usize),
    src_data: DeviceOrHostAddressConstKHR = @import("std").mem.zeroes(DeviceOrHostAddressConstKHR),
    p_dst_size: [*c]usize = @import("std").mem.zeroes([*c]usize),
    dst_data: DeviceOrHostAddressKHR = @import("std").mem.zeroes(DeviceOrHostAddressKHR),
    src_component_type: ComponentTypeKHR = @import("std").mem.zeroes(ComponentTypeKHR),
    dst_component_type: ComponentTypeKHR = @import("std").mem.zeroes(ComponentTypeKHR),
    num_rows: u32 = @import("std").mem.zeroes(u32),
    num_columns: u32 = @import("std").mem.zeroes(u32),
    src_layout: CooperativeVectorMatrixLayoutNV = @import("std").mem.zeroes(CooperativeVectorMatrixLayoutNV),
    src_stride: usize = @import("std").mem.zeroes(usize),
    dst_layout: CooperativeVectorMatrixLayoutNV = @import("std").mem.zeroes(CooperativeVectorMatrixLayoutNV),
    dst_stride: usize = @import("std").mem.zeroes(usize),
};
pub const PhysicalDeviceExtendedSparseAddressSpaceFeaturesNV = extern struct {
    s_type: StructureType = .physical_device_extended_sparse_address_space_features_nv,
    p_next: ?*anyopaque = null,
    extended_sparse_address_space: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceExtendedSparseAddressSpacePropertiesNV = extern struct {
    s_type: StructureType = .physical_device_extended_sparse_address_space_properties_nv,
    p_next: ?*anyopaque = null,
    extended_sparse_address_space_size: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    extended_sparse_image_usage_flags: ImageUsageFlags = @import("std").mem.zeroes(ImageUsageFlags),
    extended_sparse_buffer_usage_flags: BufferUsageFlags = @import("std").mem.zeroes(BufferUsageFlags),
};
pub const PhysicalDeviceLegacyVertexAttributesFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_legacy_vertex_attributes_features_ext,
    p_next: ?*anyopaque = null,
    legacy_vertex_attributes: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceLegacyVertexAttributesPropertiesEXT = extern struct {
    s_type: StructureType = .physical_device_legacy_vertex_attributes_properties_ext,
    p_next: ?*anyopaque = null,
    native_unaligned_performance: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const LayerSettingEXT = extern struct {
    p_layer_name: [*c]const u8 = @import("std").mem.zeroes([*c]const u8),
    p_setting_name: [*c]const u8 = @import("std").mem.zeroes([*c]const u8),
    type: LayerSettingTypeEXT = @import("std").mem.zeroes(LayerSettingTypeEXT),
    value_count: u32 = @import("std").mem.zeroes(u32),
    p_values: ?*const anyopaque = @import("std").mem.zeroes(?*const anyopaque),
};
pub const LayerSettingsCreateInfoEXT = extern struct {
    s_type: StructureType = .layer_settings_create_info_ext,
    p_next: ?*const anyopaque = null,
    setting_count: u32 = @import("std").mem.zeroes(u32),
    p_settings: [*c]const LayerSettingEXT = @import("std").mem.zeroes([*c]const LayerSettingEXT),
};
pub const PhysicalDeviceShaderCoreBuiltinsFeaturesARM = extern struct {
    s_type: StructureType = .physical_device_shader_core_builtins_features_arm,
    p_next: ?*anyopaque = null,
    shader_core_builtins: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceShaderCoreBuiltinsPropertiesARM = extern struct {
    s_type: StructureType = .physical_device_shader_core_builtins_properties_arm,
    p_next: ?*anyopaque = null,
    shader_core_mask: u64 = @import("std").mem.zeroes(u64),
    shader_core_count: u32 = @import("std").mem.zeroes(u32),
    shader_warps_per_core: u32 = @import("std").mem.zeroes(u32),
};
pub const PhysicalDevicePipelineLibraryGroupHandlesFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_pipeline_library_group_handles_features_ext,
    p_next: ?*anyopaque = null,
    pipeline_library_group_handles: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceDynamicRenderingUnusedAttachmentsFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_dynamic_rendering_unused_attachments_features_ext,
    p_next: ?*anyopaque = null,
    dynamic_rendering_unused_attachments: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const LatencySleepModeInfoNV = extern struct {
    s_type: StructureType = .latency_sleep_mode_info_nv,
    p_next: ?*const anyopaque = null,
    low_latency_mode: Bool32 = @import("std").mem.zeroes(Bool32),
    low_latency_boost: Bool32 = @import("std").mem.zeroes(Bool32),
    minimum_interval_us: u32 = @import("std").mem.zeroes(u32),
};
pub const LatencySleepInfoNV = extern struct {
    s_type: StructureType = .latency_sleep_info_nv,
    p_next: ?*const anyopaque = null,
    signal_semaphore: Semaphore = @import("std").mem.zeroes(Semaphore),
    value: u64 = @import("std").mem.zeroes(u64),
};
pub const SetLatencyMarkerInfoNV = extern struct {
    s_type: StructureType = .set_latency_marker_info_nv,
    p_next: ?*const anyopaque = null,
    present_id: u64 = @import("std").mem.zeroes(u64),
    marker: LatencyMarkerNV = @import("std").mem.zeroes(LatencyMarkerNV),
};
pub const LatencyTimingsFrameReportNV = extern struct {
    s_type: StructureType = .latency_timings_frame_report_nv,
    p_next: ?*const anyopaque = null,
    present_id: u64 = @import("std").mem.zeroes(u64),
    input_sample_time_us: u64 = @import("std").mem.zeroes(u64),
    sim_start_time_us: u64 = @import("std").mem.zeroes(u64),
    sim_end_time_us: u64 = @import("std").mem.zeroes(u64),
    render_submit_start_time_us: u64 = @import("std").mem.zeroes(u64),
    render_submit_end_time_us: u64 = @import("std").mem.zeroes(u64),
    present_start_time_us: u64 = @import("std").mem.zeroes(u64),
    present_end_time_us: u64 = @import("std").mem.zeroes(u64),
    driver_start_time_us: u64 = @import("std").mem.zeroes(u64),
    driver_end_time_us: u64 = @import("std").mem.zeroes(u64),
    os_render_queue_start_time_us: u64 = @import("std").mem.zeroes(u64),
    os_render_queue_end_time_us: u64 = @import("std").mem.zeroes(u64),
    gpu_render_start_time_us: u64 = @import("std").mem.zeroes(u64),
    gpu_render_end_time_us: u64 = @import("std").mem.zeroes(u64),
};
pub const GetLatencyMarkerInfoNV = extern struct {
    s_type: StructureType = .get_latency_marker_info_nv,
    p_next: ?*const anyopaque = null,
    timing_count: u32 = @import("std").mem.zeroes(u32),
    p_timings: [*c]LatencyTimingsFrameReportNV = @import("std").mem.zeroes([*c]LatencyTimingsFrameReportNV),
};
pub const LatencySubmissionPresentIdNV = extern struct {
    s_type: StructureType = .latency_submission_present_id_nv,
    p_next: ?*const anyopaque = null,
    present_id: u64 = @import("std").mem.zeroes(u64),
};
pub const SwapchainLatencyCreateInfoNV = extern struct {
    s_type: StructureType = .swapchain_latency_create_info_nv,
    p_next: ?*const anyopaque = null,
    latency_mode_enable: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const OutOfBandQueueTypeInfoNV = extern struct {
    s_type: StructureType = .out_of_band_queue_type_info_nv,
    p_next: ?*const anyopaque = null,
    queue_type: OutOfBandQueueTypeNV = @import("std").mem.zeroes(OutOfBandQueueTypeNV),
};
pub const LatencySurfaceCapabilitiesNV = extern struct {
    s_type: StructureType = .latency_surface_capabilities_nv,
    p_next: ?*const anyopaque = null,
    present_mode_count: u32 = @import("std").mem.zeroes(u32),
    p_present_modes: [*c]PresentModeKHR = @import("std").mem.zeroes([*c]PresentModeKHR),
};
pub const PhysicalDeviceDataGraphFeaturesARM = extern struct {
    s_type: StructureType = .physical_device_data_graph_features_arm,
    p_next: ?*anyopaque = null,
    data_graph: Bool32 = @import("std").mem.zeroes(Bool32),
    data_graph_update_after_bind: Bool32 = @import("std").mem.zeroes(Bool32),
    data_graph_specialization_constants: Bool32 = @import("std").mem.zeroes(Bool32),
    data_graph_descriptor_buffer: Bool32 = @import("std").mem.zeroes(Bool32),
    data_graph_shader_module: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const DataGraphPipelineConstantARM = extern struct {
    s_type: StructureType = .data_graph_pipeline_constant_arm,
    p_next: ?*const anyopaque = null,
    id: u32 = @import("std").mem.zeroes(u32),
    p_constant_data: ?*const anyopaque = @import("std").mem.zeroes(?*const anyopaque),
};
pub const DataGraphPipelineResourceInfoARM = extern struct {
    s_type: StructureType = .data_graph_pipeline_resource_info_arm,
    p_next: ?*const anyopaque = null,
    descriptor_set: u32 = @import("std").mem.zeroes(u32),
    binding: u32 = @import("std").mem.zeroes(u32),
    array_element: u32 = @import("std").mem.zeroes(u32),
};
pub const DataGraphPipelineCompilerControlCreateInfoARM = extern struct {
    s_type: StructureType = .data_graph_pipeline_compiler_control_create_info_arm,
    p_next: ?*const anyopaque = null,
    p_vendor_options: [*c]const u8 = @import("std").mem.zeroes([*c]const u8),
};
pub const DataGraphPipelineCreateInfoARM = extern struct {
    s_type: StructureType = .data_graph_pipeline_create_info_arm,
    p_next: ?*const anyopaque = null,
    flags: PipelineCreateFlags2KHR = @import("std").mem.zeroes(PipelineCreateFlags2KHR),
    layout: PipelineLayout = @import("std").mem.zeroes(PipelineLayout),
    resource_info_count: u32 = @import("std").mem.zeroes(u32),
    p_resource_infos: [*c]const DataGraphPipelineResourceInfoARM = @import("std").mem.zeroes([*c]const DataGraphPipelineResourceInfoARM),
};
pub const DataGraphPipelineShaderModuleCreateInfoARM = extern struct {
    s_type: StructureType = .data_graph_pipeline_shader_module_create_info_arm,
    p_next: ?*const anyopaque = null,
    module: ShaderModule = @import("std").mem.zeroes(ShaderModule),
    p_name: [*c]const u8 = @import("std").mem.zeroes([*c]const u8),
    p_specialization_info: [*c]const SpecializationInfo = @import("std").mem.zeroes([*c]const SpecializationInfo),
    constant_count: u32 = @import("std").mem.zeroes(u32),
    p_constants: [*c]const DataGraphPipelineConstantARM = @import("std").mem.zeroes([*c]const DataGraphPipelineConstantARM),
};
pub const DataGraphPipelineSessionCreateInfoARM = extern struct {
    s_type: StructureType = .data_graph_pipeline_session_create_info_arm,
    p_next: ?*const anyopaque = null,
    flags: DataGraphPipelineSessionCreateFlagsARM = @import("std").mem.zeroes(DataGraphPipelineSessionCreateFlagsARM),
    data_graph_pipeline: Pipeline = @import("std").mem.zeroes(Pipeline),
};
pub const DataGraphPipelineSessionBindPointRequirementsInfoARM = extern struct {
    s_type: StructureType = .data_graph_pipeline_session_bind_point_requirements_info_arm,
    p_next: ?*const anyopaque = null,
    session: DataGraphPipelineSessionARM = @import("std").mem.zeroes(DataGraphPipelineSessionARM),
};
pub const DataGraphPipelineSessionBindPointRequirementARM = extern struct {
    s_type: StructureType = .data_graph_pipeline_session_bind_point_requirement_arm,
    p_next: ?*const anyopaque = null,
    bind_point: DataGraphPipelineSessionBindPointARM = @import("std").mem.zeroes(DataGraphPipelineSessionBindPointARM),
    bind_point_type: DataGraphPipelineSessionBindPointTypeARM = @import("std").mem.zeroes(DataGraphPipelineSessionBindPointTypeARM),
    num_objects: u32 = @import("std").mem.zeroes(u32),
};
pub const DataGraphPipelineSessionMemoryRequirementsInfoARM = extern struct {
    s_type: StructureType = .data_graph_pipeline_session_memory_requirements_info_arm,
    p_next: ?*const anyopaque = null,
    session: DataGraphPipelineSessionARM = @import("std").mem.zeroes(DataGraphPipelineSessionARM),
    bind_point: DataGraphPipelineSessionBindPointARM = @import("std").mem.zeroes(DataGraphPipelineSessionBindPointARM),
    object_index: u32 = @import("std").mem.zeroes(u32),
};
pub const BindDataGraphPipelineSessionMemoryInfoARM = extern struct {
    s_type: StructureType = .bind_data_graph_pipeline_session_memory_info_arm,
    p_next: ?*const anyopaque = null,
    session: DataGraphPipelineSessionARM = @import("std").mem.zeroes(DataGraphPipelineSessionARM),
    bind_point: DataGraphPipelineSessionBindPointARM = @import("std").mem.zeroes(DataGraphPipelineSessionBindPointARM),
    object_index: u32 = @import("std").mem.zeroes(u32),
    memory: DeviceMemory = @import("std").mem.zeroes(DeviceMemory),
    memory_offset: DeviceSize = @import("std").mem.zeroes(DeviceSize),
};
pub const DataGraphPipelineInfoARM = extern struct {
    s_type: StructureType = .data_graph_pipeline_info_arm,
    p_next: ?*const anyopaque = null,
    data_graph_pipeline: Pipeline = @import("std").mem.zeroes(Pipeline),
};
pub const DataGraphPipelinePropertyQueryResultARM = extern struct {
    s_type: StructureType = .data_graph_pipeline_property_query_result_arm,
    p_next: ?*const anyopaque = null,
    property: DataGraphPipelinePropertyARM = @import("std").mem.zeroes(DataGraphPipelinePropertyARM),
    is_text: Bool32 = @import("std").mem.zeroes(Bool32),
    data_size: usize = @import("std").mem.zeroes(usize),
    p_data: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
};
pub const DataGraphPipelineIdentifierCreateInfoARM = extern struct {
    s_type: StructureType = .data_graph_pipeline_identifier_create_info_arm,
    p_next: ?*const anyopaque = null,
    identifier_size: u32 = @import("std").mem.zeroes(u32),
    p_identifier: [*c]const u8 = @import("std").mem.zeroes([*c]const u8),
};
pub const DataGraphPipelineDispatchInfoARM = extern struct {
    s_type: StructureType = .data_graph_pipeline_dispatch_info_arm,
    p_next: ?*anyopaque = null,
    flags: DataGraphPipelineDispatchFlagsARM = @import("std").mem.zeroes(DataGraphPipelineDispatchFlagsARM),
};
pub const PhysicalDeviceDataGraphProcessingEngineARM = extern struct {
    type: PhysicalDeviceDataGraphProcessingEngineTypeARM = @import("std").mem.zeroes(PhysicalDeviceDataGraphProcessingEngineTypeARM),
    is_foreign: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceDataGraphOperationSupportARM = extern struct {
    operation_type: PhysicalDeviceDataGraphOperationTypeARM = @import("std").mem.zeroes(PhysicalDeviceDataGraphOperationTypeARM),
    name: [128]u8 = @import("std").mem.zeroes([128]u8),
    version: u32 = @import("std").mem.zeroes(u32),
};
pub const QueueFamilyDataGraphPropertiesARM = extern struct {
    s_type: StructureType = .queue_family_data_graph_properties_arm,
    p_next: ?*const anyopaque = null,
    engine: PhysicalDeviceDataGraphProcessingEngineARM = @import("std").mem.zeroes(PhysicalDeviceDataGraphProcessingEngineARM),
    operation: PhysicalDeviceDataGraphOperationSupportARM = @import("std").mem.zeroes(PhysicalDeviceDataGraphOperationSupportARM),
};
pub const DataGraphProcessingEngineCreateInfoARM = extern struct {
    s_type: StructureType = .data_graph_processing_engine_create_info_arm,
    p_next: ?*const anyopaque = null,
    processing_engine_count: u32 = @import("std").mem.zeroes(u32),
    p_processing_engines: [*c]PhysicalDeviceDataGraphProcessingEngineARM = @import("std").mem.zeroes([*c]PhysicalDeviceDataGraphProcessingEngineARM),
};
pub const PhysicalDeviceQueueFamilyDataGraphProcessingEngineInfoARM = extern struct {
    s_type: StructureType = .physical_device_queue_family_data_graph_processing_engine_info_arm,
    p_next: ?*const anyopaque = null,
    queue_family_index: u32 = @import("std").mem.zeroes(u32),
    engine_type: PhysicalDeviceDataGraphProcessingEngineTypeARM = @import("std").mem.zeroes(PhysicalDeviceDataGraphProcessingEngineTypeARM),
};
pub const QueueFamilyDataGraphProcessingEnginePropertiesARM = extern struct {
    s_type: StructureType = .queue_family_data_graph_processing_engine_properties_arm,
    p_next: ?*const anyopaque = null,
    foreign_semaphore_handle_types: ExternalSemaphoreHandleTypeFlags = @import("std").mem.zeroes(ExternalSemaphoreHandleTypeFlags),
    foreign_memory_handle_types: ExternalMemoryHandleTypeFlags = @import("std").mem.zeroes(ExternalMemoryHandleTypeFlags),
};
pub const DataGraphPipelineConstantTensorSemiStructuredSparsityInfoARM = extern struct {
    s_type: StructureType = .data_graph_pipeline_constant_tensor_semi_structured_sparsity_info_arm,
    p_next: ?*const anyopaque = null,
    dimension: u32 = @import("std").mem.zeroes(u32),
    zero_count: u32 = @import("std").mem.zeroes(u32),
    group_size: u32 = @import("std").mem.zeroes(u32),
};
pub const PhysicalDeviceMultiviewPerViewRenderAreasFeaturesQCOM = extern struct {
    s_type: StructureType = .physical_device_multiview_per_view_render_areas_features_qcom,
    p_next: ?*anyopaque = null,
    multiview_per_view_render_areas: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const MultiviewPerViewRenderAreasRenderPassBeginInfoQCOM = extern struct {
    s_type: StructureType = .multiview_per_view_render_areas_render_pass_begin_info_qcom,
    p_next: ?*const anyopaque = null,
    per_view_render_area_count: u32 = @import("std").mem.zeroes(u32),
    p_per_view_render_areas: [*c]const Rect2D = @import("std").mem.zeroes([*c]const Rect2D),
};
pub const PhysicalDevicePerStageDescriptorSetFeaturesNV = extern struct {
    s_type: StructureType = .physical_device_per_stage_descriptor_set_features_nv,
    p_next: ?*anyopaque = null,
    per_stage_descriptor_set: Bool32 = @import("std").mem.zeroes(Bool32),
    dynamic_pipeline_layout: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceImageProcessing2FeaturesQCOM = extern struct {
    s_type: StructureType = .physical_device_image_processing2features_qcom,
    p_next: ?*anyopaque = null,
    texture_block_match2: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceImageProcessing2PropertiesQCOM = extern struct {
    s_type: StructureType = .physical_device_image_processing2properties_qcom,
    p_next: ?*anyopaque = null,
    max_block_match_window: Extent2D = @import("std").mem.zeroes(Extent2D),
};
pub const SamplerBlockMatchWindowCreateInfoQCOM = extern struct {
    s_type: StructureType = .sampler_block_match_window_create_info_qcom,
    p_next: ?*const anyopaque = null,
    window_extent: Extent2D = @import("std").mem.zeroes(Extent2D),
    window_compare_mode: BlockMatchWindowCompareModeQCOM = @import("std").mem.zeroes(BlockMatchWindowCompareModeQCOM),
};
pub const PhysicalDeviceCubicWeightsFeaturesQCOM = extern struct {
    s_type: StructureType = .physical_device_cubic_weights_features_qcom,
    p_next: ?*anyopaque = null,
    selectable_cubic_weights: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const SamplerCubicWeightsCreateInfoQCOM = extern struct {
    s_type: StructureType = .sampler_cubic_weights_create_info_qcom,
    p_next: ?*const anyopaque = null,
    cubic_weights: CubicFilterWeightsQCOM = @import("std").mem.zeroes(CubicFilterWeightsQCOM),
};
pub const BlitImageCubicWeightsInfoQCOM = extern struct {
    s_type: StructureType = .blit_image_cubic_weights_info_qcom,
    p_next: ?*const anyopaque = null,
    cubic_weights: CubicFilterWeightsQCOM = @import("std").mem.zeroes(CubicFilterWeightsQCOM),
};
pub const PhysicalDeviceYcbcrDegammaFeaturesQCOM = extern struct {
    s_type: StructureType = .physical_device_ycbcr_degamma_features_qcom,
    p_next: ?*anyopaque = null,
    ycbcr_degamma: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const SamplerYcbcrConversionYcbcrDegammaCreateInfoQCOM = extern struct {
    s_type: StructureType = .sampler_ycbcr_conversion_ycbcr_degamma_create_info_qcom,
    p_next: ?*anyopaque = null,
    enable_ydegamma: Bool32 = @import("std").mem.zeroes(Bool32),
    enable_cb_cr_degamma: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceCubicClampFeaturesQCOM = extern struct {
    s_type: StructureType = .physical_device_cubic_clamp_features_qcom,
    p_next: ?*anyopaque = null,
    cubic_range_clamp: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceAttachmentFeedbackLoopDynamicStateFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_attachment_feedback_loop_dynamic_state_features_ext,
    p_next: ?*anyopaque = null,
    attachment_feedback_loop_dynamic_state: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceLayeredDriverPropertiesMSFT = extern struct {
    s_type: StructureType = .physical_device_layered_driver_properties_msft,
    p_next: ?*anyopaque = null,
    underlying_api: LayeredDriverUnderlyingApiMSFT = @import("std").mem.zeroes(LayeredDriverUnderlyingApiMSFT),
};
pub const PhysicalDeviceDescriptorPoolOverallocationFeaturesNV = extern struct {
    s_type: StructureType = .physical_device_descriptor_pool_overallocation_features_nv,
    p_next: ?*anyopaque = null,
    descriptor_pool_overallocation: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceTileMemoryHeapFeaturesQCOM = extern struct {
    s_type: StructureType = .physical_device_tile_memory_heap_features_qcom,
    p_next: ?*anyopaque = null,
    tile_memory_heap: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceTileMemoryHeapPropertiesQCOM = extern struct {
    s_type: StructureType = .physical_device_tile_memory_heap_properties_qcom,
    p_next: ?*anyopaque = null,
    queue_submit_boundary: Bool32 = @import("std").mem.zeroes(Bool32),
    tile_buffer_transfers: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const TileMemoryRequirementsQCOM = extern struct {
    s_type: StructureType = .tile_memory_requirements_qcom,
    p_next: ?*anyopaque = null,
    size: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    alignment: DeviceSize = @import("std").mem.zeroes(DeviceSize),
};
pub const TileMemoryBindInfoQCOM = extern struct {
    s_type: StructureType = .tile_memory_bind_info_qcom,
    p_next: ?*const anyopaque = null,
    memory: DeviceMemory = @import("std").mem.zeroes(DeviceMemory),
};
pub const TileMemorySizeInfoQCOM = extern struct {
    s_type: StructureType = .tile_memory_size_info_qcom,
    p_next: ?*const anyopaque = null,
    size: DeviceSize = @import("std").mem.zeroes(DeviceSize),
};
pub const DisplaySurfaceStereoCreateInfoNV = extern struct {
    s_type: StructureType = .display_surface_stereo_create_info_nv,
    p_next: ?*const anyopaque = null,
    stereo_type: DisplaySurfaceStereoTypeNV = @import("std").mem.zeroes(DisplaySurfaceStereoTypeNV),
};
pub const DisplayModeStereoPropertiesNV = extern struct {
    s_type: StructureType = .display_mode_stereo_properties_nv,
    p_next: ?*const anyopaque = null,
    hdmi3_dsupported: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceRawAccessChainsFeaturesNV = extern struct {
    s_type: StructureType = .physical_device_raw_access_chains_features_nv,
    p_next: ?*anyopaque = null,
    shader_raw_access_chains: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const ExternalComputeQueueDeviceCreateInfoNV = extern struct {
    s_type: StructureType = .external_compute_queue_device_create_info_nv,
    p_next: ?*const anyopaque = null,
    reserved_external_queues: u32 = @import("std").mem.zeroes(u32),
};
pub const ExternalComputeQueueCreateInfoNV = extern struct {
    s_type: StructureType = .external_compute_queue_create_info_nv,
    p_next: ?*const anyopaque = null,
    preferred_queue: Queue = @import("std").mem.zeroes(Queue),
};
pub const ExternalComputeQueueDataParamsNV = extern struct {
    s_type: StructureType = .external_compute_queue_data_params_nv,
    p_next: ?*const anyopaque = null,
    device_index: u32 = @import("std").mem.zeroes(u32),
};
pub const PhysicalDeviceExternalComputeQueuePropertiesNV = extern struct {
    s_type: StructureType = .physical_device_external_compute_queue_properties_nv,
    p_next: ?*anyopaque = null,
    external_data_size: u32 = @import("std").mem.zeroes(u32),
    max_external_queues: u32 = @import("std").mem.zeroes(u32),
};
pub const PhysicalDeviceCommandBufferInheritanceFeaturesNV = extern struct {
    s_type: StructureType = .physical_device_command_buffer_inheritance_features_nv,
    p_next: ?*anyopaque = null,
    command_buffer_inheritance: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceShaderAtomicFloat16VectorFeaturesNV = extern struct {
    s_type: StructureType = .physical_device_shader_atomic_float16_vector_features_nv,
    p_next: ?*anyopaque = null,
    shader_float16_vector_atomics: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceShaderReplicatedCompositesFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_shader_replicated_composites_features_ext,
    p_next: ?*anyopaque = null,
    shader_replicated_composites: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceShaderFloat8FeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_shader_float8features_ext,
    p_next: ?*anyopaque = null,
    shader_float8: Bool32 = @import("std").mem.zeroes(Bool32),
    shader_float8cooperative_matrix: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceRayTracingValidationFeaturesNV = extern struct {
    s_type: StructureType = .physical_device_ray_tracing_validation_features_nv,
    p_next: ?*anyopaque = null,
    ray_tracing_validation: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceClusterAccelerationStructureFeaturesNV = extern struct {
    s_type: StructureType = .physical_device_cluster_acceleration_structure_features_nv,
    p_next: ?*anyopaque = null,
    cluster_acceleration_structure: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceClusterAccelerationStructurePropertiesNV = extern struct {
    s_type: StructureType = .physical_device_cluster_acceleration_structure_properties_nv,
    p_next: ?*anyopaque = null,
    max_vertices_per_cluster: u32 = @import("std").mem.zeroes(u32),
    max_triangles_per_cluster: u32 = @import("std").mem.zeroes(u32),
    cluster_scratch_byte_alignment: u32 = @import("std").mem.zeroes(u32),
    cluster_byte_alignment: u32 = @import("std").mem.zeroes(u32),
    cluster_template_byte_alignment: u32 = @import("std").mem.zeroes(u32),
    cluster_bottom_level_byte_alignment: u32 = @import("std").mem.zeroes(u32),
    cluster_template_bounds_byte_alignment: u32 = @import("std").mem.zeroes(u32),
    max_cluster_geometry_index: u32 = @import("std").mem.zeroes(u32),
};
pub const ClusterAccelerationStructureClustersBottomLevelInputNV = extern struct {
    s_type: StructureType = .cluster_acceleration_structure_clusters_bottom_level_input_nv,
    p_next: ?*anyopaque = null,
    max_total_cluster_count: u32 = @import("std").mem.zeroes(u32),
    max_cluster_count_per_acceleration_structure: u32 = @import("std").mem.zeroes(u32),
};
pub const ClusterAccelerationStructureTriangleClusterInputNV = extern struct {
    s_type: StructureType = .cluster_acceleration_structure_triangle_cluster_input_nv,
    p_next: ?*anyopaque = null,
    vertex_format: Format = @import("std").mem.zeroes(Format),
    max_geometry_index_value: u32 = @import("std").mem.zeroes(u32),
    max_cluster_unique_geometry_count: u32 = @import("std").mem.zeroes(u32),
    max_cluster_triangle_count: u32 = @import("std").mem.zeroes(u32),
    max_cluster_vertex_count: u32 = @import("std").mem.zeroes(u32),
    max_total_triangle_count: u32 = @import("std").mem.zeroes(u32),
    max_total_vertex_count: u32 = @import("std").mem.zeroes(u32),
    min_position_truncate_bit_count: u32 = @import("std").mem.zeroes(u32),
};
pub const ClusterAccelerationStructureMoveObjectsInputNV = extern struct {
    s_type: StructureType = .cluster_acceleration_structure_move_objects_input_nv,
    p_next: ?*anyopaque = null,
    type: ClusterAccelerationStructureTypeNV = @import("std").mem.zeroes(ClusterAccelerationStructureTypeNV),
    no_move_overlap: Bool32 = @import("std").mem.zeroes(Bool32),
    max_moved_bytes: DeviceSize = @import("std").mem.zeroes(DeviceSize),
};
pub const ClusterAccelerationStructureInputInfoNV = extern struct {
    s_type: StructureType = .cluster_acceleration_structure_input_info_nv,
    p_next: ?*anyopaque = null,
    max_acceleration_structure_count: u32 = @import("std").mem.zeroes(u32),
    flags: BuildAccelerationStructureFlagsKHR = @import("std").mem.zeroes(BuildAccelerationStructureFlagsKHR),
    op_type: ClusterAccelerationStructureOpTypeNV = @import("std").mem.zeroes(ClusterAccelerationStructureOpTypeNV),
    op_mode: ClusterAccelerationStructureOpModeNV = @import("std").mem.zeroes(ClusterAccelerationStructureOpModeNV),
    op_input: ClusterAccelerationStructureOpInputNV = @import("std").mem.zeroes(ClusterAccelerationStructureOpInputNV),
};
pub const StridedDeviceAddressRegionKHR = extern struct {
    device_address: DeviceAddress = @import("std").mem.zeroes(DeviceAddress),
    stride: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    size: DeviceSize = @import("std").mem.zeroes(DeviceSize),
};
pub const ClusterAccelerationStructureCommandsInfoNV = extern struct {
    s_type: StructureType = .cluster_acceleration_structure_commands_info_nv,
    p_next: ?*anyopaque = null,
    input: ClusterAccelerationStructureInputInfoNV = @import("std").mem.zeroes(ClusterAccelerationStructureInputInfoNV),
    dst_implicit_data: DeviceAddress = @import("std").mem.zeroes(DeviceAddress),
    scratch_data: DeviceAddress = @import("std").mem.zeroes(DeviceAddress),
    dst_addresses_array: StridedDeviceAddressRegionKHR = @import("std").mem.zeroes(StridedDeviceAddressRegionKHR),
    dst_sizes_array: StridedDeviceAddressRegionKHR = @import("std").mem.zeroes(StridedDeviceAddressRegionKHR),
    src_infos_array: StridedDeviceAddressRegionKHR = @import("std").mem.zeroes(StridedDeviceAddressRegionKHR),
    src_infos_count: DeviceAddress = @import("std").mem.zeroes(DeviceAddress),
    address_resolution_flags: ClusterAccelerationStructureAddressResolutionFlagsNV = @import("std").mem.zeroes(ClusterAccelerationStructureAddressResolutionFlagsNV),
};
pub const StridedDeviceAddressNV = extern struct {
    start_address: DeviceAddress = @import("std").mem.zeroes(DeviceAddress),
    stride_in_bytes: DeviceSize = @import("std").mem.zeroes(DeviceSize),
};
pub const ClusterAccelerationStructureMoveObjectsInfoNV = extern struct {
    src_acceleration_structure: DeviceAddress = @import("std").mem.zeroes(DeviceAddress),
};
pub const ClusterAccelerationStructureBuildClustersBottomLevelInfoNV = extern struct {
    cluster_references_count: u32 = @import("std").mem.zeroes(u32),
    cluster_references_stride: u32 = @import("std").mem.zeroes(u32),
    cluster_references: DeviceAddress = @import("std").mem.zeroes(DeviceAddress),
};
pub const ClusterAccelerationStructureGetTemplateIndicesInfoNV = extern struct {
    cluster_template_address: DeviceAddress = @import("std").mem.zeroes(DeviceAddress),
};
pub const AccelerationStructureBuildSizesInfoKHR = extern struct {
    s_type: StructureType = .acceleration_structure_build_sizes_info_khr,
    p_next: ?*const anyopaque = null,
    acceleration_structure_size: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    update_scratch_size: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    build_scratch_size: DeviceSize = @import("std").mem.zeroes(DeviceSize),
};
pub const RayTracingPipelineClusterAccelerationStructureCreateInfoNV = extern struct {
    s_type: StructureType = .ray_tracing_pipeline_cluster_acceleration_structure_create_info_nv,
    p_next: ?*anyopaque = null,
    allow_cluster_acceleration_structure: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDevicePartitionedAccelerationStructureFeaturesNV = extern struct {
    s_type: StructureType = .physical_device_partitioned_acceleration_structure_features_nv,
    p_next: ?*anyopaque = null,
    partitioned_acceleration_structure: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDevicePartitionedAccelerationStructurePropertiesNV = extern struct {
    s_type: StructureType = .physical_device_partitioned_acceleration_structure_properties_nv,
    p_next: ?*anyopaque = null,
    max_partition_count: u32 = @import("std").mem.zeroes(u32),
};
pub const PartitionedAccelerationStructureFlagsNV = extern struct {
    s_type: StructureType = .partitioned_acceleration_structure_flags_nv,
    p_next: ?*anyopaque = null,
    enable_partition_translation: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const BuildPartitionedAccelerationStructureIndirectCommandNV = extern struct {
    op_type: PartitionedAccelerationStructureOpTypeNV = @import("std").mem.zeroes(PartitionedAccelerationStructureOpTypeNV),
    arg_count: u32 = @import("std").mem.zeroes(u32),
    arg_data: StridedDeviceAddressNV = @import("std").mem.zeroes(StridedDeviceAddressNV),
};
pub const PartitionedAccelerationStructureWriteInstanceDataNV = extern struct {
    transform: TransformMatrixKHR = @import("std").mem.zeroes(TransformMatrixKHR),
    explicit_aabb: [6]f32 = @import("std").mem.zeroes([6]f32),
    instance_id: u32 = @import("std").mem.zeroes(u32),
    instance_mask: u32 = @import("std").mem.zeroes(u32),
    instance_contribution_to_hit_group_index: u32 = @import("std").mem.zeroes(u32),
    instance_flags: PartitionedAccelerationStructureInstanceFlagsNV = @import("std").mem.zeroes(PartitionedAccelerationStructureInstanceFlagsNV),
    instance_index: u32 = @import("std").mem.zeroes(u32),
    partition_index: u32 = @import("std").mem.zeroes(u32),
    acceleration_structure: DeviceAddress = @import("std").mem.zeroes(DeviceAddress),
};
pub const PartitionedAccelerationStructureUpdateInstanceDataNV = extern struct {
    instance_index: u32 = @import("std").mem.zeroes(u32),
    instance_contribution_to_hit_group_index: u32 = @import("std").mem.zeroes(u32),
    acceleration_structure: DeviceAddress = @import("std").mem.zeroes(DeviceAddress),
};
pub const PartitionedAccelerationStructureWritePartitionTranslationDataNV = extern struct {
    partition_index: u32 = @import("std").mem.zeroes(u32),
    partition_translation: [3]f32 = @import("std").mem.zeroes([3]f32),
};
pub const WriteDescriptorSetPartitionedAccelerationStructureNV = extern struct {
    s_type: StructureType = .write_descriptor_set_partitioned_acceleration_structure_nv,
    p_next: ?*anyopaque = null,
    acceleration_structure_count: u32 = @import("std").mem.zeroes(u32),
    p_acceleration_structures: [*c]const DeviceAddress = @import("std").mem.zeroes([*c]const DeviceAddress),
};
pub const PartitionedAccelerationStructureInstancesInputNV = extern struct {
    s_type: StructureType = .partitioned_acceleration_structure_instances_input_nv,
    p_next: ?*anyopaque = null,
    flags: BuildAccelerationStructureFlagsKHR = @import("std").mem.zeroes(BuildAccelerationStructureFlagsKHR),
    instance_count: u32 = @import("std").mem.zeroes(u32),
    max_instance_per_partition_count: u32 = @import("std").mem.zeroes(u32),
    partition_count: u32 = @import("std").mem.zeroes(u32),
    max_instance_in_global_partition_count: u32 = @import("std").mem.zeroes(u32),
};
pub const BuildPartitionedAccelerationStructureInfoNV = extern struct {
    s_type: StructureType = .build_partitioned_acceleration_structure_info_nv,
    p_next: ?*anyopaque = null,
    input: PartitionedAccelerationStructureInstancesInputNV = @import("std").mem.zeroes(PartitionedAccelerationStructureInstancesInputNV),
    src_acceleration_structure_data: DeviceAddress = @import("std").mem.zeroes(DeviceAddress),
    dst_acceleration_structure_data: DeviceAddress = @import("std").mem.zeroes(DeviceAddress),
    scratch_data: DeviceAddress = @import("std").mem.zeroes(DeviceAddress),
    src_infos: DeviceAddress = @import("std").mem.zeroes(DeviceAddress),
    src_infos_count: DeviceAddress = @import("std").mem.zeroes(DeviceAddress),
};
pub const PhysicalDeviceDeviceGeneratedCommandsFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_device_generated_commands_features_ext,
    p_next: ?*anyopaque = null,
    device_generated_commands: Bool32 = @import("std").mem.zeroes(Bool32),
    dynamic_generated_pipeline_layout: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceDeviceGeneratedCommandsPropertiesEXT = extern struct {
    s_type: StructureType = .physical_device_device_generated_commands_properties_ext,
    p_next: ?*anyopaque = null,
    max_indirect_pipeline_count: u32 = @import("std").mem.zeroes(u32),
    max_indirect_shader_object_count: u32 = @import("std").mem.zeroes(u32),
    max_indirect_sequence_count: u32 = @import("std").mem.zeroes(u32),
    max_indirect_commands_token_count: u32 = @import("std").mem.zeroes(u32),
    max_indirect_commands_token_offset: u32 = @import("std").mem.zeroes(u32),
    max_indirect_commands_indirect_stride: u32 = @import("std").mem.zeroes(u32),
    supported_indirect_commands_input_modes: IndirectCommandsInputModeFlagsEXT = @import("std").mem.zeroes(IndirectCommandsInputModeFlagsEXT),
    supported_indirect_commands_shader_stages: ShaderStageFlags = @import("std").mem.zeroes(ShaderStageFlags),
    supported_indirect_commands_shader_stages_pipeline_binding: ShaderStageFlags = @import("std").mem.zeroes(ShaderStageFlags),
    supported_indirect_commands_shader_stages_shader_binding: ShaderStageFlags = @import("std").mem.zeroes(ShaderStageFlags),
    device_generated_commands_transform_feedback: Bool32 = @import("std").mem.zeroes(Bool32),
    device_generated_commands_multi_draw_indirect_count: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const GeneratedCommandsMemoryRequirementsInfoEXT = extern struct {
    s_type: StructureType = .generated_commands_memory_requirements_info_ext,
    p_next: ?*const anyopaque = null,
    indirect_execution_set: IndirectExecutionSetEXT = @import("std").mem.zeroes(IndirectExecutionSetEXT),
    indirect_commands_layout: IndirectCommandsLayoutEXT = @import("std").mem.zeroes(IndirectCommandsLayoutEXT),
    max_sequence_count: u32 = @import("std").mem.zeroes(u32),
    max_draw_count: u32 = @import("std").mem.zeroes(u32),
};
pub const IndirectExecutionSetPipelineInfoEXT = extern struct {
    s_type: StructureType = .indirect_execution_set_pipeline_info_ext,
    p_next: ?*const anyopaque = null,
    initial_pipeline: Pipeline = @import("std").mem.zeroes(Pipeline),
    max_pipeline_count: u32 = @import("std").mem.zeroes(u32),
};
pub const IndirectExecutionSetShaderLayoutInfoEXT = extern struct {
    s_type: StructureType = .indirect_execution_set_shader_layout_info_ext,
    p_next: ?*const anyopaque = null,
    set_layout_count: u32 = @import("std").mem.zeroes(u32),
    p_set_layouts: [*c]const DescriptorSetLayout = @import("std").mem.zeroes([*c]const DescriptorSetLayout),
};
pub const IndirectExecutionSetShaderInfoEXT = extern struct {
    s_type: StructureType = .indirect_execution_set_shader_info_ext,
    p_next: ?*const anyopaque = null,
    shader_count: u32 = @import("std").mem.zeroes(u32),
    p_initial_shaders: [*c]const ShaderEXT = @import("std").mem.zeroes([*c]const ShaderEXT),
    p_set_layout_infos: [*c]const IndirectExecutionSetShaderLayoutInfoEXT = @import("std").mem.zeroes([*c]const IndirectExecutionSetShaderLayoutInfoEXT),
    max_shader_count: u32 = @import("std").mem.zeroes(u32),
    push_constant_range_count: u32 = @import("std").mem.zeroes(u32),
    p_push_constant_ranges: [*c]const PushConstantRange = @import("std").mem.zeroes([*c]const PushConstantRange),
};
pub const IndirectExecutionSetCreateInfoEXT = extern struct {
    s_type: StructureType = .indirect_execution_set_create_info_ext,
    p_next: ?*const anyopaque = null,
    type: IndirectExecutionSetInfoTypeEXT = @import("std").mem.zeroes(IndirectExecutionSetInfoTypeEXT),
    info: IndirectExecutionSetInfoEXT = @import("std").mem.zeroes(IndirectExecutionSetInfoEXT),
};
pub const GeneratedCommandsInfoEXT = extern struct {
    s_type: StructureType = .generated_commands_info_ext,
    p_next: ?*const anyopaque = null,
    shader_stages: ShaderStageFlags = @import("std").mem.zeroes(ShaderStageFlags),
    indirect_execution_set: IndirectExecutionSetEXT = @import("std").mem.zeroes(IndirectExecutionSetEXT),
    indirect_commands_layout: IndirectCommandsLayoutEXT = @import("std").mem.zeroes(IndirectCommandsLayoutEXT),
    indirect_address: DeviceAddress = @import("std").mem.zeroes(DeviceAddress),
    indirect_address_size: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    preprocess_address: DeviceAddress = @import("std").mem.zeroes(DeviceAddress),
    preprocess_size: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    max_sequence_count: u32 = @import("std").mem.zeroes(u32),
    sequence_count_address: DeviceAddress = @import("std").mem.zeroes(DeviceAddress),
    max_draw_count: u32 = @import("std").mem.zeroes(u32),
};
pub const WriteIndirectExecutionSetPipelineEXT = extern struct {
    s_type: StructureType = .write_indirect_execution_set_pipeline_ext,
    p_next: ?*const anyopaque = null,
    index: u32 = @import("std").mem.zeroes(u32),
    pipeline: Pipeline = @import("std").mem.zeroes(Pipeline),
};
pub const IndirectCommandsPushConstantTokenEXT = extern struct {
    update_range: PushConstantRange = @import("std").mem.zeroes(PushConstantRange),
};
pub const IndirectCommandsVertexBufferTokenEXT = extern struct {
    vertex_binding_unit: u32 = @import("std").mem.zeroes(u32),
};
pub const IndirectCommandsIndexBufferTokenEXT = extern struct {
    mode: IndirectCommandsInputModeFlagBitsEXT = @import("std").mem.zeroes(IndirectCommandsInputModeFlagBitsEXT),
};
pub const IndirectCommandsExecutionSetTokenEXT = extern struct {
    type: IndirectExecutionSetInfoTypeEXT = @import("std").mem.zeroes(IndirectExecutionSetInfoTypeEXT),
    shader_stages: ShaderStageFlags = @import("std").mem.zeroes(ShaderStageFlags),
};
pub const IndirectCommandsLayoutTokenEXT = extern struct {
    s_type: StructureType = .indirect_commands_layout_token_ext,
    p_next: ?*const anyopaque = null,
    type: IndirectCommandsTokenTypeEXT = @import("std").mem.zeroes(IndirectCommandsTokenTypeEXT),
    data: IndirectCommandsTokenDataEXT = @import("std").mem.zeroes(IndirectCommandsTokenDataEXT),
    offset: u32 = @import("std").mem.zeroes(u32),
};
pub const IndirectCommandsLayoutCreateInfoEXT = extern struct {
    s_type: StructureType = .indirect_commands_layout_create_info_ext,
    p_next: ?*const anyopaque = null,
    flags: IndirectCommandsLayoutUsageFlagsEXT = @import("std").mem.zeroes(IndirectCommandsLayoutUsageFlagsEXT),
    shader_stages: ShaderStageFlags = @import("std").mem.zeroes(ShaderStageFlags),
    indirect_stride: u32 = @import("std").mem.zeroes(u32),
    pipeline_layout: PipelineLayout = @import("std").mem.zeroes(PipelineLayout),
    token_count: u32 = @import("std").mem.zeroes(u32),
    p_tokens: [*c]const IndirectCommandsLayoutTokenEXT = @import("std").mem.zeroes([*c]const IndirectCommandsLayoutTokenEXT),
};
pub const DrawIndirectCountIndirectCommandEXT = extern struct {
    buffer_address: DeviceAddress = @import("std").mem.zeroes(DeviceAddress),
    stride: u32 = @import("std").mem.zeroes(u32),
    command_count: u32 = @import("std").mem.zeroes(u32),
};
pub const BindVertexBufferIndirectCommandEXT = extern struct {
    buffer_address: DeviceAddress = @import("std").mem.zeroes(DeviceAddress),
    size: u32 = @import("std").mem.zeroes(u32),
    stride: u32 = @import("std").mem.zeroes(u32),
};
pub const BindIndexBufferIndirectCommandEXT = extern struct {
    buffer_address: DeviceAddress = @import("std").mem.zeroes(DeviceAddress),
    size: u32 = @import("std").mem.zeroes(u32),
    index_type: IndexType = @import("std").mem.zeroes(IndexType),
};
pub const GeneratedCommandsPipelineInfoEXT = extern struct {
    s_type: StructureType = .generated_commands_pipeline_info_ext,
    p_next: ?*anyopaque = null,
    pipeline: Pipeline = @import("std").mem.zeroes(Pipeline),
};
pub const GeneratedCommandsShaderInfoEXT = extern struct {
    s_type: StructureType = .generated_commands_shader_info_ext,
    p_next: ?*anyopaque = null,
    shader_count: u32 = @import("std").mem.zeroes(u32),
    p_shaders: [*c]const ShaderEXT = @import("std").mem.zeroes([*c]const ShaderEXT),
};
pub const WriteIndirectExecutionSetShaderEXT = extern struct {
    s_type: StructureType = .write_indirect_execution_set_shader_ext,
    p_next: ?*const anyopaque = null,
    index: u32 = @import("std").mem.zeroes(u32),
    shader: ShaderEXT = @import("std").mem.zeroes(ShaderEXT),
};
pub const PhysicalDeviceImageAlignmentControlFeaturesMESA = extern struct {
    s_type: StructureType = .physical_device_image_alignment_control_features_mesa,
    p_next: ?*anyopaque = null,
    image_alignment_control: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceImageAlignmentControlPropertiesMESA = extern struct {
    s_type: StructureType = .physical_device_image_alignment_control_properties_mesa,
    p_next: ?*anyopaque = null,
    supported_image_alignment_mask: u32 = @import("std").mem.zeroes(u32),
};
pub const ImageAlignmentControlCreateInfoMESA = extern struct {
    s_type: StructureType = .image_alignment_control_create_info_mesa,
    p_next: ?*const anyopaque = null,
    maximum_requested_alignment: u32 = @import("std").mem.zeroes(u32),
};
pub const PhysicalDeviceDepthClampControlFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_depth_clamp_control_features_ext,
    p_next: ?*anyopaque = null,
    depth_clamp_control: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PipelineViewportDepthClampControlCreateInfoEXT = extern struct {
    s_type: StructureType = .pipeline_viewport_depth_clamp_control_create_info_ext,
    p_next: ?*const anyopaque = null,
    depth_clamp_mode: DepthClampModeEXT = @import("std").mem.zeroes(DepthClampModeEXT),
    p_depth_clamp_range: [*c]const DepthClampRangeEXT = @import("std").mem.zeroes([*c]const DepthClampRangeEXT),
};
pub const PhysicalDeviceHdrVividFeaturesHUAWEI = extern struct {
    s_type: StructureType = .physical_device_hdr_vivid_features_huawei,
    p_next: ?*anyopaque = null,
    hdr_vivid: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const HdrVividDynamicMetadataHUAWEI = extern struct {
    s_type: StructureType = .hdr_vivid_dynamic_metadata_huawei,
    p_next: ?*const anyopaque = null,
    dynamic_metadata_size: usize = @import("std").mem.zeroes(usize),
    p_dynamic_metadata: ?*const anyopaque = @import("std").mem.zeroes(?*const anyopaque),
};
pub const CooperativeMatrixFlexibleDimensionsPropertiesNV = extern struct {
    s_type: StructureType = .cooperative_matrix_flexible_dimensions_properties_nv,
    p_next: ?*anyopaque = null,
    mgranularity: u32 = @import("std").mem.zeroes(u32),
    ngranularity: u32 = @import("std").mem.zeroes(u32),
    kgranularity: u32 = @import("std").mem.zeroes(u32),
    atype: ComponentTypeKHR = @import("std").mem.zeroes(ComponentTypeKHR),
    btype: ComponentTypeKHR = @import("std").mem.zeroes(ComponentTypeKHR),
    ctype: ComponentTypeKHR = @import("std").mem.zeroes(ComponentTypeKHR),
    result_type: ComponentTypeKHR = @import("std").mem.zeroes(ComponentTypeKHR),
    saturating_accumulation: Bool32 = @import("std").mem.zeroes(Bool32),
    scope: ScopeKHR = @import("std").mem.zeroes(ScopeKHR),
    workgroup_invocations: u32 = @import("std").mem.zeroes(u32),
};
pub const PhysicalDeviceCooperativeMatrix2FeaturesNV = extern struct {
    s_type: StructureType = .physical_device_cooperative_matrix2features_nv,
    p_next: ?*anyopaque = null,
    cooperative_matrix_workgroup_scope: Bool32 = @import("std").mem.zeroes(Bool32),
    cooperative_matrix_flexible_dimensions: Bool32 = @import("std").mem.zeroes(Bool32),
    cooperative_matrix_reductions: Bool32 = @import("std").mem.zeroes(Bool32),
    cooperative_matrix_conversions: Bool32 = @import("std").mem.zeroes(Bool32),
    cooperative_matrix_per_element_operations: Bool32 = @import("std").mem.zeroes(Bool32),
    cooperative_matrix_tensor_addressing: Bool32 = @import("std").mem.zeroes(Bool32),
    cooperative_matrix_block_loads: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceCooperativeMatrix2PropertiesNV = extern struct {
    s_type: StructureType = .physical_device_cooperative_matrix2properties_nv,
    p_next: ?*anyopaque = null,
    cooperative_matrix_workgroup_scope_max_workgroup_size: u32 = @import("std").mem.zeroes(u32),
    cooperative_matrix_flexible_dimensions_max_dimension: u32 = @import("std").mem.zeroes(u32),
    cooperative_matrix_workgroup_scope_reserved_shared_memory: u32 = @import("std").mem.zeroes(u32),
};
pub const PhysicalDevicePipelineOpacityMicromapFeaturesARM = extern struct {
    s_type: StructureType = .physical_device_pipeline_opacity_micromap_features_arm,
    p_next: ?*anyopaque = null,
    pipeline_opacity_micromap: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceVertexAttributeRobustnessFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_vertex_attribute_robustness_features_ext,
    p_next: ?*anyopaque = null,
    vertex_attribute_robustness: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceFormatPackFeaturesARM = extern struct {
    s_type: StructureType = .physical_device_format_pack_features_arm,
    p_next: ?*anyopaque = null,
    format_pack: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceFragmentDensityMapLayeredFeaturesVALVE = extern struct {
    s_type: StructureType = .physical_device_fragment_density_map_layered_features_valve,
    p_next: ?*anyopaque = null,
    fragment_density_map_layered: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceFragmentDensityMapLayeredPropertiesVALVE = extern struct {
    s_type: StructureType = .physical_device_fragment_density_map_layered_properties_valve,
    p_next: ?*anyopaque = null,
    max_fragment_density_map_layers: u32 = @import("std").mem.zeroes(u32),
};
pub const PipelineFragmentDensityMapLayeredCreateInfoVALVE = extern struct {
    s_type: StructureType = .pipeline_fragment_density_map_layered_create_info_valve,
    p_next: ?*const anyopaque = null,
    max_fragment_density_map_layers: u32 = @import("std").mem.zeroes(u32),
};
pub const SetPresentConfigNV = extern struct {
    s_type: StructureType = .set_present_config_nv,
    p_next: ?*const anyopaque = null,
    num_frames_per_batch: u32 = @import("std").mem.zeroes(u32),
    present_config_feedback: u32 = @import("std").mem.zeroes(u32),
};
pub const PhysicalDevicePresentMeteringFeaturesNV = extern struct {
    s_type: StructureType = .physical_device_present_metering_features_nv,
    p_next: ?*anyopaque = null,
    present_metering: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const RenderingEndInfoEXT = extern struct {
    s_type: StructureType = .rendering_end_info_ext,
    p_next: ?*const anyopaque = null,
};
pub const PhysicalDeviceZeroInitializeDeviceMemoryFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_zero_initialize_device_memory_features_ext,
    p_next: ?*anyopaque = null,
    zero_initialize_device_memory: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDevicePipelineCacheIncrementalModeFeaturesSEC = extern struct {
    s_type: StructureType = .physical_device_pipeline_cache_incremental_mode_features_sec,
    p_next: ?*anyopaque = null,
    pipeline_cache_incremental_mode: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const AccelerationStructureBuildRangeInfoKHR = extern struct {
    primitive_count: u32 = @import("std").mem.zeroes(u32),
    primitive_offset: u32 = @import("std").mem.zeroes(u32),
    first_vertex: u32 = @import("std").mem.zeroes(u32),
    transform_offset: u32 = @import("std").mem.zeroes(u32),
};
pub const AccelerationStructureGeometryTrianglesDataKHR = extern struct {
    s_type: StructureType = .acceleration_structure_geometry_triangles_data_khr,
    p_next: ?*const anyopaque = null,
    vertex_format: Format = @import("std").mem.zeroes(Format),
    vertex_data: DeviceOrHostAddressConstKHR = @import("std").mem.zeroes(DeviceOrHostAddressConstKHR),
    vertex_stride: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    max_vertex: u32 = @import("std").mem.zeroes(u32),
    index_type: IndexType = @import("std").mem.zeroes(IndexType),
    index_data: DeviceOrHostAddressConstKHR = @import("std").mem.zeroes(DeviceOrHostAddressConstKHR),
    transform_data: DeviceOrHostAddressConstKHR = @import("std").mem.zeroes(DeviceOrHostAddressConstKHR),
};
pub const AccelerationStructureGeometryAabbsDataKHR = extern struct {
    s_type: StructureType = .acceleration_structure_geometry_aabbs_data_khr,
    p_next: ?*const anyopaque = null,
    data: DeviceOrHostAddressConstKHR = @import("std").mem.zeroes(DeviceOrHostAddressConstKHR),
    stride: DeviceSize = @import("std").mem.zeroes(DeviceSize),
};
pub const AccelerationStructureGeometryInstancesDataKHR = extern struct {
    s_type: StructureType = .acceleration_structure_geometry_instances_data_khr,
    p_next: ?*const anyopaque = null,
    array_of_pointers: Bool32 = @import("std").mem.zeroes(Bool32),
    data: DeviceOrHostAddressConstKHR = @import("std").mem.zeroes(DeviceOrHostAddressConstKHR),
};
pub const AccelerationStructureGeometryKHR = extern struct {
    s_type: StructureType = .acceleration_structure_geometry_khr,
    p_next: ?*const anyopaque = null,
    geometry_type: GeometryTypeKHR = @import("std").mem.zeroes(GeometryTypeKHR),
    geometry: AccelerationStructureGeometryDataKHR = @import("std").mem.zeroes(AccelerationStructureGeometryDataKHR),
    flags: GeometryFlagsKHR = @import("std").mem.zeroes(GeometryFlagsKHR),
};
pub const AccelerationStructureBuildGeometryInfoKHR = extern struct {
    s_type: StructureType = .acceleration_structure_build_geometry_info_khr,
    p_next: ?*const anyopaque = null,
    type: AccelerationStructureTypeKHR = @import("std").mem.zeroes(AccelerationStructureTypeKHR),
    flags: BuildAccelerationStructureFlagsKHR = @import("std").mem.zeroes(BuildAccelerationStructureFlagsKHR),
    mode: BuildAccelerationStructureModeKHR = @import("std").mem.zeroes(BuildAccelerationStructureModeKHR),
    src_acceleration_structure: AccelerationStructureKHR = @import("std").mem.zeroes(AccelerationStructureKHR),
    dst_acceleration_structure: AccelerationStructureKHR = @import("std").mem.zeroes(AccelerationStructureKHR),
    geometry_count: u32 = @import("std").mem.zeroes(u32),
    p_geometries: [*c]const AccelerationStructureGeometryKHR = @import("std").mem.zeroes([*c]const AccelerationStructureGeometryKHR),
    pp_geometries: [*c]const [*c]const AccelerationStructureGeometryKHR = @import("std").mem.zeroes([*c]const [*c]const AccelerationStructureGeometryKHR),
    scratch_data: DeviceOrHostAddressKHR = @import("std").mem.zeroes(DeviceOrHostAddressKHR),
};
pub const AccelerationStructureCreateInfoKHR = extern struct {
    s_type: StructureType = .acceleration_structure_create_info_khr,
    p_next: ?*const anyopaque = null,
    create_flags: AccelerationStructureCreateFlagsKHR = @import("std").mem.zeroes(AccelerationStructureCreateFlagsKHR),
    buffer: Buffer = @import("std").mem.zeroes(Buffer),
    offset: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    size: DeviceSize = @import("std").mem.zeroes(DeviceSize),
    type: AccelerationStructureTypeKHR = @import("std").mem.zeroes(AccelerationStructureTypeKHR),
    device_address: DeviceAddress = @import("std").mem.zeroes(DeviceAddress),
};
pub const WriteDescriptorSetAccelerationStructureKHR = extern struct {
    s_type: StructureType = .write_descriptor_set_acceleration_structure_khr,
    p_next: ?*const anyopaque = null,
    acceleration_structure_count: u32 = @import("std").mem.zeroes(u32),
    p_acceleration_structures: [*c]const AccelerationStructureKHR = @import("std").mem.zeroes([*c]const AccelerationStructureKHR),
};
pub const PhysicalDeviceAccelerationStructureFeaturesKHR = extern struct {
    s_type: StructureType = .physical_device_acceleration_structure_features_khr,
    p_next: ?*anyopaque = null,
    acceleration_structure: Bool32 = @import("std").mem.zeroes(Bool32),
    acceleration_structure_capture_replay: Bool32 = @import("std").mem.zeroes(Bool32),
    acceleration_structure_indirect_build: Bool32 = @import("std").mem.zeroes(Bool32),
    acceleration_structure_host_commands: Bool32 = @import("std").mem.zeroes(Bool32),
    descriptor_binding_acceleration_structure_update_after_bind: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceAccelerationStructurePropertiesKHR = extern struct {
    s_type: StructureType = .physical_device_acceleration_structure_properties_khr,
    p_next: ?*anyopaque = null,
    max_geometry_count: u64 = @import("std").mem.zeroes(u64),
    max_instance_count: u64 = @import("std").mem.zeroes(u64),
    max_primitive_count: u64 = @import("std").mem.zeroes(u64),
    max_per_stage_descriptor_acceleration_structures: u32 = @import("std").mem.zeroes(u32),
    max_per_stage_descriptor_update_after_bind_acceleration_structures: u32 = @import("std").mem.zeroes(u32),
    max_descriptor_set_acceleration_structures: u32 = @import("std").mem.zeroes(u32),
    max_descriptor_set_update_after_bind_acceleration_structures: u32 = @import("std").mem.zeroes(u32),
    min_acceleration_structure_scratch_offset_alignment: u32 = @import("std").mem.zeroes(u32),
};
pub const AccelerationStructureDeviceAddressInfoKHR = extern struct {
    s_type: StructureType = .acceleration_structure_device_address_info_khr,
    p_next: ?*const anyopaque = null,
    acceleration_structure: AccelerationStructureKHR = @import("std").mem.zeroes(AccelerationStructureKHR),
};
pub const AccelerationStructureVersionInfoKHR = extern struct {
    s_type: StructureType = .acceleration_structure_version_info_khr,
    p_next: ?*const anyopaque = null,
    p_version_data: [*c]const u8 = @import("std").mem.zeroes([*c]const u8),
};
pub const CopyAccelerationStructureToMemoryInfoKHR = extern struct {
    s_type: StructureType = .copy_acceleration_structure_to_memory_info_khr,
    p_next: ?*const anyopaque = null,
    src: AccelerationStructureKHR = @import("std").mem.zeroes(AccelerationStructureKHR),
    dst: DeviceOrHostAddressKHR = @import("std").mem.zeroes(DeviceOrHostAddressKHR),
    mode: CopyAccelerationStructureModeKHR = @import("std").mem.zeroes(CopyAccelerationStructureModeKHR),
};
pub const CopyMemoryToAccelerationStructureInfoKHR = extern struct {
    s_type: StructureType = .copy_memory_to_acceleration_structure_info_khr,
    p_next: ?*const anyopaque = null,
    src: DeviceOrHostAddressConstKHR = @import("std").mem.zeroes(DeviceOrHostAddressConstKHR),
    dst: AccelerationStructureKHR = @import("std").mem.zeroes(AccelerationStructureKHR),
    mode: CopyAccelerationStructureModeKHR = @import("std").mem.zeroes(CopyAccelerationStructureModeKHR),
};
pub const CopyAccelerationStructureInfoKHR = extern struct {
    s_type: StructureType = .copy_acceleration_structure_info_khr,
    p_next: ?*const anyopaque = null,
    src: AccelerationStructureKHR = @import("std").mem.zeroes(AccelerationStructureKHR),
    dst: AccelerationStructureKHR = @import("std").mem.zeroes(AccelerationStructureKHR),
    mode: CopyAccelerationStructureModeKHR = @import("std").mem.zeroes(CopyAccelerationStructureModeKHR),
};
pub const RayTracingShaderGroupCreateInfoKHR = extern struct {
    s_type: StructureType = .ray_tracing_shader_group_create_info_khr,
    p_next: ?*const anyopaque = null,
    type: RayTracingShaderGroupTypeKHR = @import("std").mem.zeroes(RayTracingShaderGroupTypeKHR),
    general_shader: u32 = @import("std").mem.zeroes(u32),
    closest_hit_shader: u32 = @import("std").mem.zeroes(u32),
    any_hit_shader: u32 = @import("std").mem.zeroes(u32),
    intersection_shader: u32 = @import("std").mem.zeroes(u32),
    p_shader_group_capture_replay_handle: ?*const anyopaque = @import("std").mem.zeroes(?*const anyopaque),
};
pub const RayTracingPipelineInterfaceCreateInfoKHR = extern struct {
    s_type: StructureType = .ray_tracing_pipeline_interface_create_info_khr,
    p_next: ?*const anyopaque = null,
    max_pipeline_ray_payload_size: u32 = @import("std").mem.zeroes(u32),
    max_pipeline_ray_hit_attribute_size: u32 = @import("std").mem.zeroes(u32),
};
pub const RayTracingPipelineCreateInfoKHR = extern struct {
    s_type: StructureType = .ray_tracing_pipeline_create_info_khr,
    p_next: ?*const anyopaque = null,
    flags: PipelineCreateFlags = @import("std").mem.zeroes(PipelineCreateFlags),
    stage_count: u32 = @import("std").mem.zeroes(u32),
    p_stages: [*c]const PipelineShaderStageCreateInfo = @import("std").mem.zeroes([*c]const PipelineShaderStageCreateInfo),
    group_count: u32 = @import("std").mem.zeroes(u32),
    p_groups: [*c]const RayTracingShaderGroupCreateInfoKHR = @import("std").mem.zeroes([*c]const RayTracingShaderGroupCreateInfoKHR),
    max_pipeline_ray_recursion_depth: u32 = @import("std").mem.zeroes(u32),
    p_library_info: [*c]const PipelineLibraryCreateInfoKHR = @import("std").mem.zeroes([*c]const PipelineLibraryCreateInfoKHR),
    p_library_interface: [*c]const RayTracingPipelineInterfaceCreateInfoKHR = @import("std").mem.zeroes([*c]const RayTracingPipelineInterfaceCreateInfoKHR),
    p_dynamic_state: [*c]const PipelineDynamicStateCreateInfo = @import("std").mem.zeroes([*c]const PipelineDynamicStateCreateInfo),
    layout: PipelineLayout = @import("std").mem.zeroes(PipelineLayout),
    base_pipeline_handle: Pipeline = @import("std").mem.zeroes(Pipeline),
    base_pipeline_index: i32 = @import("std").mem.zeroes(i32),
};
pub const PhysicalDeviceRayTracingPipelineFeaturesKHR = extern struct {
    s_type: StructureType = .physical_device_ray_tracing_pipeline_features_khr,
    p_next: ?*anyopaque = null,
    ray_tracing_pipeline: Bool32 = @import("std").mem.zeroes(Bool32),
    ray_tracing_pipeline_shader_group_handle_capture_replay: Bool32 = @import("std").mem.zeroes(Bool32),
    ray_tracing_pipeline_shader_group_handle_capture_replay_mixed: Bool32 = @import("std").mem.zeroes(Bool32),
    ray_tracing_pipeline_trace_rays_indirect: Bool32 = @import("std").mem.zeroes(Bool32),
    ray_traversal_primitive_culling: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceRayTracingPipelinePropertiesKHR = extern struct {
    s_type: StructureType = .physical_device_ray_tracing_pipeline_properties_khr,
    p_next: ?*anyopaque = null,
    shader_group_handle_size: u32 = @import("std").mem.zeroes(u32),
    max_ray_recursion_depth: u32 = @import("std").mem.zeroes(u32),
    max_shader_group_stride: u32 = @import("std").mem.zeroes(u32),
    shader_group_base_alignment: u32 = @import("std").mem.zeroes(u32),
    shader_group_handle_capture_replay_size: u32 = @import("std").mem.zeroes(u32),
    max_ray_dispatch_invocation_count: u32 = @import("std").mem.zeroes(u32),
    shader_group_handle_alignment: u32 = @import("std").mem.zeroes(u32),
    max_ray_hit_attribute_size: u32 = @import("std").mem.zeroes(u32),
};
pub const TraceRaysIndirectCommandKHR = extern struct {
    width: u32 = @import("std").mem.zeroes(u32),
    height: u32 = @import("std").mem.zeroes(u32),
    depth: u32 = @import("std").mem.zeroes(u32),
};
pub const PhysicalDeviceRayQueryFeaturesKHR = extern struct {
    s_type: StructureType = .physical_device_ray_query_features_khr,
    p_next: ?*anyopaque = null,
    ray_query: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceMeshShaderFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_mesh_shader_features_ext,
    p_next: ?*anyopaque = null,
    task_shader: Bool32 = @import("std").mem.zeroes(Bool32),
    mesh_shader: Bool32 = @import("std").mem.zeroes(Bool32),
    multiview_mesh_shader: Bool32 = @import("std").mem.zeroes(Bool32),
    primitive_fragment_shading_rate_mesh_shader: Bool32 = @import("std").mem.zeroes(Bool32),
    mesh_shader_queries: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const PhysicalDeviceMeshShaderPropertiesEXT = extern struct {
    s_type: StructureType = .physical_device_mesh_shader_properties_ext,
    p_next: ?*anyopaque = null,
    max_task_work_group_total_count: u32 = @import("std").mem.zeroes(u32),
    max_task_work_group_count: [3]u32 = @import("std").mem.zeroes([3]u32),
    max_task_work_group_invocations: u32 = @import("std").mem.zeroes(u32),
    max_task_work_group_size: [3]u32 = @import("std").mem.zeroes([3]u32),
    max_task_payload_size: u32 = @import("std").mem.zeroes(u32),
    max_task_shared_memory_size: u32 = @import("std").mem.zeroes(u32),
    max_task_payload_and_shared_memory_size: u32 = @import("std").mem.zeroes(u32),
    max_mesh_work_group_total_count: u32 = @import("std").mem.zeroes(u32),
    max_mesh_work_group_count: [3]u32 = @import("std").mem.zeroes([3]u32),
    max_mesh_work_group_invocations: u32 = @import("std").mem.zeroes(u32),
    max_mesh_work_group_size: [3]u32 = @import("std").mem.zeroes([3]u32),
    max_mesh_shared_memory_size: u32 = @import("std").mem.zeroes(u32),
    max_mesh_payload_and_shared_memory_size: u32 = @import("std").mem.zeroes(u32),
    max_mesh_output_memory_size: u32 = @import("std").mem.zeroes(u32),
    max_mesh_payload_and_output_memory_size: u32 = @import("std").mem.zeroes(u32),
    max_mesh_output_components: u32 = @import("std").mem.zeroes(u32),
    max_mesh_output_vertices: u32 = @import("std").mem.zeroes(u32),
    max_mesh_output_primitives: u32 = @import("std").mem.zeroes(u32),
    max_mesh_output_layers: u32 = @import("std").mem.zeroes(u32),
    max_mesh_multiview_view_count: u32 = @import("std").mem.zeroes(u32),
    mesh_output_per_vertex_granularity: u32 = @import("std").mem.zeroes(u32),
    mesh_output_per_primitive_granularity: u32 = @import("std").mem.zeroes(u32),
    max_preferred_task_work_group_invocations: u32 = @import("std").mem.zeroes(u32),
    max_preferred_mesh_work_group_invocations: u32 = @import("std").mem.zeroes(u32),
    prefers_local_invocation_vertex_output: Bool32 = @import("std").mem.zeroes(Bool32),
    prefers_local_invocation_primitive_output: Bool32 = @import("std").mem.zeroes(Bool32),
    prefers_compact_vertex_output: Bool32 = @import("std").mem.zeroes(Bool32),
    prefers_compact_primitive_output: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const DrawMeshTasksIndirectCommandEXT = extern struct {
    group_count_x: u32 = @import("std").mem.zeroes(u32),
    group_count_y: u32 = @import("std").mem.zeroes(u32),
    group_count_z: u32 = @import("std").mem.zeroes(u32),
};
pub const Win32SurfaceCreateInfoKHR = extern struct {
    s_type: StructureType = .win32_surface_create_info_khr,
    p_next: ?*const anyopaque = null,
    flags: Win32SurfaceCreateFlagsKHR = @import("std").mem.zeroes(Win32SurfaceCreateFlagsKHR),
    hinstance: HINSTANCE = @import("std").mem.zeroes(HINSTANCE),
    hwnd: HWND = @import("std").mem.zeroes(HWND),
};
pub const ImportMemoryWin32HandleInfoKHR = extern struct {
    s_type: StructureType = .import_memory_win32_handle_info_khr,
    p_next: ?*const anyopaque = null,
    handle_type: ExternalMemoryHandleTypeFlagBits = @import("std").mem.zeroes(ExternalMemoryHandleTypeFlagBits),
    handle: HANDLE = @import("std").mem.zeroes(HANDLE),
    name: LPCWSTR = @import("std").mem.zeroes(LPCWSTR),
};
pub const ExportMemoryWin32HandleInfoKHR = extern struct {
    s_type: StructureType = .export_memory_win32_handle_info_khr,
    p_next: ?*const anyopaque = null,
    p_attributes: [*c]const SECURITY_ATTRIBUTES = @import("std").mem.zeroes([*c]const SECURITY_ATTRIBUTES),
    dw_access: DWORD = @import("std").mem.zeroes(DWORD),
    name: LPCWSTR = @import("std").mem.zeroes(LPCWSTR),
};
pub const MemoryWin32HandlePropertiesKHR = extern struct {
    s_type: StructureType = .memory_win32_handle_properties_khr,
    p_next: ?*anyopaque = null,
    memory_type_bits: u32 = @import("std").mem.zeroes(u32),
};
pub const MemoryGetWin32HandleInfoKHR = extern struct {
    s_type: StructureType = .memory_get_win32_handle_info_khr,
    p_next: ?*const anyopaque = null,
    memory: DeviceMemory = @import("std").mem.zeroes(DeviceMemory),
    handle_type: ExternalMemoryHandleTypeFlagBits = @import("std").mem.zeroes(ExternalMemoryHandleTypeFlagBits),
};
pub const Win32KeyedMutexAcquireReleaseInfoKHR = extern struct {
    s_type: StructureType = .win32_keyed_mutex_acquire_release_info_khr,
    p_next: ?*const anyopaque = null,
    acquire_count: u32 = @import("std").mem.zeroes(u32),
    p_acquire_syncs: [*c]const DeviceMemory = @import("std").mem.zeroes([*c]const DeviceMemory),
    p_acquire_keys: [*c]const u64 = @import("std").mem.zeroes([*c]const u64),
    p_acquire_timeouts: [*c]const u32 = @import("std").mem.zeroes([*c]const u32),
    release_count: u32 = @import("std").mem.zeroes(u32),
    p_release_syncs: [*c]const DeviceMemory = @import("std").mem.zeroes([*c]const DeviceMemory),
    p_release_keys: [*c]const u64 = @import("std").mem.zeroes([*c]const u64),
};
pub const ImportSemaphoreWin32HandleInfoKHR = extern struct {
    s_type: StructureType = .import_semaphore_win32_handle_info_khr,
    p_next: ?*const anyopaque = null,
    semaphore: Semaphore = @import("std").mem.zeroes(Semaphore),
    flags: SemaphoreImportFlags = @import("std").mem.zeroes(SemaphoreImportFlags),
    handle_type: ExternalSemaphoreHandleTypeFlagBits = @import("std").mem.zeroes(ExternalSemaphoreHandleTypeFlagBits),
    handle: HANDLE = @import("std").mem.zeroes(HANDLE),
    name: LPCWSTR = @import("std").mem.zeroes(LPCWSTR),
};
pub const ExportSemaphoreWin32HandleInfoKHR = extern struct {
    s_type: StructureType = .export_semaphore_win32_handle_info_khr,
    p_next: ?*const anyopaque = null,
    p_attributes: [*c]const SECURITY_ATTRIBUTES = @import("std").mem.zeroes([*c]const SECURITY_ATTRIBUTES),
    dw_access: DWORD = @import("std").mem.zeroes(DWORD),
    name: LPCWSTR = @import("std").mem.zeroes(LPCWSTR),
};
pub const D3D12FenceSubmitInfoKHR = extern struct {
    s_type: StructureType = .d3_d12_fence_submit_info_khr,
    p_next: ?*const anyopaque = null,
    wait_semaphore_values_count: u32 = @import("std").mem.zeroes(u32),
    p_wait_semaphore_values: [*c]const u64 = @import("std").mem.zeroes([*c]const u64),
    signal_semaphore_values_count: u32 = @import("std").mem.zeroes(u32),
    p_signal_semaphore_values: [*c]const u64 = @import("std").mem.zeroes([*c]const u64),
};
pub const SemaphoreGetWin32HandleInfoKHR = extern struct {
    s_type: StructureType = .semaphore_get_win32_handle_info_khr,
    p_next: ?*const anyopaque = null,
    semaphore: Semaphore = @import("std").mem.zeroes(Semaphore),
    handle_type: ExternalSemaphoreHandleTypeFlagBits = @import("std").mem.zeroes(ExternalSemaphoreHandleTypeFlagBits),
};
pub const ImportFenceWin32HandleInfoKHR = extern struct {
    s_type: StructureType = .import_fence_win32_handle_info_khr,
    p_next: ?*const anyopaque = null,
    fence: Fence = @import("std").mem.zeroes(Fence),
    flags: FenceImportFlags = @import("std").mem.zeroes(FenceImportFlags),
    handle_type: ExternalFenceHandleTypeFlagBits = @import("std").mem.zeroes(ExternalFenceHandleTypeFlagBits),
    handle: HANDLE = @import("std").mem.zeroes(HANDLE),
    name: LPCWSTR = @import("std").mem.zeroes(LPCWSTR),
};
pub const ExportFenceWin32HandleInfoKHR = extern struct {
    s_type: StructureType = .export_fence_win32_handle_info_khr,
    p_next: ?*const anyopaque = null,
    p_attributes: [*c]const SECURITY_ATTRIBUTES = @import("std").mem.zeroes([*c]const SECURITY_ATTRIBUTES),
    dw_access: DWORD = @import("std").mem.zeroes(DWORD),
    name: LPCWSTR = @import("std").mem.zeroes(LPCWSTR),
};
pub const FenceGetWin32HandleInfoKHR = extern struct {
    s_type: StructureType = .fence_get_win32_handle_info_khr,
    p_next: ?*const anyopaque = null,
    fence: Fence = @import("std").mem.zeroes(Fence),
    handle_type: ExternalFenceHandleTypeFlagBits = @import("std").mem.zeroes(ExternalFenceHandleTypeFlagBits),
};
pub const ImportMemoryWin32HandleInfoNV = extern struct {
    s_type: StructureType = .import_memory_win32_handle_info_nv,
    p_next: ?*const anyopaque = null,
    handle_type: ExternalMemoryHandleTypeFlagsNV = @import("std").mem.zeroes(ExternalMemoryHandleTypeFlagsNV),
    handle: HANDLE = @import("std").mem.zeroes(HANDLE),
};
pub const ExportMemoryWin32HandleInfoNV = extern struct {
    s_type: StructureType = .export_memory_win32_handle_info_nv,
    p_next: ?*const anyopaque = null,
    p_attributes: [*c]const SECURITY_ATTRIBUTES = @import("std").mem.zeroes([*c]const SECURITY_ATTRIBUTES),
    dw_access: DWORD = @import("std").mem.zeroes(DWORD),
};
pub const Win32KeyedMutexAcquireReleaseInfoNV = extern struct {
    s_type: StructureType = .win32_keyed_mutex_acquire_release_info_nv,
    p_next: ?*const anyopaque = null,
    acquire_count: u32 = @import("std").mem.zeroes(u32),
    p_acquire_syncs: [*c]const DeviceMemory = @import("std").mem.zeroes([*c]const DeviceMemory),
    p_acquire_keys: [*c]const u64 = @import("std").mem.zeroes([*c]const u64),
    p_acquire_timeout_milliseconds: [*c]const u32 = @import("std").mem.zeroes([*c]const u32),
    release_count: u32 = @import("std").mem.zeroes(u32),
    p_release_syncs: [*c]const DeviceMemory = @import("std").mem.zeroes([*c]const DeviceMemory),
    p_release_keys: [*c]const u64 = @import("std").mem.zeroes([*c]const u64),
};
pub const SurfaceFullScreenExclusiveInfoEXT = extern struct {
    s_type: StructureType = .surface_full_screen_exclusive_info_ext,
    p_next: ?*anyopaque = null,
    full_screen_exclusive: FullScreenExclusiveEXT = @import("std").mem.zeroes(FullScreenExclusiveEXT),
};
pub const SurfaceCapabilitiesFullScreenExclusiveEXT = extern struct {
    s_type: StructureType = .surface_capabilities_full_screen_exclusive_ext,
    p_next: ?*anyopaque = null,
    full_screen_exclusive_supported: Bool32 = @import("std").mem.zeroes(Bool32),
};
pub const SurfaceFullScreenExclusiveWin32InfoEXT = extern struct {
    s_type: StructureType = .surface_full_screen_exclusive_win32_info_ext,
    p_next: ?*const anyopaque = null,
    hmonitor: HMONITOR = @import("std").mem.zeroes(HMONITOR),
};
