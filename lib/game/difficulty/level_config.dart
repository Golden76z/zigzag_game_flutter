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
      LevelConfig(
        id: 'level_3',
        displayName: 'Level 3',
        targetDistance: 1500,
        baseDifficulty: const DifficultyDescriptor(
          columns: 6,
          scrollSpeed: 70,
          pathWidthColumns: 3,
          zigZagFrequency: 0.28,
        ),
      ),
      LevelConfig(
        id: 'level_4',
        displayName: 'Level 4',
        targetDistance: 1700,
        baseDifficulty: const DifficultyDescriptor(
          columns: 7,
          scrollSpeed: 75,
          pathWidthColumns: 3,
          zigZagFrequency: 0.3,
        ),
      ),
      LevelConfig(
        id: 'level_5',
        displayName: 'Level 5',
        targetDistance: 1900,
        baseDifficulty: const DifficultyDescriptor(
          columns: 7,
          scrollSpeed: 80,
          pathWidthColumns: 3,
          zigZagFrequency: 0.32,
        ),
      ),
      LevelConfig(
        id: 'level_6',
        displayName: 'Level 6',
        targetDistance: 2100,
        baseDifficulty: const DifficultyDescriptor(
          columns: 8,
          scrollSpeed: 85,
          pathWidthColumns: 3,
          zigZagFrequency: 0.34,
        ),
      ),
      LevelConfig(
        id: 'level_7',
        displayName: 'Level 7',
        targetDistance: 2300,
        baseDifficulty: const DifficultyDescriptor(
          columns: 8,
          scrollSpeed: 90,
          pathWidthColumns: 2,
          zigZagFrequency: 0.36,
        ),
      ),
      LevelConfig(
        id: 'level_8',
        displayName: 'Level 8',
        targetDistance: 2500,
        baseDifficulty: const DifficultyDescriptor(
          columns: 9,
          scrollSpeed: 95,
          pathWidthColumns: 2,
          zigZagFrequency: 0.38,
        ),
      ),
      LevelConfig(
        id: 'level_9',
        displayName: 'Level 9',
        targetDistance: 2800,
        baseDifficulty: const DifficultyDescriptor(
          columns: 9,
          scrollSpeed: 100,
          pathWidthColumns: 2,
          zigZagFrequency: 0.4,
        ),
      ),
      LevelConfig(
        id: 'level_10',
        displayName: 'Level 10',
        targetDistance: 3200,
        baseDifficulty: const DifficultyDescriptor(
          columns: 10,
          scrollSpeed: 105,
          pathWidthColumns: 2,
          zigZagFrequency: 0.45,
        ),
      ),
    ];
  }
}

