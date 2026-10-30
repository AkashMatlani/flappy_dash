import 'dart:ui';

import 'package:flame/components.dart';

class Dash extends PositionComponent {
  Dash()
    : super(
        position: Vector2(0, 0),
        size: Vector2(40, 40),
        anchor: Anchor.center,
      );

  late Sprite _dashSprite;
  final Vector2 _gravity = Vector2(0, 1200.0);
  Vector2 _velocity = Vector2(0, 0);
  final Vector2 _jumpForce = Vector2(0, -500);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    debugMode = true;
    _dashSprite = await Sprite.load('dash.png');
  }

  @override
  void update(double dt) {
    super.update(dt);
    _velocity += _gravity * dt;
    position += _velocity * dt;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    _dashSprite.render(canvas, size: size);
  }

  void jump() {
    _velocity = _jumpForce;
  }
}
