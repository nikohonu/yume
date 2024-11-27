const std = @import("std");
const c_gl = @cImport({
    @cInclude("GL/glew.h");
});

const gl = @This();

pub const Bitfield = enum(u32) {
    COLOR_BUFFER_BIT = c_gl.GL_COLOR_BUFFER_BIT,
};

pub const ShaderType = enum(u32) {
    VERTEX_SHADER = c_gl.GL_VERTEX_SHADER,
    FRAGMENT_SHADER = c_gl.GL_FRAGMENT_SHADER,
};

pub const BufferBindingTarget = enum(u32) {
    ARRAY_BUFFER = c_gl.GL_ARRAY_BUFFER,
    ELEMENT_ARRAY_BUFFER = c_gl.GL_ELEMENT_ARRAY_BUFFER,
};

pub const Usage = enum(u32) {
    STATIC_DRAW = c_gl.GL_STATIC_DRAW,
};

pub const DataType = enum(u32) {
    FLOAT = c_gl.GL_FLOAT,
    UNSIGNED_INT = c_gl.GL_UNSIGNED_INT,
};

pub const Mode = enum(u32) {
    TRIANGLES = c_gl.GL_TRIANGLES,
};

pub const Parameter = enum(u32) {
    active_texture = c_gl.GL_ACTIVE_TEXTURE,
    aliased_line_width_range = c_gl.GL_ALIASED_LINE_WIDTH_RANGE,
    array_buffer_gl = c_gl.GL_ARRAY_BUFFER_BINDING,
    blend = c_gl.GL_BLEND,
    blend_color = c_gl.GL_BLEND_COLOR,
    blend_dst_alpha = c_gl.GL_BLEND_DST_ALPHA,
    blend_dst_rgb = c_gl.GL_BLEND_DST_RGB,
    blend_equation_alpha = c_gl.GL_BLEND_EQUATION_ALPHA,
    blend_equation_rgb = c_gl.GL_BLEND_EQUATION_RGB,
    blend_src_alpha = c_gl.GL_BLEND_SRC_ALPHA,
    blend_src_rgb = c_gl.GL_BLEND_SRC_RGB,
    color_clear_value = c_gl.GL_COLOR_CLEAR_VALUE,
    color_logic_op = c_gl.GL_COLOR_LOGIC_OP,
    color_writemask = c_gl.GL_COLOR_WRITEMASK,
    compressed_texture_formats = c_gl.GL_COMPRESSED_TEXTURE_FORMATS,
    context_flags = c_gl.GL_CONTEXT_FLAGS,
    cull_face = c_gl.GL_CULL_FACE,
    current_program = c_gl.GL_CURRENT_PROGRAM,
    depth_clear_value = c_gl.GL_DEPTH_CLEAR_VALUE,
    depth_func = c_gl.GL_DEPTH_FUNC,
    depth_range = c_gl.GL_DEPTH_RANGE,
    depth_test = c_gl.GL_DEPTH_TEST,
    depth_writemask = c_gl.GL_DEPTH_WRITEMASK,
    dither = c_gl.GL_DITHER,
    doublebuffer = c_gl.GL_DOUBLEBUFFER,
    draw_buffer = c_gl.GL_DRAW_BUFFER,
    draw_buffer0 = c_gl.GL_DRAW_BUFFER0,
    draw_buffer1 = c_gl.GL_DRAW_BUFFER1,
    draw_buffer2 = c_gl.GL_DRAW_BUFFER2,
    draw_buffer3 = c_gl.GL_DRAW_BUFFER3,
    draw_buffer4 = c_gl.GL_DRAW_BUFFER4,
    draw_buffer5 = c_gl.GL_DRAW_BUFFER5,
    draw_buffer6 = c_gl.GL_DRAW_BUFFER6,
    draw_buffer7 = c_gl.GL_DRAW_BUFFER7,
    draw_buffer8 = c_gl.GL_DRAW_BUFFER8,
    draw_buffer9 = c_gl.GL_DRAW_BUFFER9,
    draw_buffer10 = c_gl.GL_DRAW_BUFFER10,
    draw_buffer11 = c_gl.GL_DRAW_BUFFER11,
    draw_buffer12 = c_gl.GL_DRAW_BUFFER12,
    draw_buffer13 = c_gl.GL_DRAW_BUFFER13,
    draw_buffer14 = c_gl.GL_DRAW_BUFFER14,
    draw_buffer15 = c_gl.GL_DRAW_BUFFER15,
    draw_framebuffer_gl = c_gl.GL_DRAW_FRAMEBUFFER_BINDING,
    element_array_buffer_gl = c_gl.GL_ELEMENT_ARRAY_BUFFER_BINDING,
    fragment_shader_derivative_hint = c_gl.GL_FRAGMENT_SHADER_DERIVATIVE_HINT,
    line_smooth = c_gl.GL_LINE_SMOOTH,
    line_smooth_hint = c_gl.GL_LINE_SMOOTH_HINT,
    line_width = c_gl.GL_LINE_WIDTH,
    logic_op_mode = c_gl.GL_LOGIC_OP_MODE,
    major_version = c_gl.GL_MAJOR_VERSION,
    max_3d_texture_size = c_gl.GL_MAX_3D_TEXTURE_SIZE,
    max_array_texture_layers = c_gl.GL_MAX_ARRAY_TEXTURE_LAYERS,
    max_clip_distances = c_gl.GL_MAX_CLIP_DISTANCES,
    max_color_texture_samples = c_gl.GL_MAX_COLOR_TEXTURE_SAMPLES,
    max_combined_fragment_uniform_components = c_gl.GL_MAX_COMBINED_FRAGMENT_UNIFORM_COMPONENTS,
    max_combined_geometry_uniform_components = c_gl.GL_MAX_COMBINED_GEOMETRY_UNIFORM_COMPONENTS,
    max_combined_texture_image_units = c_gl.GL_MAX_COMBINED_TEXTURE_IMAGE_UNITS,
    max_combined_uniform_blocks = c_gl.GL_MAX_COMBINED_UNIFORM_BLOCKS,
    max_combined_vertex_uniform_components = c_gl.GL_MAX_COMBINED_VERTEX_UNIFORM_COMPONENTS,
    max_cube_map_texture_size = c_gl.GL_MAX_CUBE_MAP_TEXTURE_SIZE,
    max_depth_texture_samples = c_gl.GL_MAX_DEPTH_TEXTURE_SAMPLES,
    max_draw_buffers = c_gl.GL_MAX_DRAW_BUFFERS,
    max_dual_source_draw_buffers = c_gl.GL_MAX_DUAL_SOURCE_DRAW_BUFFERS,
    max_elements_indices = c_gl.GL_MAX_ELEMENTS_INDICES,
    max_elements_vertices = c_gl.GL_MAX_ELEMENTS_VERTICES,
    max_fragment_input_components = c_gl.GL_MAX_FRAGMENT_INPUT_COMPONENTS,
    max_fragment_uniform_blocks = c_gl.GL_MAX_FRAGMENT_UNIFORM_BLOCKS,
    max_fragment_uniform_components = c_gl.GL_MAX_FRAGMENT_UNIFORM_COMPONENTS,
    max_geometry_input_components = c_gl.GL_MAX_GEOMETRY_INPUT_COMPONENTS,
    max_geometry_output_components = c_gl.GL_MAX_GEOMETRY_OUTPUT_COMPONENTS,
    max_geometry_texture_image_units = c_gl.GL_MAX_GEOMETRY_TEXTURE_IMAGE_UNITS,
    max_geometry_uniform_blocks = c_gl.GL_MAX_GEOMETRY_UNIFORM_BLOCKS,
    max_geometry_uniform_components = c_gl.GL_MAX_GEOMETRY_UNIFORM_COMPONENTS,
    max_integer_samples = c_gl.GL_MAX_INTEGER_SAMPLES,
    max_program_texel_offset = c_gl.GL_MAX_PROGRAM_TEXEL_OFFSET,
    max_rectangle_texture_size = c_gl.GL_MAX_RECTANGLE_TEXTURE_SIZE,
    max_renderbuffer_size = c_gl.GL_MAX_RENDERBUFFER_SIZE,
    max_sample_mask_words = c_gl.GL_MAX_SAMPLE_MASK_WORDS,
    max_server_wait_timeout = c_gl.GL_MAX_SERVER_WAIT_TIMEOUT,
    max_texture_buffer_size = c_gl.GL_MAX_TEXTURE_BUFFER_SIZE,
    max_texture_image_units = c_gl.GL_MAX_TEXTURE_IMAGE_UNITS,
    max_texture_lod_bias = c_gl.GL_MAX_TEXTURE_LOD_BIAS,
    max_texture_size = c_gl.GL_MAX_TEXTURE_SIZE,
    max_uniform_block_size = c_gl.GL_MAX_UNIFORM_BLOCK_SIZE,
    max_uniform_buffer_gls = c_gl.GL_MAX_UNIFORM_BUFFER_BINDINGS,
    max_varying_components = c_gl.GL_MAX_VARYING_COMPONENTS,
    // max_varying_floats = c_gl.GL_MAX_VARYING_FLOATS,
    max_vertex_attribs = c_gl.GL_MAX_VERTEX_ATTRIBS,
    max_vertex_output_components = c_gl.GL_MAX_VERTEX_OUTPUT_COMPONENTS,
    max_vertex_texture_image_units = c_gl.GL_MAX_VERTEX_TEXTURE_IMAGE_UNITS,
    max_vertex_uniform_blocks = c_gl.GL_MAX_VERTEX_UNIFORM_BLOCKS,
    max_vertex_uniform_components = c_gl.GL_MAX_VERTEX_UNIFORM_COMPONENTS,
    max_viewport_dims = c_gl.GL_MAX_VIEWPORT_DIMS,
    min_program_texel_offset = c_gl.GL_MIN_PROGRAM_TEXEL_OFFSET,
    minor_version = c_gl.GL_MINOR_VERSION,
    num_compressed_texture_formats = c_gl.GL_NUM_COMPRESSED_TEXTURE_FORMATS,
    num_extensions = c_gl.GL_NUM_EXTENSIONS,
    pack_alignment = c_gl.GL_PACK_ALIGNMENT,
    pack_image_height = c_gl.GL_PACK_IMAGE_HEIGHT,
    pack_lsb_first = c_gl.GL_PACK_LSB_FIRST,
    pack_row_length = c_gl.GL_PACK_ROW_LENGTH,
    pack_skip_images = c_gl.GL_PACK_SKIP_IMAGES,
    pack_skip_pixels = c_gl.GL_PACK_SKIP_PIXELS,
    pack_skip_rows = c_gl.GL_PACK_SKIP_ROWS,
    pack_swap_bytes = c_gl.GL_PACK_SWAP_BYTES,
    pixel_pack_buffer_gl = c_gl.GL_PIXEL_PACK_BUFFER_BINDING,
    pixel_unpack_buffer_gl = c_gl.GL_PIXEL_UNPACK_BUFFER_BINDING,
    point_fade_threshold_size = c_gl.GL_POINT_FADE_THRESHOLD_SIZE,
    point_size = c_gl.GL_POINT_SIZE,
    point_size_granularity = c_gl.GL_POINT_SIZE_GRANULARITY,
    point_size_range = c_gl.GL_POINT_SIZE_RANGE,
    polygon_mode = c_gl.GL_POLYGON_MODE,
    polygon_offset_factor = c_gl.GL_POLYGON_OFFSET_FACTOR,
    polygon_offset_fill = c_gl.GL_POLYGON_OFFSET_FILL,
    polygon_offset_line = c_gl.GL_POLYGON_OFFSET_LINE,
    polygon_offset_point = c_gl.GL_POLYGON_OFFSET_POINT,
    polygon_offset_units = c_gl.GL_POLYGON_OFFSET_UNITS,
    polygon_smooth = c_gl.GL_POLYGON_SMOOTH,
    polygon_smooth_hint = c_gl.GL_POLYGON_SMOOTH_HINT,
    primitive_restart_index = c_gl.GL_PRIMITIVE_RESTART_INDEX,
    program_point_size = c_gl.GL_PROGRAM_POINT_SIZE,
    provoking_vertex = c_gl.GL_PROVOKING_VERTEX,
    read_buffer = c_gl.GL_READ_BUFFER,
    read_framebuffer_gl = c_gl.GL_READ_FRAMEBUFFER_BINDING,
    renderbuffer_gl = c_gl.GL_RENDERBUFFER_BINDING,
    sample_buffers = c_gl.GL_SAMPLE_BUFFERS,
    sample_coverage_invert = c_gl.GL_SAMPLE_COVERAGE_INVERT,
    sample_coverage_value = c_gl.GL_SAMPLE_COVERAGE_VALUE,
    sampler_gl = c_gl.GL_SAMPLER_BINDING,
    samples = c_gl.GL_SAMPLES,
    scissor_box = c_gl.GL_SCISSOR_BOX,
    scissor_test = c_gl.GL_SCISSOR_TEST,
    smooth_line_width_granularity = c_gl.GL_SMOOTH_LINE_WIDTH_GRANULARITY,
    smooth_line_width_range = c_gl.GL_SMOOTH_LINE_WIDTH_RANGE,
    stencil_back_fail = c_gl.GL_STENCIL_BACK_FAIL,
    stencil_back_func = c_gl.GL_STENCIL_BACK_FUNC,
    stencil_back_pass_depth_fail = c_gl.GL_STENCIL_BACK_PASS_DEPTH_FAIL,
    stencil_back_pass_depth_pass = c_gl.GL_STENCIL_BACK_PASS_DEPTH_PASS,
    stencil_back_ref = c_gl.GL_STENCIL_BACK_REF,
    stencil_back_value_mask = c_gl.GL_STENCIL_BACK_VALUE_MASK,
    stencil_back_writemask = c_gl.GL_STENCIL_BACK_WRITEMASK,
    stencil_clear_value = c_gl.GL_STENCIL_CLEAR_VALUE,
    stencil_fail = c_gl.GL_STENCIL_FAIL,
    stencil_func = c_gl.GL_STENCIL_FUNC,
    stencil_pass_depth_fail = c_gl.GL_STENCIL_PASS_DEPTH_FAIL,
    stencil_pass_depth_pass = c_gl.GL_STENCIL_PASS_DEPTH_PASS,
    stencil_ref = c_gl.GL_STENCIL_REF,
    stencil_test = c_gl.GL_STENCIL_TEST,
    stencil_value_mask = c_gl.GL_STENCIL_VALUE_MASK,
    stencil_writemask = c_gl.GL_STENCIL_WRITEMASK,
    stereo = c_gl.GL_STEREO,
    subpixel_bits = c_gl.GL_SUBPIXEL_BITS,
    texture_gl_1d = c_gl.GL_TEXTURE_BINDING_1D,
    texture_gl_1d_array = c_gl.GL_TEXTURE_BINDING_1D_ARRAY,
    texture_gl_2d = c_gl.GL_TEXTURE_BINDING_2D,
    texture_gl_2d_array = c_gl.GL_TEXTURE_BINDING_2D_ARRAY,
    texture_gl_2d_multisample = c_gl.GL_TEXTURE_BINDING_2D_MULTISAMPLE,
    texture_gl_2d_multisample_array = c_gl.GL_TEXTURE_BINDING_2D_MULTISAMPLE_ARRAY,
    texture_gl_3d = c_gl.GL_TEXTURE_BINDING_3D,
    texture_gl_buffer = c_gl.GL_TEXTURE_BINDING_BUFFER,
    texture_gl_cube_map = c_gl.GL_TEXTURE_BINDING_CUBE_MAP,
    texture_gl_rectangle = c_gl.GL_TEXTURE_BINDING_RECTANGLE,
    texture_compression_hint = c_gl.GL_TEXTURE_COMPRESSION_HINT,
    timestamp = c_gl.GL_TIMESTAMP,
    transform_feedback_buffer_gl = c_gl.GL_TRANSFORM_FEEDBACK_BUFFER_BINDING,
    transform_feedback_buffer_size = c_gl.GL_TRANSFORM_FEEDBACK_BUFFER_SIZE,
    transform_feedback_buffer_start = c_gl.GL_TRANSFORM_FEEDBACK_BUFFER_START,
    uniform_buffer_gl = c_gl.GL_UNIFORM_BUFFER_BINDING,
    uniform_buffer_offset_alignment = c_gl.GL_UNIFORM_BUFFER_OFFSET_ALIGNMENT,
    uniform_buffer_size = c_gl.GL_UNIFORM_BUFFER_SIZE,
    uniform_buffer_start = c_gl.GL_UNIFORM_BUFFER_START,
    unpack_alignment = c_gl.GL_UNPACK_ALIGNMENT,
    unpack_image_height = c_gl.GL_UNPACK_IMAGE_HEIGHT,
    unpack_lsb_first = c_gl.GL_UNPACK_LSB_FIRST,
    unpack_row_length = c_gl.GL_UNPACK_ROW_LENGTH,
    unpack_skip_images = c_gl.GL_UNPACK_SKIP_IMAGES,
    unpack_skip_pixels = c_gl.GL_UNPACK_SKIP_PIXELS,
    unpack_skip_rows = c_gl.GL_UNPACK_SKIP_ROWS,
    unpack_swap_bytes = c_gl.GL_UNPACK_SWAP_BYTES,
    viewport = c_gl.GL_VIEWPORT,
};

pub const ShaderParameter = enum(u32) {
    shader_type = c_gl.GL_SHADER_TYPE,
    delete_status = c_gl.GL_DELETE_STATUS,
    compile_status = c_gl.GL_COMPILE_STATUS,
    info_log_length = c_gl.GL_INFO_LOG_LENGTH,
    shader_source_length = c_gl.GL_SHADER_SOURCE_LENGTH,
};

pub const Shader = struct {
    shader: u32,

    pub fn init(shader_type: ShaderType) Shader {
        return .{ .shader = gl.create_shader(shader_type) };
    }

    pub fn source(self: Shader, count: i32, strings: anytype, length: ?*i32) void {
        gl.shader_source(self.shader, count, strings, length);
    }

    pub fn compile(self: Shader) void {
        gl.compile_shader(self.shader);
    }

    pub fn deinit(self: Shader) void {
        gl.delete_shader(self.shader);
    }
};

pub const Program = struct {
    id: u32,

    pub fn init() Program {
        return .{ .id = gl.create_program() };
    }

    pub fn deinit(self: Program) void {
        gl.delete_program(self.id);
    }

    pub fn attach_shader(self: Program, shader: Shader) void {
        gl.attach_shader(self.id, shader.shader);
    }

    pub fn link(self: Program) void {
        gl.link_program(self.id);
    }

    pub fn use(self: Program) void {
        gl.use_program(self.id);
    }
};

pub fn init() !void {
    if (c_gl.glewInit() != c_gl.GLEW_OK) return error.UnableToInitializeGL;
}

fn handle_error() void {
    const err = c_gl.glGetError();
    if (err == 0) return;
    const error_string = c_gl.glewGetErrorString(err);
    std.debug.print("{s} - {}\n", .{ error_string, err });
}

/// Set the viewport
pub fn viewport(x: i32, y: i32, width: i32, height: i32) void {
    c_gl.glViewport(x, y, width, height);
    handle_error();
}

/// Specify clear values for the color buffers
pub fn clear_color(red: f32, green: f32, blue: f32, alpha: f32) void {
    c_gl.glClearColor(red, green, blue, alpha);
    handle_error();
}

/// Clear buffers to preset values
pub fn clear(mask: Bitfield) void {
    c_gl.glClear(@intFromEnum(mask));
    handle_error();
}

/// Creates a shader object
pub fn create_shader(shader_type: ShaderType) u32 {
    const shader = c_gl.glCreateShader().?(@intFromEnum(shader_type));
    if (shader == 0) {
        handle_error();
    }
    return shader;
}

/// Replaces the source code in a shader object
pub fn shader_source(shader: u32, count: i32, strings: anytype, length: ?*i32) void {
    c_gl.glShaderSource().?(shader, count, @ptrCast(strings), length);
    handle_error();
}

/// Compiles a shader object
pub fn compile_shader(shader: u32) void {
    c_gl.glCompileShader().?(shader);
    handle_error();
}

/// Creates a program object
pub fn create_program() u32 {
    const program = c_gl.glCreateProgram().?();
    if (program == 0) {
        handle_error();
    }
    return program;
}

/// Deletes a shader object
pub fn delete_shader(shader: u32) void {
    c_gl.glDeleteShader().?(shader);
    handle_error();
}

/// Attaches a shader object to a program object
pub fn attach_shader(program: u32, shader: u32) void {
    c_gl.glAttachShader().?(program, shader);
    handle_error();
}
/// Links a program object
pub fn link_program(program: u32) void {
    c_gl.glLinkProgram().?(program);
    handle_error();
}

/// Deletes a program object
pub fn delete_program(program: u32) void {
    c_gl.glDeleteProgram().?(program);
    handle_error();
}

// Buffer
/// Generate buffer object names
pub fn gen_buffer(n: i32, buffers: anytype) void {
    c_gl.glGenBuffers().?(n, @ptrCast(buffers));
    handle_error();
}

/// Bind a named buffer object
pub fn bind_buffer(target: BufferBindingTarget, buffer: u32) void {
    c_gl.glBindBuffer().?(@intFromEnum(target), buffer);
    handle_error();
}

/// Creates and initializes a buffer object's data store
pub fn buffer_data(target: BufferBindingTarget, data: anytype, usage: Usage) void {
    const size: i32 = @intCast(
        data.len * @sizeOf(@typeInfo(@TypeOf(data)).Pointer.child),
    ); // very scary reflection
    c_gl.glBufferData().?(@intFromEnum(target), size, @ptrCast(data.ptr), @intFromEnum(usage));
    handle_error();
}

/// Delete named buffer objects
pub fn delete_buffer(n: i32, arrays: anytype) void {
    c_gl.glDeleteBuffers().?(n, arrays);
    handle_error();
}

// Vertex Array
/// Generate vertex array object names
pub fn gen_vertex_arrays(n: i32, arrays: anytype) void {
    c_gl.glGenVertexArrays().?(n, arrays);
    handle_error();
}

/// Bind a vertex array object
pub fn bind_vertex_array(array: u32) void {
    c_gl.glBindVertexArray().?(array);
    handle_error();
}

/// Define an array of generic vertex attribute data
pub fn vertex_attrib_pointer(
    index: u32,
    size: i32,
    data_type: DataType,
    normalized: bool,
    stride: i32,
    pointer: ?*anyopaque,
) void {
    const c_normalized: u8 = if (normalized) c_gl.GL_TRUE else c_gl.GL_FALSE;
    c_gl.glVertexAttribPointer().?(index, size, @intFromEnum(data_type), c_normalized, stride, pointer);
    handle_error();
}

/// Enable or disable a generic vertex attribute array
pub fn enable_vertex_attrib_array(index: u32) void {
    c_gl.glEnableVertexAttribArray().?(index);
    handle_error();
}

/// Delete vertex array objects
pub fn delete_vertex_array(n: i32, arrays: anytype) void {
    c_gl.glDeleteVertexArrays().?(n, arrays);
    handle_error();
}

/// Installs a program object as part of current rendering state
pub fn use_program(program: u32) void {
    c_gl.glUseProgram().?(program);
    handle_error();
}

/// Returns the location of a uniform variable
pub fn get_uniform_location(program: u32, name: []const u8) i32 {
    const uniform_location = c_gl.glGetUniformLocation().?(program, name.ptr);
    if (uniform_location == -1) {
        handle_error();
    }
    return uniform_location;
}

/// Specify the value of a uniform variable for the current program object
pub fn uniform1f(location: i32, v0: f32) void {
    c_gl.glUniform1f().?(location, v0);
}

/// Specify the value of a uniform variable for the current program object
pub fn uniform_matrix4fv(location: i32, count: i32, transpose: bool, value: []const f32) void {
    const c_transpose: u8 = if (transpose) c_gl.GL_TRUE else c_gl.GL_FALSE;
    c_gl.glUniformMatrix4fv().?(location, count, c_transpose, @ptrCast(value.ptr));
}

/// Render primitives from array data
pub fn draw_arrays(mode: Mode, first: i32, count: i32) void {
    c_gl.glDrawArrays(@intFromEnum(mode), first, count);
    handle_error();
}

// Render primitives from array data
pub fn draw_elements(mode: Mode, count: i32, data_type: DataType, indices: anytype) void {
    c_gl.glDrawElements(@intFromEnum(mode), count, @intFromEnum(data_type), @ptrFromInt(indices));
    handle_error();
}

/// Return the value or values of a selected parameter
pub fn get_integer(parameter: Parameter, value: anytype) void {
    c_gl.glGetIntegerv(@intFromEnum(parameter), @ptrCast(value));
    handle_error();
}

/// Returns a parameter from a shader object
pub fn get_shaderiv(shader: u32, pname: ShaderParameter, params: *i32) void {
    c_gl.glGetShaderiv().?(shader, @intFromEnum(pname), params).?();
}

/// Returns the information log for a shader object
pub fn get_shader_info_log(shader: u32, max_length: i32, length: ?*i32, info_log: []const u8) void {
    c_gl.glgetShaderInfoLog(shader, max_length, length, @ptrCast(info_log.ptr));
}
