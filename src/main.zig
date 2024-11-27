const std = @import("std");

const zgl = @import("zgl");

const glfw = @import("glfw.zig");
const gl = @import("gl.zig");

const Shader = @import("shader.zig");
const VAO = @import("vao.zig");
const VBO = @import("vbo.zig");
const EBO = @import("ebo.zig");

fn window_size_changed(window: ?*glfw.c.GLFWwindow, width: c_int, height: c_int) callconv(.C) void {
    _ = window;
    // var viewport: [4]i32 = undefined;
    // gl.get_integer(gl.Parameter.viewport, &viewport);
    // std.debug.print("{}, {}, {any}\n", .{ width, height, viewport });
    gl.viewport(0, 0, width, height);
    // projection = math.ortho(0, @floatFromInt(width), 0, @floatFromInt(height), -1, 1);
}

fn getProcAddressWrapper(comptime _: type, symbolName: [:0]const u8) ?*const anyopaque {
    return glfw.get_proc_address(symbolName);
}

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
        // position (3) + color (3)
        -0.5, -0.5 * @sqrt(3.0) / 3.0, 0.0, 1.0, 0.0, 0.0, // lower left corner
        0.5, -0.5 * @sqrt(3.0) / 3.0, 0.0, 0.0, 1.0, 0.0, // lower right corner
        0.0, 0.5 * @sqrt(3.0) * 2.0 / 3.0, 0.0, 0.0, 0.0, 1.0, // upper corner
        -0.5 / 2.0, 0.5 * @sqrt(3.0) / 6.0, 0.0, 0.9, 0.45, 0.17, // inner left
        0.5 / 2.0, 0.5 * @sqrt(3.0) / 6.0, 0.0, 0.9, 0.45, 0.17, // inner right
        0.0, -0.5 * @sqrt(3.0) / 3.0, 0.0, 0.8, 0.3, 0.02, // inner down
        //
        -1.0, -1.0, 0.0, 0.8, 0.3, 0.02, // inner down
        -1.0, -0.99, 0.0, 0.8, 0.3, 0.02, // inner down
        1.0, -1.0, 0.0, 0.8, 0.3, 0.02, // inner down
        1.0, -0.99, 0.0, 0.8, 0.3, 0.02, // inner down
    };

    const indices = [_]u32{
        0, 3, 5, // lower left triangle
        3, 2, 4, // lower left triangle
        5, 4, 1, // lower left triangle
        //
        6, 7, 8, // lower left triangle
        7, 9, 8, // lower left triangle
    };

    const window = try glfw.Window.init(800, 800, "夢");
    defer window.deinit();

    window.make_context_current();

    _ = window.set_window_size_callback(window_size_changed);

    try gl.init();
    try zgl.loadExtensions(void, getProcAddressWrapper);

    gl.viewport(0, 0, 800, 800);

    const shader = try Shader.init(
        allocator,
        "shaders/default.vert",
        "shaders/default.frag",
    );
    defer shader.deinit();

    // Init VAO
    const vao1 = VAO.init();
    defer vao1.deinit();
    // Bind VAO, means that next data will be defined by this vao
    vao1.bind();

    // Init and bind VBO
    const vbo1 = VBO.init(&vertices);
    defer vbo1.deinit();

    // Init and bind EBO
    const ebo1 = EBO.init(&indices);
    defer ebo1.deinit();

    // Link our VBO to our VAO, that include defining in what way VAO
    // describe VBO
    vao1.link_attrib(vbo1, 0, 3, gl.DataType.FLOAT, @sizeOf(f32) * 6, @ptrFromInt(0));
    vao1.link_attrib(vbo1, 1, 3, gl.DataType.FLOAT, @sizeOf(f32) * 6, @ptrFromInt(3 * @sizeOf(f32)));

    // Unbind = unselect all VAO, because it means from now on, we can't change
    // anything about our data
    vao1.unbind();
    vbo1.unbind();
    ebo1.unbind();

    gl.clear_color(0.07, 0.13, 0.17, 1.0);

    gl.clear(gl.Bitfield.COLOR_BUFFER_BIT);
    window.swap_buffers();

    const u = gl.get_uniform_location(shader.program.id, "scale");

    while (!window.should_close()) {
        gl.clear_color(0.07, 0.13, 0.17, 1.0);
        gl.clear(gl.Bitfield.COLOR_BUFFER_BIT);
        shader.use();
        gl.uniform1f(u, 3.0);
        // Bind VAO, it shows how to use current data
        vao1.bind();
        gl.draw_elements(gl.Mode.TRIANGLES, 15, gl.DataType.UNSIGNED_INT, 0);
        window.swap_buffers();
        glfw.poll_events();
    }
}
