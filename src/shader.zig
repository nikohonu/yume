const std = @import("std");
const gl = @import("gl.zig");

const Shader = @This();

shader: gl.Shader,

pub fn init(shader_type: gl.ShaderType, string: []const u8) Shader {
    const shader = gl.Shader.init(shader_type);
    shader.source(1, &.{string}, null);
    shader.compile();
    return .{ .shader = shader };
}

pub fn deinit(self: Shader) void {
    self.shader.deinit();
}

pub fn init_from_path(allocator: std.mem.Allocator, shader_type: gl.ShaderType, path: []const u8) !Shader {
    var string = try std.fs.cwd().readFileAlloc(allocator, path, 1024 * 1024);
    defer allocator.free(string);
    string = try allocator.realloc(string, @sizeOf(u8) * (string.len + 1));
    string[string.len - 1] = 0;
    return Shader.init(shader_type, string);
}
