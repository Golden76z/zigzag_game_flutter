import 'dart:ui' show Canvas, Color, Offset, Paint, Rect;

import 'package:flame/components.dart';

import '../difficulty/difficulty_descriptor.dart';
import 'path_generator.dart';
import 'path_segment.dart';

/// Manages world/path segments and their visual representation.
///
/// This component is responsible for:
/// - Generating zig-zag path segments ahead of the player.
/// - Keeping enough segments on screen and a small buffer above/below.
/// - Cleaning up segments that scroll far off-screen.
class PathWorld extends Component {
  PathWorld({
    required this.worldSize,
    required this.getDifficulty,
    required this.getDistance,
  }) : _segmentHeight = worldSize.y / 12;

  /// Logical world size (same coordinate space as the game).
  final Vector2 worldSize;

  /// Provider for current difficulty, so we can read zig-zag frequency.
  final DifficultyDescriptor Function() getDifficulty;

  /// Provider for current vertical distance travelled.
  ///
  /// This should increase over time while the game is running.
  final double Function() getDistance;

  final double _segmentHeight;
  late final PathGenerator _generator;

  final List<_VisualSegment> _segments = [];

  double get _bufferHeight => _segmentHeight * 4;

  /// When true, draws debug column guides on top of the world.
  bool debugDrawColumns = false;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final difficulty = getDifficulty();
    _generator = PathGenerator(difficulty: difficulty);

    // Ensure we have some segments to start with.
    _ensureSegmentsForDistance(0, difficulty);
    _updateSegmentPositions(0, difficulty);
  }

  @override
  void update(double dt) {
    final distance = getDistance();
    final difficulty = getDifficulty();

    _ensureSegmentsForDistance(distance, difficulty);
    _updateSegmentPositions(distance, difficulty);
    _cleanupSegments(distance);

    super.update(dt);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    if (!debugDrawColumns || _segments.isEmpty) {
      return;
    }

    final difficulty = getDifficulty();
    final columnWidth = _columnWidth(difficulty);
    final guidePaint = Paint()
      ..color = const Color(0x33FFFFFF)
      ..strokeWidth = 1;

    for (var i = 1; i < difficulty.columns; i++) {
      final x = columnWidth * i;
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, worldSize.y),
        guidePaint,
      );
    }
  }

  /// Returns true if the given point (in world/screen coordinates)
  /// lies within any current safe path segment.
  bool isPointInSafePath(Vector2 point) {
    for (final vs in _segments) {
      final rect = Rect.fromLTWH(
        vs.rect.position.x,
        vs.rect.position.y,
        vs.rect.size.x,
        vs.rect.size.y,
      );
      if (rect.contains(Offset(point.x, point.y))) {
        return true;
      }
    }
    return false;
  }

  void _ensureSegmentsForDistance(
    double distance,
    DifficultyDescriptor difficulty,
  ) {
    // We want segments to extend downwards beyond the bottom of the screen
    // by a small buffer so the path doesn't suddenly end.
    final neededBottomWorld =
        distance + worldSize.y + _bufferHeight; // in world "distance" units

    int lastIndex = _segments.isEmpty ? -1 : _segments.last.segment.index;
    double lastBottomWorld = (lastIndex + 1) * _segmentHeight;

    final double zigZagFrequency = difficulty.zigZagFrequency;
    while (lastBottomWorld < neededBottomWorld) {
      final segment = _generator.nextSegment(zigZagFrequency);
      final rect = RectangleComponent(
        position: Vector2.zero(), // set in _updateSegmentPositions
        size: Vector2(
          _columnWidth(difficulty) * segment.widthColumns,
          _segmentHeight,
        ),
        paint: Paint()..color = const Color(0xFF3DDC97), // safe path color
      );
      _segments.add(_VisualSegment(segment: segment, rect: rect));
      add(rect);

      lastIndex = segment.index;
      lastBottomWorld = (lastIndex + 1) * _segmentHeight;
    }
  }

  void _updateSegmentPositions(
    double distance,
    DifficultyDescriptor difficulty,
  ) {
    final columnWidth = _columnWidth(difficulty);

    for (final vs in _segments) {
      final segment = vs.segment;
      final double worldTop = segment.index * _segmentHeight;
      final double screenY = worldTop - distance;

      vs.rect.position
        ..x = segment.startColumn * columnWidth
        ..y = screenY;
    }
  }

  void _cleanupSegments(double distance) {
    // Remove segments that are well above the visible area.
    final double cutoffWorld = distance - _bufferHeight;

    while (_segments.isNotEmpty) {
      final first = _segments.first;
      final double bottomWorld =
          (first.segment.index + 1) * _segmentHeight; // bottom edge
      if (bottomWorld >= cutoffWorld) {
        break;
      }

      first.rect.removeFromParent();
      _segments.removeAt(0);
    }
  }

  double _columnWidth(DifficultyDescriptor difficulty) {
    return worldSize.x / difficulty.columns;
  }
}

class _VisualSegment {
  _VisualSegment({
    required this.segment,
    required this.rect,
  });

  final PathSegment segment;
  final RectangleComponent rect;
}

