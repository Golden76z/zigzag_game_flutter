/// Snapshot of difficulty parameters at a given moment or level.
///
/// World generation and camera logic should depend only on this
/// descriptor, not on scattered hard-coded values.
class DifficultyDescriptor {
  const DifficultyDescriptor({
    required this.columns,
    required this.scrollSpeed,
    required this.pathWidthColumns,
    required this.zigZagFrequency,
  });

  /// Number of vertical columns across the playfield.
  final int columns;

  /// Upward scroll speed (world units per second).
  final double scrollSpeed;

  /// Width of the safe path in number of columns.
  final int pathWidthColumns;

  /// Relative frequency of horizontal changes (0..1-ish).
  final double zigZagFrequency;
}

