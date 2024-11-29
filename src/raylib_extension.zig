const rl = @import("raylib");

pub fn getKeyStrength(key: rl.KeyboardKey) f32 {
    return @floatFromInt(@intFromBool(rl.isKeyDown(key)));
}
