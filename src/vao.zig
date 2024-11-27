const std = @import("std");

const gl = @import("gl.zig");

const VBO = @import("vbo.zig");

const VAO = @This();

id: u32,

pub fn init() VAO {
    var id: u32 = undefined;
    gl.gen_vertex_arrays(1, &id);
    return .{ .id = id };
}

pub fn deinit(self: VAO) void {
    defer gl.delete_vertex_array(1, &self.id);
}

pub fn link_vbo(_: VAO, vbo: VBO, layout: u32) void {
    vbo.bind();
    gl.vertex_attrib_pointer(
        layout,
        3,
        gl.DataType.FLOAT,
        false,
        0,
        @ptrFromInt(0),
    );
    gl.enable_vertex_attrib_array(layout);
    vbo.unbind();
}

pub fn bind(self: VAO) void {
    gl.bind_vertex_array(self.id);
}

pub fn unbind(_: VAO) void {
    gl.bind_vertex_array(0);
}
