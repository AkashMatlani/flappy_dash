import 'package:flame/components.dart';
import 'package:flame/extensions.dart';

class Pipe extends PositionComponent {
  late Sprite _pipeSprite;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    _pipeSprite = await Sprite.load('pipe.png');
    position = Vector2(0, 0);
    anchor = Anchor.topCenter;
    final ratio = _pipeSprite.srcSize.y / _pipeSprite.srcSize.x;
    const width=82.0;
    size = Vector2(width, width * ratio);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    _pipeSprite.render(canvas,
    position: Vector2.zero(),
    size: size);
  }
}
