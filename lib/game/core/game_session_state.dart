/// Immutable-ish snapshot of a single game session.
///
/// Keeps core state separate from Flame components so it can be
/// inspected, persisted, or extended later (e.g., for replays).
class GameSessionState {
  const GameSessionState({
    required this.levelIndex,
    required this.verticalDistance,
    required this.isRunning,
    required this.isGameOver,
  });

  /// Zero-based level index (0..N-1).
  final int levelIndex;

  /// Vertical distance traveled in logical world units.
  final double verticalDistance;

  final bool isRunning;
  final bool isGameOver;

  GameSessionState copyWith({
    int? levelIndex,
    double? verticalDistance,
    bool? isRunning,
    bool? isGameOver,
  }) {
    return GameSessionState(
      levelIndex: levelIndex ?? this.levelIndex,
      verticalDistance: verticalDistance ?? this.verticalDistance,
      isRunning: isRunning ?? this.isRunning,
      isGameOver: isGameOver ?? this.isGameOver,
    );
  }

  static GameSessionState initial({required int levelIndex}) {
    return GameSessionState(
      levelIndex: levelIndex,
      verticalDistance: 0,
      isRunning: false,
      isGameOver: false,
    );
  }
}

