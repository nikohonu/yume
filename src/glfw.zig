const c_glfw = @cImport({
    @cInclude("GLFW/glfw3.h");
});

pub const Window = c_glfw.GLFWwindow;
const window_size_fun = c_glfw.GLFWwindowsizefun;
pub const GL_COLOR_BUFFER_BIT = c_glfw.GL_COLOR_BUFFER_BIT;
pub const GL_FALSE = c_glfw.GL_FALSE;

pub fn init() !void {
    if (c_glfw.glfwInit() == c_glfw.GL_FALSE) return error.UnableToInitializeGLFW;
}

pub fn terminate() void {
    c_glfw.glfwTerminate();
}

pub fn create_window(width: i32, height: i32, title: []const u8) !*c_glfw.GLFWwindow {
    return c_glfw.glfwCreateWindow(width, height, title.ptr, null, null) orelse return error.WindowWasNotCreated;
}

pub fn make_context_current(window: *c_glfw.GLFWwindow) void {
    c_glfw.glfwMakeContextCurrent(window);
}

pub fn set_window_size_callback(window: ?*Window, callback: window_size_fun) window_size_fun {
    return c_glfw.glfwSetWindowSizeCallback(window, callback);
}

pub fn swap_buffers(window: *Window) void {
    c_glfw.glfwSwapBuffers(window);
}
pub fn clear(mask: c_glfw.GLbitfield) void {
    c_glfw.glClear(mask);
}
pub fn poll_events() void {
    c_glfw.glfwPollEvents();
}

pub fn window_should_close(window: *Window) c_int {
    return c_glfw.glfwWindowShouldClose(window);
}
