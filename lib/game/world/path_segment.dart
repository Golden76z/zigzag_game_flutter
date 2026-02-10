/// Logical representation of a single vertical path segment.
///
/// The playfield is divided into vertical columns; a segment describes
/// which contiguous set of columns are safe for this vertical band.
class PathSegment {
  const PathSegment({
    required this.index,
    required this.startColumn,
    required this.widthColumns,
  });

  /// Zero-based segment index (0 at the bottom, increasing upwards).
  final int index;

  /// Leftmost safe column index (0-based).
  final int startColumn;

  /// Number of contiguous safe columns.
  final int widthColumns;
}

