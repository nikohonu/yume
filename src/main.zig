const std = @import("std");

const rl = @import("raylib");

const Player = @import("player.zig");

pub fn main() !void {
    // Init
    rl.initWindow(800, 600, "夢");
    defer rl.closeWindow();
    rl.setTargetFPS(60);

    // Instance
    var player = Player.init(300);

    while (!rl.windowShouldClose()) {
        // Update
        const delta = rl.getFrameTime();
        player.update(delta);

        // Draw
        rl.beginDrawing();
        defer rl.endDrawing();
        rl.clearBackground(rl.Color.ray_white);
        rl.drawFPS(10, 10);
        rl.drawText("", 190, 200, 20, rl.Color.light_gray);
        player.draw();
    }
}

test "simple test" {
    var list = std.ArrayList(i32).init(std.testing.allocator);
    defer list.deinit();
    try list.append(42);
    try std.testing.expectEqual(@as(i32, 42), list.pop());
}
