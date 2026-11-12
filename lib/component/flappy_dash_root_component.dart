import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/text.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flappy_dash/component/pipe_pair.dart';
import 'package:flutter/material.dart';

import '../bloc/game/game_cubit.dart';
import '../bloc/game/game_state.dart';
import '../flappy_dash_game.dart';
import 'dash.dart';
import 'dash_parallax_background.dart';

class FlappyDashRootComponent extends Component
    with
        HasGameReference<FlappyDashGame>,
        FlameBlocReader<GameCubit, GameState> {
  late Dash _dash;
  late PipePair _lastPipe;
  static const _pipeDistance = 400.0;
  late TextComponent _scoreText;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
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
        ),
      ),
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
    _checkToStart();
    _dash.jump();
  }

  void onTapDown(TapDownEvent event) {
    _checkToStart();
    _dash.jump();
  }

  void _checkToStart() {
    if (bloc.state.currentPlayingState == PlayingState.gameOver) {
      _dash.reset();
      removeAll(children.whereType<PipePair>().toList());
      _generatePipes(fromX: 350);
      bloc.reset();
    }
    if (bloc.state.currentPlayingState == PlayingState.none) {
      bloc.startPLaying();
    }
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
