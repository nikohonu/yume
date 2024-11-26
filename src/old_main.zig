const std = @import("std");
const expect = std.testing.expect;

const glfw = @import("glfw.zig");
const gl = @import("gl.zig");
const Shader = @import("shader.zig");
const math = @import("math.zig");

fn window_size_changed(window: ?*glfw.Window, width: c_int, height: c_int) callconv(.C) void {
    _ = window;
    projection = math.ortho(0, @floatFromInt(width), 0, @floatFromInt(height), -1, 1);
}

var projection: math.mat4 = math.ortho(0, 640, 480, 0, -1, 1);

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer {
        const deinit_status = gpa.deinit();
        if (deinit_status == .leak) expect(false) catch @panic("TEST FAIL");
    }
    const allocator = gpa.allocator();

    _ = try glfw.init();
    defer glfw.terminate();
    const window = try glfw.Window.init(640, 480, "夢");

    window.make_context_current();
    _ = glfw.set_window_size_callback(window, window_size_changed);

    try gl.init();

    const program = gl.create_program();

    const vertex_shader = try Shader.init(allocator, "shaders/basic_vertex.glsl", gl.VERTEX_SHADER);
    defer vertex_shader.deinit();

    const fragment_shader = try Shader.init(allocator, "shaders/basic_fragment.glsl", gl.FRAGMENT_SHADER);
    defer fragment_shader.deinit();

    gl.attach_shader(program, vertex_shader.id);
    gl.attach_shader(program, fragment_shader.id);
    gl.link_program(program);

    const vertices = [_]f32{
        0.0,   0.0,   1.0,
        400.0, 100.0, 1.0,
        250.0, 400.0, 1.0,
    };
    var buffer: c_uint = undefined;
    var VAO: c_uint = undefined;

    gl.gen_buffer(1, &buffer);
    gl.gen_vertex_arrays(1, &VAO);

    gl.bind_vertex_array(VAO);

    gl.bind_buffer(gl.ARRAY_BUFFER, buffer);
    gl.buffer_data(gl.ARRAY_BUFFER, &vertices, gl.STATIC_DRAW);

    gl.vertex_attrib_pointer(0, 3, gl.GL_FLOAT, gl.GL_FALSE, 3 * @sizeOf(f32), @ptrFromInt(0));
    gl.enable_vertex_attrib_array(0);
    gl.use_program(program);

    while (glfw.window_should_close(window) == glfw.GL_FALSE) {
        const projection_id = gl.get_uniform_location(program, "projection");
        gl.uniform_matrix4fv(projection_id, 1, gl.GL_FALSE, &math.flat_mat4(projection));
        gl.draw_arrays(gl.GL_TRIANGLES, 0, 3);
        glfw.swap_buffers(window);
        glfw.clear(glfw.GL_COLOR_BUFFER_BIT);
        glfw.poll_events();
    }
}
