const std = @import("std");
const gl = @import("gl.zig");

const EBO = @This();

id: u32,

pub fn init(indices: []const u32) EBO {
    var id: u32 = undefined;
    gl.gen_buffer(1, &id);
    gl.bind_buffer(gl.BufferBindingTarget.ELEMENT_ARRAY_BUFFER, id);
    gl.buffer_data(
        gl.BufferBindingTarget.ELEMENT_ARRAY_BUFFER,
        indices,
        gl.Usage.STATIC_DRAW,
    );
    return .{ .id = id };
}

pub fn deinit(self: EBO) void {
    gl.delete_buffer(1, &self.id);
}

pub fn bind(self: EBO) void {
    gl.bind_buffer(gl.BufferBindingTarget.ELEMENT_ARRAY_BUFFER, self.id);
}
pub fn unbind(_: EBO) void {
    gl.bind_buffer(gl.BufferBindingTarget.ARRAY_BUFFER, 0);
}
