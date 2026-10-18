import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';

class FlappyDashGame extends FlameGame<FlappyDashWorld> {
  FlappyDashGame()
      : super(
    world: FlappyDashWorld(),
    camera: CameraComponent.withFixedResolution(width: 600, height: 1000),
  );
}

class FlappyDashWorld extends World {

  @override
  void onLoad() {
    super.onLoad();
  }
}

class Dash extends PositionComponent {
  Dash() : super(
      position: Vector2(0, 0),
      size: Vector2(20, 20)
  );
  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawCircle(Offset.zero, 20, BasicPalette.blue.paint());
  }
}
