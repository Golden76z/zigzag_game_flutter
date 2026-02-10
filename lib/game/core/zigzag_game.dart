import 'dart:ui' show Color, Paint;

import 'package:flame/components.dart';
import 'package:flame/game.dart' as flame;

import '../difficulty/difficulty_descriptor.dart';
import '../difficulty/level_config.dart';
import 'game_session_state.dart';

/// Core Flame game for Zig-Zag Path Survival.
///
/// Responsibilities (high level):
/// - Own the camera and world coordinates.
/// - Coordinate player, world segments, and difficulty.
/// - Expose hooks for overlays (HUD, pause, game over).
class ZigZagGame extends flame.FlameGame {
  ZigZagGame({
    required this.levels,
    required int initialLevelIndex,
  })  : assert(levels.isNotEmpty, 'At least one level must be provided'),
        assert(
          initialLevelIndex >= 0 && initialLevelIndex < levels.length,
          'Initial level index must be in range of levels list',
        ) {
    _session = GameSessionState.initial(levelIndex: initialLevelIndex);
    _difficulty = levels[initialLevelIndex].baseDifficulty;
  }

  /// All available level configurations.
  final List<LevelConfig> levels;

  /// Logical world size used for camera/viewport.
  ///
  /// This decouples gameplay math from actual device pixels.
  final Vector2 worldSize = Vector2(1080, 1920);

  late GameSessionState _session;
  late DifficultyDescriptor _difficulty;

  GameSessionState get session => _session;
  DifficultyDescriptor get difficulty => _difficulty;

  bool get isRunning => _session.isRunning && !_session.isGameOver;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // TODO: Configure an explicit viewport (e.g. fixed resolution)
    // once we finalize the desired logical resolution setup.

    // Simple background so we can see the game area before real
    // world/path rendering is implemented.
    add(
      RectangleComponent(
        position: Vector2.zero(),
        size: worldSize,
        paint: Paint()..color = const Color(0xFF101018),
      ),
    );
  }

  /// Start or restart the current level.
  void startLevel(int levelIndex) {
    assert(
      levelIndex >= 0 && levelIndex < levels.length,
      'Level index out of range',
    );

    final level = levels[levelIndex];
    _session = GameSessionState.initial(levelIndex: levelIndex)
        .copyWith(isRunning: true);
    _difficulty = level.baseDifficulty;

    resumeEngine();
  }

  void pauseGame() {
    if (!isRunning) return;
    _session = _session.copyWith(isRunning: false);
    pauseEngine();
  }

  void resumeGame() {
    if (_session.isGameOver || _session.isRunning) return;
    _session = _session.copyWith(isRunning: true);
    resumeEngine();
  }

  void restartCurrentLevel() {
    startLevel(_session.levelIndex);
  }

  void markGameOver() {
    if (_session.isGameOver) return;
    _session = _session.copyWith(
      isRunning: false,
      isGameOver: true,
    );
    pauseEngine();
  }

  @override
  void update(double dt) {
    if (isRunning) {
      // For now we only track vertical distance using scroll speed.
      // Camera scrolling and world generation will hook into this in
      // later chapters.
      final distanceDelta = _difficulty.scrollSpeed * dt;
      _session = _session.copyWith(
        verticalDistance: _session.verticalDistance + distanceDelta,
      );
    }

    super.update(dt);
  }
}


