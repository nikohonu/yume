const std = @import("std");

pub const vec4 = [4]f32;
pub const mat4 = [4]vec4;

pub fn ortho(left: f32, right: f32, bottom: f32, top: f32, nearZ: f32, farZ: f32) mat4 {
    const rl = 1.0 / (right - left);
    const tb = 1.0 / (top - bottom);
    return .{
        .{ 2.0 * rl, 0, 0, 0 },
        .{ 0, 2.0 * tb, 0, 0 },
        .{ 0, 0, -2.0 / (farZ - nearZ), 0 },
        .{ -(right + left) * rl, -(top + bottom) * tb, -(farZ + nearZ) / (farZ - nearZ), 1.0 },
    };
}

pub fn flat_mat4(matrix: mat4) [16]f32 {
    var result: [16]f32 = undefined;
    for (0..4) |i| {
        for (0..4) |j| {
            result[i * 4 + j] = matrix[i][j];
        }
    }
    return result;
}
