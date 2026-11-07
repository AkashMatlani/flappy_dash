import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flappy_dash/bloc/game/game_cubit.dart';
import 'package:flappy_dash/bloc/game/game_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'component/dash.dart';
import 'component/dash_parallax_background.dart';
import 'component/pipe_pair.dart';

class FlappyDashGame extends FlameGame<FlappyDashWorld>
    with KeyboardEvents, HasCollisionDetection {
  FlappyDashGame(this.gameCubit)
    : super(
        world: FlappyDashWorld(),
        camera: CameraComponent.withFixedResolution(width: 600, height: 1000),
      );

  final GameCubit gameCubit;

  @override
  KeyEventResult onKeyEvent(
    KeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    final isKeyDown = event is KeyDownEvent;
    final isSPace = keysPressed.contains(LogicalKeyboardKey.space);

    if (isSPace && isKeyDown) {
      world.onSpaceDown();
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }
}

class FlappyDashWorld extends World
    with TapCallbacks,HasGameReference<FlappyDashGame> {

  late FlappyDashRootComponent _rootComponent;

  @override
  void onLoad() {
    super.onLoad();
    add(FlameBlocProvider<GameCubit,GameState>(
        create: ()=>game.gameCubit,children: [
      _rootComponent= FlappyDashRootComponent(),
    ]));
  }

  void onSpaceDown() => _rootComponent.onSpaceDown();


  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
   _rootComponent.onTapDown(event);
  }
}

class FlappyDashRootComponent extends Component with TapCallbacks , HasGameReference<FlappyDashGame>,FlameBlocReader<GameCubit,GameState>{
  late Dash _dash;
  late PipePair _lastPipe;
  static const _pipeDistance = 400.0;
  late TextComponent _scoreText;

  @override
  Future<void> onLoad()  async{
    super.onLoad();
    add(DashParallaxBackground());
    add(_dash = Dash());
    _generatePipes(fromX: 350);
    add(
    _scoreText = TextComponent(
      text: '0',
      position: Vector2(0, -(game.size.y / 2)),
        anchor: Anchor.topCenter,
        textRenderer: TextPaint(
          style: const TextStyle(
            fontSize: 50,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),),
    );
  }

  void _generatePipes({int count = 5, double fromX = 0.0}) {
    for (int i = 0; i < count; i++) {
      const area = 600;
      final y = (Random().nextDouble() * area) - (area / 2);
      add(
        _lastPipe = PipePair(position: Vector2(fromX + (i * _pipeDistance), y)),
      );
    }
  }

  void _removePipes() {
    final pipes = children.whereType<PipePair>();
    final shouldBeRemoved = max(pipes.length - 10, 0);
    pipes.take(shouldBeRemoved).forEach((pipe) {
      pipe.removeFromParent();
    });
  }


  void onSpaceDown() {
    _dash.jump();
  }

  void onTapDown(TapDownEvent event) {
    _dash.jump();
  }

  @override
  void update(double dt) {
    super.update(dt);
    _scoreText.text = bloc.state.currentScore.toString();
    if (_dash.x >= _lastPipe.x) {
      _generatePipes(fromX: _pipeDistance);
      _removePipes();
    }
    game.camera.viewfinder.zoom = 1.0;
  }
}
