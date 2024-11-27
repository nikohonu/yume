const std = @import("std");
const gl = @import("gl.zig");

const VBO = @This();

id: u32,

pub fn init(vertices: []const f32) VBO {
    var id: u32 = undefined;
    gl.gen_buffer(1, &id);
    gl.bind_buffer(gl.BufferBindingTarget.ARRAY_BUFFER, id);
    gl.buffer_data(
        gl.BufferBindingTarget.ARRAY_BUFFER,
        vertices,
        gl.Usage.STATIC_DRAW,
    );
    return .{ .id = id };
}

pub fn deinit(self: VBO) void {
    gl.delete_buffer(1, &self.id);
}

pub fn bind(self: VBO) void {
    gl.bind_buffer(gl.BufferBindingTarget.ARRAY_BUFFER, self.id);
}
pub fn unbind(_: VBO) void {
    gl.bind_buffer(gl.BufferBindingTarget.ARRAY_BUFFER, 0);
}
