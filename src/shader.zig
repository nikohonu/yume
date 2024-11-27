const std = @import("std");
const gl = @import("gl.zig");

const Shader = @This();

program: gl.Program,

pub fn init(allocator: std.mem.Allocator, vertex_path: []const u8, fragment_path: []const u8) !Shader {
    const vertex_code = try read_file(allocator, vertex_path);
    defer allocator.free(vertex_code);

    const fragment_code = try read_file(allocator, fragment_path);
    defer allocator.free(fragment_code);

    const vertex_shader = gl.Shader.init(gl.ShaderType.VERTEX_SHADER);
    defer vertex_shader.deinit();
    vertex_shader.source(1, &vertex_code, null); // must fix it!
    vertex_shader.compile();

    const fragment_shader = gl.Shader.init(gl.ShaderType.FRAGMENT_SHADER);
    defer fragment_shader.deinit();
    fragment_shader.source(1, &fragment_code, null); // must fix it!
    fragment_shader.compile();

    const program = gl.Program.init();

    program.attach_shader(vertex_shader);
    program.attach_shader(fragment_shader);

    program.link();

    return .{ .program = program };
}

pub fn deinit(self: Shader) void {
    self.program.deinit();
}

pub fn use(self: Shader) void {
    self.program.use();
}

/// Don't forget to free used memory
pub fn read_file(allocator: std.mem.Allocator, path: []const u8) ![]const u8 {
    var string = try std.fs.cwd().readFileAlloc(allocator, path, 1024 * 1024);
    string = try allocator.realloc(string, @sizeOf(u8) * (string.len + 1));
    string[string.len - 1] = 0;
    return string;
}
