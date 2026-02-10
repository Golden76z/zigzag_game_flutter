import 'dart:ui' show Color, Paint;

import 'package:flame/components.dart';

/// Simple circular player placeholder.
///
/// The player only moves horizontally; its vertical position is fixed
/// relative to the viewport. Horizontal motion is smoothed towards a
/// target x-position for a non-grid-locked feel.
class PlayerComponent extends CircleComponent {
  PlayerComponent({
    required double radius,
    required Vector2 initialPosition,
  })  : _targetX = initialPosition.x,
        super(
          position: initialPosition,
          radius: radius,
          anchor: Anchor.center,
          paint: Paint()..color = const Color(0xFFFFC857),
        );

  double _targetX;

  /// Nudge the target x-position by the given delta (in world units).
  void nudgeHorizontally(double dx) {
    _targetX += dx;
  }

  /// Optionally clamp the target position to a specific interval.
  void clampTargetX(double minX, double maxX) {
    if (_targetX < minX) _targetX = minX;
    if (_targetX > maxX) _targetX = maxX;
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Smooth horizontal movement towards the target x.
    const double smoothing = 10; // higher = snappier
    final dx = _targetX - position.x;
    position.x += dx * smoothing * dt;
  }
}

