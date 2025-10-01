pub const ClearColorValue = extern union {
    float32: [4]f32,
    int32: [4]i32,
    uint32: [4]u32,
};
pub const ClearValue = extern union {
    color: ClearColorValue,
    depth_stencil: ClearDepthStencilValue,
};
pub const PerformanceCounterResultKHR = extern union {
    int32: i32,
    int64: i64,
    uint32: u32,
    uint64: u64,
    float32: f32,
    float64: f64,
};
pub const PipelineExecutableStatisticValueKHR = extern union {
    b32: Bool32,
    i64: i64,
    u64: u64,
    f64: f64,
};
pub const PerformanceValueDataINTEL = extern union {
    value32: u32,
    value64: u64,
    value_float: f32,
    value_bool: Bool32,
    value_string: [*c]const u8,
};
pub const DescriptorDataEXT = extern union {
    p_sampler: [*c]const Sampler,
    p_combined_image_sampler: [*c]const DescriptorImageInfo,
    p_input_attachment_image: [*c]const DescriptorImageInfo,
    p_sampled_image: [*c]const DescriptorImageInfo,
    p_storage_image: [*c]const DescriptorImageInfo,
    p_uniform_texel_buffer: [*c]const DescriptorAddressInfoEXT,
    p_storage_texel_buffer: [*c]const DescriptorAddressInfoEXT,
    p_uniform_buffer: [*c]const DescriptorAddressInfoEXT,
    p_storage_buffer: [*c]const DescriptorAddressInfoEXT,
    acceleration_structure: DeviceAddress,
};
pub const DeviceOrHostAddressConstKHR = extern union {
    device_address: DeviceAddress,
    host_address: ?*const anyopaque,
};
pub const AccelerationStructureMotionInstanceDataNV = extern union {
    static_instance: AccelerationStructureInstanceKHR,
    matrix_motion_instance: AccelerationStructureMatrixMotionInstanceNV,
    srt_motion_instance: AccelerationStructureSRTMotionInstanceNV,
};
pub const DeviceOrHostAddressKHR = extern union {
    device_address: DeviceAddress,
    host_address: ?*anyopaque,
};
pub const ClusterAccelerationStructureOpInputNV = extern union {
    p_clusters_bottom_level: [*c]ClusterAccelerationStructureClustersBottomLevelInputNV,
    p_triangle_clusters: [*c]ClusterAccelerationStructureTriangleClusterInputNV,
    p_move_objects: [*c]ClusterAccelerationStructureMoveObjectsInputNV,
};
pub const IndirectExecutionSetInfoEXT = extern union {
    p_pipeline_info: [*c]const IndirectExecutionSetPipelineInfoEXT,
    p_shader_info: [*c]const IndirectExecutionSetShaderInfoEXT,
};
pub const IndirectCommandsTokenDataEXT = extern union {
    p_push_constant: [*c]const IndirectCommandsPushConstantTokenEXT,
    p_vertex_buffer: [*c]const IndirectCommandsVertexBufferTokenEXT,
    p_index_buffer: [*c]const IndirectCommandsIndexBufferTokenEXT,
    p_execution_set: [*c]const IndirectCommandsExecutionSetTokenEXT,
};
pub const AccelerationStructureGeometryDataKHR = extern union {
    triangles: AccelerationStructureGeometryTrianglesDataKHR,
    aabbs: AccelerationStructureGeometryAabbsDataKHR,
    instances: AccelerationStructureGeometryInstancesDataKHR,
};
