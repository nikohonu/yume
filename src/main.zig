const std = @import("std");

const glfw = @cImport({
    @cInclude("GLFW/glfw3.h");
});

const gl = @cImport({
    @cInclude("GL/glew.h");
});

pub fn main() !void {
    if (glfw.glfwInit() == glfw.GL_FALSE) return error.CantInitGlfw;

    defer glfw.glfwTerminate();

    const window = glfw.glfwCreateWindow(640, 480, "Hello World", null, null) orelse return error.WindowDosentExist;

    glfw.glfwMakeContextCurrent(window);

    if (gl.glewInit() != gl.GLEW_OK) return error.CantInitGlew;

    std.debug.print("{s}\n", .{gl.glGetString(gl.GL_VERSION)});

    while (glfw.glfwWindowShouldClose(window) == glfw.GL_FALSE) {
        glfw.glClear(glfw.GL_COLOR_BUFFER_BIT);
        glfw.glfwSwapBuffers(window);
        glfw.glfwPollEvents();
    }
}
