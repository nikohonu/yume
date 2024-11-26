pub const c_glfw = @cImport({
    @cInclude("GLFW/glfw3.h");
});

const window_size_fun = c_glfw.GLFWwindowsizefun;
pub const GL_COLOR_BUFFER_BIT = c_glfw.GL_COLOR_BUFFER_BIT;
pub const GL_FALSE = c_glfw.GL_FALSE;

pub const Window = struct {
    window: *c_glfw.GLFWwindow,

    pub fn init(width: i32, height: i32, title: []const u8) !Window {
        return .{ .window = c_glfw.glfwCreateWindow(
            width,
            height,
            title.ptr,
            null,
            null,
        ) orelse {
            terminate();
            return error.WindowWasNotCreated;
        } };
    }

    pub fn deinit(self: Window) void {
        c_glfw.glfwDestroyWindow(self.window);
    }

    pub fn make_context_current(self: Window) void {
        c_glfw.glfwMakeContextCurrent(self.window);
    }

    pub fn should_close(self: Window) bool {
        return c_glfw.glfwWindowShouldClose(self.window) == c_glfw.GL_TRUE;
    }

    pub fn swap_buffers(self: Window) void {
        c_glfw.glfwSwapBuffers(self.window);
    }
};

pub fn init() !void {
    if (c_glfw.glfwInit() == GL_FALSE) return error.UnableToInitializeGLFW;
}

pub fn terminate() void {
    c_glfw.glfwTerminate();
}

pub fn poll_events() void {
    c_glfw.glfwPollEvents();
}

// pub fn set_window_size_callback(window: ?*Window, callback: window_size_fun) window_size_fun {
//     return c_glfw.glfwSetWindowSizeCallback(window, callback);
// }
//
// pub fn clear(mask: c_glfw.GLbitfield) void {
//     c_glfw.glClear(mask);
// }
//
// pub fn window_should_close(window: *Window) c_int {
//     return c_glfw.glfwWindowShouldClose(window);
// }
