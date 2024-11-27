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

pub fn link_attrib(
    _: VAO,
    vbo: VBO,
    layout: u32,
    num_componets: i32,
    data_type: gl.DataType,
    stride: i32,
    offset: ?*anyopaque,
) void {
    vbo.bind();
    gl.vertex_attrib_pointer(
        layout,
        num_componets,
        data_type,
        false,
        stride,
        offset,
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
