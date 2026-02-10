import 'difficulty_descriptor.dart';

/// Static configuration for a discrete level.
///
/// This supports the "10 unlockable levels" requirement while still
/// allowing difficulty to evolve over distance within a level.
class LevelConfig {
  const LevelConfig({
    required this.id,
    required this.displayName,
    required this.targetDistance,
    required this.baseDifficulty,
  });

  /// Stable identifier (e.g., "level_1").
  final String id;

  /// Human-readable name (e.g., "Level 1").
  final String displayName;

  /// Distance that counts as "level completed".
  /// The actual run can continue beyond this if we later support endless.
  final double targetDistance;

  /// Base difficulty descriptor for this level.
  final DifficultyDescriptor baseDifficulty;
}

/// Initial list of levels. This is intentionally data-driven so we can
/// tune values without touching core logic.
class Levels {
  static List<LevelConfig> initialLevels() {
    // TODO: Tune these values once core gameplay feels right.
    return [
      LevelConfig(
        id: 'level_1',
        displayName: 'Level 1',
        targetDistance: 1000,
        baseDifficulty: const DifficultyDescriptor(
          columns: 5,
          scrollSpeed: 60,
          pathWidthColumns: 3,
          zigZagFrequency: 0.2,
        ),
      ),
      LevelConfig(
        id: 'level_2',
        displayName: 'Level 2',
        targetDistance: 1300,
        baseDifficulty: const DifficultyDescriptor(
          columns: 6,
          scrollSpeed: 65,
          pathWidthColumns: 3,
          zigZagFrequency: 0.25,
        ),
      ),
      // TODO: Add additional levels up to ~10 as we tune.
    ];
  }
}

