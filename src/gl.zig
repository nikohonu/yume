const std = @import("std");
const c_gl = @cImport({
    @cInclude("GL/glew.h");
});

pub const GL_FALSE = c_gl.GL_FALSE;
pub const GL_FLOAT = c_gl.GL_FLOAT;
pub const GLboolean = c_gl.GLboolean;
pub const GLenum = c_gl.GLenum;
pub const GLint = c_gl.GLint;
pub const GLsizei = c_gl.GLsizei;
pub const GLsizeiptr = c_gl.GLsizeiptr;
pub const GLuint = c_gl.GLuint;
pub const GLfloat = c_gl.GLfloat;
pub const GL_TRIANGLES = c_gl.GL_TRIANGLES;

pub const ProgramID = GLuint;
pub const ShaderID = GLuint;

pub const VERTEX_SHADER = c_gl.GL_VERTEX_SHADER;
pub const FRAGMENT_SHADER = c_gl.GL_FRAGMENT_SHADER;
pub const ARRAY_BUFFER = c_gl.GL_ARRAY_BUFFER;
pub const STATIC_DRAW = c_gl.GL_STATIC_DRAW;

pub const Bitfield = enum(u32) {
    COLOR_BUFFER_BIT = c_gl.GL_COLOR_BUFFER_BIT,
};

pub const ShaderType = enum(u32) {
    VERTEX_SHADER = c_gl.GL_VERTEX_SHADER,
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

//
// pub fn create_program() c_gl.GLuint {
//     const program = c_gl.__glewCreateProgram.?();
//     if (program == 0) {
//         handle_error();
//     }
//     return program;
// }

/// Creates a shader object
pub fn create_shader(shader_type: ShaderType) u32 {
    const shader = c_gl.__glewCreateShader.?(@intFromEnum(shader_type));
    if (shader_type == 0) {
        handle_error();
    }
    return shader;
}
//
pub fn shader_source(shader: ShaderID, string: []const u8) void {
    const strings = [_][*c]const u8{string.ptr};
    c_gl.__glewShaderSource.?(shader, 1, &strings, null);
    handle_error();
}
//
// pub fn compile_shader(shader: ShaderID) void {
//     c_gl.__glewCompileShader.?(shader);
//     handle_error();
// }
//
// pub fn delete_shader(shader: ShaderID) void {
//     c_gl.__glewDeleteShader.?(shader);
//     handle_error();
// }
//
// pub fn attach_shader(program: ProgramID, shader: ShaderID) void {
//     c_gl.__glewAttachShader.?(program, shader);
//     handle_error();
// }
//
// pub fn link_program(program: ProgramID) void {
//     c_gl.__glewLinkProgram.?(program);
//     handle_error();
// }
//
// pub fn gen_buffer(n: c_gl.GLsizei, buffers: *c_gl.GLuint) void {
//     c_gl.__glewGenBuffers.?(n, buffers);
//     handle_error();
// }
//
// pub fn gen_vertex_arrays(n: c_gl.GLsizei, arrays: *c_gl.GLuint) void {
//     c_gl.__glewGenVertexArrays.?(n, arrays);
//     handle_error();
// }
//
// pub fn bind_vertex_array(array: c_gl.GLuint) void {
//     c_gl.__glewBindVertexArray.?(array);
//     handle_error();
// }
//
// pub fn bind_buffer(target: GLenum, buffer: GLuint) void {
//     c_gl.__glewBindBuffer.?(target, buffer);
//     handle_error();
// }
// pub fn buffer_data(target: GLenum, data: anytype, usage: GLenum) void {
//     c_gl.__glewBufferData.?(target, @sizeOf(@TypeOf(data.*)), data, usage);
//     handle_error();
// }
//
// pub fn vertex_attrib_pointer(
//     index: GLuint,
//     size: GLint,
//     data_type: GLenum,
//     normalized: GLboolean,
//     stride: GLsizei,
//     pointer: ?*anyopaque,
// ) void {
//     c_gl.__glewVertexAttribPointer.?(index, size, data_type, normalized, stride, pointer);
//     handle_error();
// }
//
// pub fn enable_vertex_attrib_array(index: GLuint) void {
//     c_gl.__glewEnableVertexAttribArray.?(index);
//     handle_error();
// }
//
// pub fn use_program(program: ProgramID) void {
//     c_gl.__glewUseProgram.?(program);
//     handle_error();
// }
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
// pub fn draw_arrays(mode: GLenum, first: GLint, count: GLsizei) void {
//     c_gl.glDrawArrays(mode, first, count);
// }
