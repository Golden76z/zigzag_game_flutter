import 'dart:ui' show Color, Paint;

import 'package:flame/components.dart';
import 'package:flame/game.dart' as flame;

import '../difficulty/difficulty_curve.dart';
import '../difficulty/difficulty_descriptor.dart';
import '../difficulty/level_config.dart';
import '../player/player_component.dart';
import '../player/swipe_input_layer.dart';
import '../world/path_world.dart';
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
  late final PathWorld _pathWorld;
  late final PlayerComponent _player;
  double _fps = 0;

  GameSessionState get session => _session;
  DifficultyDescriptor get difficulty => _difficulty;
  PathWorld get pathWorld => _pathWorld;
  PlayerComponent get player => _player;

  bool get isRunning => _session.isRunning && !_session.isGameOver;
  bool get isGameOver => _session.isGameOver;
  bool get isPaused => !_session.isRunning && !_session.isGameOver;

  LevelConfig get currentLevel => levels[_session.levelIndex];

  // Simple listener mechanism so the Flutter UI can react to session
  // changes without coupling the game core directly to Flutter types.
  final List<void Function(GameSessionState)> _sessionListeners = [];

  void addSessionListener(void Function(GameSessionState) listener) {
    _sessionListeners.add(listener);
    listener(_session);
  }

  void removeSessionListener(void Function(GameSessionState) listener) {
    _sessionListeners.remove(listener);
  }

  void _setSession(GameSessionState next) {
    _session = next;
    for (final listener in List.of(_sessionListeners)) {
      listener(_session);
    }
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Simple background so we can see the game area before real
    // world/path rendering is implemented.
    add(
      RectangleComponent(
        position: Vector2.zero(),
        size: worldSize,
        paint: Paint()..color = const Color(0xFF101018),
      ),
    );

    // Add path/world manager which will generate and maintain the
    // zig-zag safe path ahead of the player.
    _pathWorld = PathWorld(
      worldSize: worldSize,
      getDifficulty: () => _difficulty,
      getDistance: () => _session.verticalDistance,
    );
    add(_pathWorld);

    // Player sits slightly above the bottom of the screen.
    final playerRadius = worldSize.x * 0.04;
    final playerY = worldSize.y * 0.75;
    _player = PlayerComponent(
      radius: playerRadius,
      initialPosition: Vector2(worldSize.x / 2, playerY),
    );
    add(_player);

    // Input layer that covers the entire world and translates
    // horizontal drags into player movement.
    add(
      SwipeInputLayer(
        player: _player,
        worldSize: worldSize,
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
    _setSession(
      GameSessionState.initial(levelIndex: levelIndex).copyWith(
        isRunning: true,
      ),
    );
    _difficulty = DifficultyCurve.evaluate(level, 0);

    resumeEngine();
  }

  void pauseGame() {
    if (!isRunning) return;
    _setSession(_session.copyWith(isRunning: false));
    pauseEngine();
  }

  void resumeGame() {
    if (_session.isGameOver || _session.isRunning) return;
    _setSession(_session.copyWith(isRunning: true));
    resumeEngine();
  }

  void restartCurrentLevel() {
    startLevel(_session.levelIndex);
  }

  void markGameOver() {
    if (_session.isGameOver) return;
    _setSession(
      _session.copyWith(
        isRunning: false,
        isGameOver: true,
      ),
    );
    pauseEngine();
  }

  @override
  void update(double dt) {
    if (isRunning) {
      final level = levels[_session.levelIndex];

      // Update difficulty based on current run distance.
      _difficulty = DifficultyCurve.evaluate(
        level,
        _session.verticalDistance,
      );

      // Track vertical distance using the current scroll speed.
      final distanceDelta = _difficulty.scrollSpeed * dt;
      _setSession(
        _session.copyWith(
          verticalDistance: _session.verticalDistance + distanceDelta,
        ),
      );

      _checkCollisions();
    }

    // Track a smoothed FPS estimate for debug overlays.
    if (dt > 0) {
      final currentFps = 1 / dt;
      const alpha = 0.1;
      _fps = _fps == 0 ? currentFps : _fps * (1 - alpha) + currentFps * alpha;
    }

    super.update(dt);
  }

  double get fps => _fps;

  void _checkCollisions() {
    final pos = _player.position;
    final radius = _player.radius;

    final withinHorizontal =
        pos.x - radius >= 0 && pos.x + radius <= worldSize.x;
    final withinVertical =
        pos.y - radius >= 0 && pos.y + radius <= worldSize.y;

    if (!withinHorizontal || !withinVertical) {
      markGameOver();
      return;
    }

    if (!pathWorld.isPointInSafePath(pos)) {
      markGameOver();
    }
  }
}


