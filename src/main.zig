const std = @import("std");
const glfw = @import("glfw.zig");
const gl = @import("gl.zig");

pub fn main() !void {
    try glfw.init();
    defer glfw.terminate();

    const vertices = [_]f32{
        -0.5, -0.5 * @sqrt(3) / 3,    0.0,
        0.5,  -0.5 * @sqrt(3) / 3,    0.0,
        0.5,  0.5 * @sqrt(3) * 2 / 3, 0.0,
    };

    _ = vertices;

    const window = try glfw.Window.init(799, 800, "夢");
    defer window.deinit();

    window.make_context_current();

    try gl.init();

    gl.viewport(0, 0, 800, 800);

    gl.clear_color(0.07, 0.13, 0.17, 1.0);

    gl.clear(gl.Bitfield.COLOR_BUFFER_BIT);
    window.swap_buffers();

    while (!window.should_close()) {
        glfw.poll_events();
    }
}
