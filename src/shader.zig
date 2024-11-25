const std = @import("std");
const gl = @import("gl.zig");

const Shader = @This();

// allocator: std.mem.Allocator,
id: gl.ShaderID,

pub fn init(
    allocator: std.mem.Allocator,
    path: []const u8,
    shader_type: gl.ShaderType,
) !Shader {
    var content = try std.fs.cwd().readFileAlloc(allocator, path, 1024 * 1024);
    defer allocator.free(content);
    content = try allocator.realloc(content, @sizeOf(u8) * (content.len + 1));
    content[content.len - 1] = 0;
    return .{ .id = create_shader(content, shader_type) };
}

pub fn deinit(self: Shader) void {
    gl.delete_shader(self.id);
}

pub fn create_shader(string: []const u8, shader_type: gl.ShaderType) gl.ShaderID {
    const shader = gl.create_shader(shader_type);
    gl.shader_source(shader, string);
    gl.compile_shader(shader);
    return shader;
}
