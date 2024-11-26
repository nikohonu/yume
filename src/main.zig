const std = @import("std");
const glfw = @import("glfw.zig");
const gl = @import("gl.zig");
const Shader = @import("shader.zig");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer {
        const deinit_status = gpa.deinit();
        if (deinit_status == .leak) std.testing.expect(false) catch @panic("TEST FAIL");
    }
    const allocator = gpa.allocator();

    try glfw.init();
    defer glfw.terminate();

    const vertices = [_]f32{
        -0.5, -0.5 * @sqrt(3.0) / 3.0, 0.0, // lower left corner
        0.5, -0.5 * @sqrt(3.0) / 3.0, 0.0, // lower right corner
        0.0, 0.5 * @sqrt(3.0) * 2.0 / 3.0, 0.0, // upper corner
        -0.5 / 2.0, 0.5 * @sqrt(3.0) / 6.0, 0.0, // inner left
        0.5 / 2.0, 0.5 * @sqrt(3.0) / 6.0, 0.0, // inner right
        0.0, -0.5 * @sqrt(3.0) / 3.0, 0.0, // inner down
    };

    const indices = [_]u32{
        0, 3, 5, // lower left triangle
        3, 2, 4, // lower left triangle
        5, 4, 1, // lower left triangle
    };

    const window = try glfw.Window.init(800, 800, "夢");
    defer window.deinit();

    window.make_context_current();

    try gl.init();

    gl.viewport(0, 0, 800, 800);

    const vertex_shader = try Shader.init_from_path(
        allocator,
        gl.ShaderType.VERTEX_SHADER,
        "shaders/basic_vertex.glsl",
    );
    defer vertex_shader.deinit();

    const fragment_shader = try Shader.init_from_path(
        allocator,
        gl.ShaderType.FRAGMENT_SHADER,
        "shaders/basic_fragment.glsl",
    );
    defer fragment_shader.deinit();

    const program = gl.Program.init();
    defer program.deinit();

    program.attach_shader(vertex_shader.shader);
    program.attach_shader(fragment_shader.shader);

    program.link();

    var vbo: u32 = undefined;
    var vao: u32 = undefined;
    var ebo: u32 = undefined;

    gl.gen_vertex_arrays(1, &vao);
    defer gl.delete_vertex_array(1, &vao);

    gl.gen_buffer(1, &vbo);
    defer gl.delete_buffer(1, &vao);

    gl.gen_buffer(1, &ebo);
    defer gl.delete_buffer(1, &ebo);

    gl.bind_vertex_array(vao);

    gl.bind_buffer(gl.BufferBindingTarget.ARRAY_BUFFER, vbo);
    gl.buffer_data(
        gl.BufferBindingTarget.ARRAY_BUFFER,
        vertices,
        gl.Usage.STATIC_DRAW,
    );

    gl.bind_buffer(gl.BufferBindingTarget.ELEMENT_ARRAY_BUFFER, ebo);
    gl.buffer_data(gl.BufferBindingTarget.ELEMENT_ARRAY_BUFFER, indices, gl.Usage.STATIC_DRAW);

    gl.vertex_attrib_pointer(
        0,
        3,
        gl.DataType.FLOAT,
        false,
        3 * @sizeOf(f32),
        @ptrFromInt(0),
    );
    gl.enable_vertex_attrib_array(0);

    // Unselect vbo and vao
    gl.bind_buffer(gl.BufferBindingTarget.ARRAY_BUFFER, 0);
    gl.bind_vertex_array(0);
    gl.bind_buffer(gl.BufferBindingTarget.ELEMENT_ARRAY_BUFFER, 0);

    gl.clear_color(0.07, 0.13, 0.17, 1.0);

    gl.clear(gl.Bitfield.COLOR_BUFFER_BIT);
    window.swap_buffers();

    while (!window.should_close()) {
        gl.clear_color(0.07, 0.13, 0.17, 1.0);
        gl.clear(gl.Bitfield.COLOR_BUFFER_BIT);
        gl.bind_vertex_array(vao);
        program.use();
        // gl.draw_arrays(gl.Mode.TRIANGLES, 0, 6);
        gl.draw_elements(gl.Mode.TRIANGLES, 9, gl.DataType.UNSIGNED_INT, 0);
        window.swap_buffers();
        glfw.poll_events();
    }
}
