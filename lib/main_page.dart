
import 'package:flame/game.dart';
import 'package:flappy_dash/bloc/game/game_cubit.dart';
import 'package:flappy_dash/bloc/game/game_state.dart';
import 'package:flappy_dash/widget/game_over_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'flappy_dash_game.dart';


class MainPage extends StatefulWidget {
  const MainPage({
    super.key,
    this.animatePrompt = true,
  });

  final bool animatePrompt;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late FlappyDashGame _flappyDashGame;
  late GameCubit gameCubit;

  @override
  void initState() {
    super.initState();
    gameCubit = BlocProvider.of<GameCubit>(context);
    _flappyDashGame = FlappyDashGame(gameCubit);
  }

  @override
  Widget build(BuildContext context) {
    final prompt = const Text(
      'TAP TO PLAY',
      style: TextStyle(
        color: Color(0XFF2387FC),
        fontWeight: FontWeight.bold,
        fontSize: 38,
        letterSpacing: 4,
      ),
    );

    final promptWidget = widget.animatePrompt
        ? prompt
        .animate(
      onPlay: (controller) => controller.repeat(reverse: true),
    )
        .scale(
      begin: const Offset(1.0, 1.0),
      end: const Offset(1.2, 1.2),
      duration: const Duration(milliseconds: 500),
    )
        : prompt;

    return BlocBuilder<GameCubit, GameState>(
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              GameWidget(game: _flappyDashGame),

              if (state.currentPlayingState == PlayingState.none)
                Align(
                  alignment: const Alignment(0, 0.2),
                  child: promptWidget,
                ),

              if (state.currentPlayingState == PlayingState.gameOver)
                GameOverWidget(),
            ],
          ),
        );
      },
    );
  }
}

