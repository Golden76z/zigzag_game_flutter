import 'difficulty_descriptor.dart';
import 'level_config.dart';

/// Provides a simple, data-driven difficulty curve over distance.
///
/// For now this primarily scales scroll speed and zig-zag frequency as
/// the player climbs within a level. Columns and path width remain
/// fixed per level to keep layouts readable.
class DifficultyCurve {
  const DifficultyCurve._();

  /// Compute the effective difficulty at a given vertical distance
  /// within the current level.
  static DifficultyDescriptor evaluate(
    LevelConfig level,
    double distance,
  ) {
    final base = level.baseDifficulty;

    // Progress 0..1 within the level; clamped so that we don't grow
    // difficulty uncontrollably beyond the target distance.
    final t = (distance / level.targetDistance).clamp(0.0, 1.0);

    // Scroll speed ramps up to +60% over the level.
    final scrollSpeed = base.scrollSpeed * (1.0 + 0.6 * t);

    // Zig-zag frequency ramps up modestly to avoid unfair chaos.
    final zigZagFrequency = base.zigZagFrequency + 0.25 * t;

    return DifficultyDescriptor(
      columns: base.columns,
      scrollSpeed: scrollSpeed,
      pathWidthColumns: base.pathWidthColumns,
      zigZagFrequency: zigZagFrequency,
    );
  }
}

