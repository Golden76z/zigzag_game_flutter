import '../difficulty/difficulty_descriptor.dart';
import 'path_segment.dart';

/// Deterministic zig-zag path generator.
///
/// Given a difficulty descriptor, this produces a sequence of path
/// segments that always remain playable (no impossible layouts)
/// and stay within the configured number of columns.
class PathGenerator {
  PathGenerator({
    required DifficultyDescriptor difficulty,
  })  : _columns = difficulty.columns,
        _pathWidthColumns = difficulty.pathWidthColumns {
    assert(
      _pathWidthColumns > 0 && _pathWidthColumns <= _columns,
      'Path width must be between 1 and columns',
    );

    _currentStartColumn = (_columns - _pathWidthColumns) ~/ 2;
  }

  final int _columns;
  final int _pathWidthColumns;

  int _currentIndex = 0;
  int _currentStartColumn = 0;
  int _direction = 1; // -1 or 1, flips when we hit edges.

  /// Generate the next path segment.
  ///
  /// This implementation zig-zags by occasionally stepping left/right
  /// while ensuring the safe path stays entirely inside the column
  /// range. It is deterministic for a given sequence of calls.
  PathSegment nextSegment(double zigZagFrequency) {
    // Decide if we should move horizontally this segment.
    //
    // We approximate the frequency by turning it into a segment
    // interval. For example, 0.2 => every ~5 segments.
    if (zigZagFrequency > 0 && _currentIndex > 0) {
      final int period =
          (1 / zigZagFrequency).round().clamp(1, 20); // safety clamp
      if (_currentIndex % period == 0) {
        // Try to move in the current direction; bounce at edges.
        var nextStart = _currentStartColumn + _direction;
        final maxStart = _columns - _pathWidthColumns;

        if (nextStart < 0 || nextStart > maxStart) {
          _direction = -_direction;
          nextStart = _currentStartColumn + _direction;
        }

        _currentStartColumn = nextStart.clamp(0, maxStart);
      }
    }

    final segment = PathSegment(
      index: _currentIndex,
      startColumn: _currentStartColumn,
      widthColumns: _pathWidthColumns,
    );

    _currentIndex++;
    return segment;
  }
}

