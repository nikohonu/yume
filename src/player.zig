const rl = @import("raylib");
const rle = @import("raylib_extension.zig");

const Player = @This();

speed: f32,
position: rl.Vector2,

pub fn init(speed: f32) Player {
    return .{ .position = rl.Vector2.zero(), .speed = speed };
}

pub fn update(self: *Player, delta: f32) void {
    var move = rl.Vector2.init(
        rle.getKeyStrength(rl.KeyboardKey.key_d) - rle.getKeyStrength(rl.KeyboardKey.key_a),
        rle.getKeyStrength(rl.KeyboardKey.key_s) - rle.getKeyStrength(rl.KeyboardKey.key_w),
    );
    move = move.normalize().scale(delta * self.speed);
    self.position = self.position.add(move);
}

pub fn draw(self: Player) void {
    rl.drawCircleV(self.position, 32, rl.Color.red);
}
