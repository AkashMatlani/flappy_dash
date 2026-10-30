import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'component/dash.dart';
import 'component/dash_parallax_background.dart';
import 'component/pipe_pair.dart';

class FlappyDashGame extends FlameGame<FlappyDashWorld> with KeyboardEvents {
  FlappyDashGame()
      : super(
    world: FlappyDashWorld(),
    camera: CameraComponent.withFixedResolution(width: 600, height: 1000),
  );

  @override
  KeyEventResult onKeyEvent(KeyEvent event,
      Set<LogicalKeyboardKey> keysPressed,) {
    final isKeyDown = event is KeyDownEvent;
    final isSPace = keysPressed.contains(LogicalKeyboardKey.space);

    if (isSPace && isKeyDown) {
      world.onSpaceDown();
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }
}

class FlappyDashWorld extends World with TapCallbacks {
  late Dash _dash;
  late PipePair _lastPipe;

  @override
  void onLoad() {
    super.onLoad();
    add(DashParallaxBackground());
    add(_dash = Dash());
    _generatePipes(fromX: 350);
  }

  void _generatePipes({
    int count = 20,
    double fromX = 0.0,
    double distance = 400.0
  }) {
    for (int i = 0; i < count; i++) {
      const area = 600;
      final y = (Random().nextDouble() * area) - (area / 2);
      add(_lastPipe=PipePair(position: Vector2(fromX+  (i* distance), y)));
    }
  }

  @override
  void onTapDown(TapDownEvent event) {
    // TODO: implement onTapDown
    super.onTapDown(event);
    _dash.jump();
  }

  void onSpaceDown() {
    _dash.jump();
  }

  @override
  void update(double dt) {
    super.update(dt);
    if(_dash.x>=_lastPipe.x){
      _generatePipes();
    }
  }
}
