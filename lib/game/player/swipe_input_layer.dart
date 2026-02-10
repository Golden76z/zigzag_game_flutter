import 'package:flame/components.dart';
import 'package:flame/events.dart';

import 'player_component.dart';

/// Full-screen input layer that translates horizontal drag gestures
/// into smooth horizontal movement for the player.
class SwipeInputLayer extends PositionComponent with DragCallbacks {
  SwipeInputLayer({
    required this.player,
    required Vector2 worldSize,
  }) : super(
          position: Vector2.zero(),
          size: worldSize,
        );

  final PlayerComponent player;

  @override
  void onDragUpdate(DragUpdateEvent event) {
    super.onDragUpdate(event);
    // Only care about horizontal movement; use localDelta so this
    // matches world coordinates for this full-screen component.
    final dx = event.localDelta.x;
    player.nudgeHorizontally(dx);
  }
}

