import 'package:flame/components.dart';
import 'package:flame/game.dart';

/// Core Flame game for Zig-Zag Path Survival.
///
/// Responsibilities (high level):
/// - Own the camera and world coordinates.
/// - Coordinate player, world segments, and difficulty.
/// - Expose hooks for overlays (HUD, pause, game over).
class ZigZagGame extends FlameGame {
  ZigZagGame();

  /// TODO: Inject configuration, level info, difficulty system here.

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // TODO: Set up camera/viewport, world, and player components.
  }

  @override
  void update(double dt) {
    // TODO: Drive difficulty, camera scrolling, and world generation.
    super.update(dt);
  }
}

