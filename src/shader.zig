const std = @import("std");
const gl = @import("gl.zig");
const zgl = @import("zgl");

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
    try compile_errors(allocator, vertex_shader.shader, "VERTEX");

    const fragment_shader = gl.Shader.init(gl.ShaderType.FRAGMENT_SHADER);
    defer fragment_shader.deinit();
    fragment_shader.source(1, &fragment_code, null); // must fix it!
    fragment_shader.compile();
    try compile_errors(allocator, fragment_shader.shader, "FRAGMENT");

    const program = gl.Program.init();

    program.attach_shader(vertex_shader);
    program.attach_shader(fragment_shader);

    program.link();
    try compile_errors(allocator, program.id, "PROGRAM");

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

fn compile_errors(allocator: std.mem.Allocator, id: u32, shader_type: []const u8) !void {
    if (!std.mem.eql(u8, shader_type, "PROGRAM")) {
        const shader: zgl.Shader = @enumFromInt(id);
        const has_compiled = zgl.getShader(shader, zgl.ShaderParameter.compile_status);
        if (has_compiled == 0) {
            const info_log = try zgl.getShaderInfoLog(shader, allocator);
            defer allocator.free(info_log);
            std.debug.print("Compile error ({s}): {s}", .{ shader_type, info_log });
        }
    } else {
        const program: zgl.Program = @enumFromInt(id);
        const has_compiled = zgl.getProgram(program, zgl.ProgramParameter.link_status);
        if (has_compiled == 0) {
            const info_log = try zgl.getProgramInfoLog(program, allocator);
            defer allocator.free(info_log);
            std.debug.print("Linking error ({s}): {s}", .{ shader_type, info_log });
        }
    }
}
