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

pub const Shader = struct {
    shader: u32,

    pub fn init(shader_type: ShaderType) Shader {
        return .{ .shader = gl.create_shader(shader_type) };
    }

    pub fn source(self: Shader, count: i32, strings: []const []const u8, length: ?*i32) void {
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
    program: u32,

    pub fn init() Program {
        return .{ .program = gl.create_program() };
    }

    pub fn deinit(self: Program) void {
        gl.delete_program(self.program);
    }

    pub fn attach_shader(self: Program, shader: Shader) void {
        gl.attach_shader(self.program, shader.shader);
    }

    pub fn link(self: Program) void {
        gl.link_program(self.program);
    }

    pub fn use(self: Program) void {
        gl.use_program(self.program);
    }
};

pub fn init() !void {
    if (c_gl.glewInit() != c_gl.GLEW_OK) return error.UnableToInitializeGL;
}

fn handle_error() void {
    const err = c_gl.glGetError();
    if (err == 0) return;
    const error_string = c_gl.glewGetErrorString(err);
    std.debug.print("{s}\n", .{error_string});
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
    const shader = c_gl.__glewCreateShader.?(@intFromEnum(shader_type));
    if (shader == 0) {
        handle_error();
    }
    return shader;
}

/// Replaces the source code in a shader object
pub fn shader_source(shader: u32, count: i32, strings: []const []const u8, length: ?*i32) void {
    c_gl.__glewShaderSource.?(shader, count, @ptrCast(strings.ptr), length);
    handle_error();
}

/// Compiles a shader object
pub fn compile_shader(shader: u32) void {
    c_gl.__glewCompileShader.?(shader);
    handle_error();
}

/// Creates a program object
pub fn create_program() u32 {
    const program = c_gl.__glewCreateProgram.?();
    if (program == 0) {
        handle_error();
    }
    return program;
}

/// Deletes a shader object
pub fn delete_shader(shader: u32) void {
    c_gl.__glewDeleteShader.?(shader);
    handle_error();
}

/// Attaches a shader object to a program object
pub fn attach_shader(program: u32, shader: u32) void {
    c_gl.__glewAttachShader.?(program, shader);
    handle_error();
}
/// Links a program object
pub fn link_program(program: u32) void {
    c_gl.__glewLinkProgram.?(program);
    handle_error();
}

/// Deletes a program object
pub fn delete_program(program: u32) void {
    c_gl.__glewDeleteProgram.?(program);
    handle_error();
}

// Buffer
/// Generate buffer object names
pub fn gen_buffer(n: i32, buffers: anytype) void {
    c_gl.__glewGenBuffers.?(n, @ptrCast(buffers));
    handle_error();
}

/// Bind a named buffer object
pub fn bind_buffer(target: BufferBindingTarget, buffer: u32) void {
    c_gl.__glewBindBuffer.?(@intFromEnum(target), buffer);
    handle_error();
}

/// Creates and initializes a buffer object's data store
pub fn buffer_data(target: BufferBindingTarget, data: anytype, usage: Usage) void {
    c_gl.__glewBufferData.?(@intFromEnum(target), @sizeOf(@TypeOf(data)), @ptrCast(&data), @intFromEnum(usage));
    handle_error();
}

/// Delete named buffer objects
pub fn delete_buffer(n: i32, arrays: anytype) void {
    c_gl.__glewDeleteBuffers.?(n, arrays);
    handle_error();
}

// Vertex Array
/// Generate vertex array object names
pub fn gen_vertex_arrays(n: i32, arrays: anytype) void {
    c_gl.__glewGenVertexArrays.?(n, arrays);
    handle_error();
}

/// Bind a vertex array object
pub fn bind_vertex_array(array: u32) void {
    c_gl.__glewBindVertexArray.?(array);
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
    c_gl.__glewVertexAttribPointer.?(index, size, @intFromEnum(data_type), c_normalized, stride, pointer);
    handle_error();
}

/// Enable or disable a generic vertex attribute array
pub fn enable_vertex_attrib_array(index: u32) void {
    c_gl.__glewEnableVertexAttribArray.?(index);
    handle_error();
}

/// Delete vertex array objects
pub fn delete_vertex_array(n: i32, arrays: anytype) void {
    c_gl.__glewDeleteVertexArrays.?(n, arrays);
    handle_error();
}

/// Installs a program object as part of current rendering state
pub fn use_program(program: u32) void {
    c_gl.__glewUseProgram.?(program);
    handle_error();
}
//
// pub fn get_uniform_location(program: ProgramID, name: []const u8) GLint {
//     const uniform_location = c_gl.__glewGetUniformLocation.?(program, name.ptr);
//     if (uniform_location == -1) {
//         handle_error();
//     }
//     return uniform_location;
// }
// pub fn uniform_matrix4fv(location: GLint, count: GLsizei, transpose: GLboolean, value: [*]const GLfloat) void {
//     c_gl.__glewUniformMatrix4fv.?(location, count, transpose, value);
// }

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
