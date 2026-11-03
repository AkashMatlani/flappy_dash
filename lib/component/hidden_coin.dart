import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/palette.dart';

class HiddenCoin extends PositionComponent {
  HiddenCoin({required super.position})
    : super(size: Vector2(24, 24), anchor: Anchor.center);

  @override
  void render(Canvas canvas) {
    // TODO: implement render
    super.render(canvas);
    canvas.drawCircle(
      (size / 2).toOffset(),
      size.x / 2,
      BasicPalette.yellow.paint(),
    );
  }

  @override
  void onLoad() {
    // TODO: implement onLoad
    super.onLoad();
    add(CircleHitbox(collisionType: CollisionType.inactive));
  }
}
