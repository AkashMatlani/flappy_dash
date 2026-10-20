import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/palette.dart';

class Dash extends PositionComponent {
  Dash() : super(
      position: Vector2(0, 0),
      size: Vector2(40, 40),
      anchor: Anchor.center
  );

  late Sprite _dashSprite;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    debugMode=true;
    _dashSprite = await Sprite.load('dash.png');
  }

  @override
  void update(double dt) {
    super.update(dt);
    position = Vector2.zero();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    _dashSprite.render(canvas,size: size);
  }
}