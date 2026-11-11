import 'package:flame/game.dart';
import 'package:flappy_dash/bloc/game/game_cubit.dart';
import 'package:flappy_dash/bloc/game/game_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'flappy_dash_game.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late FlappyDashGame _flappyDashGame;
  late GameCubit gameCubit;
 PlayingState? _latestState;
  @override
  void initState() {
    gameCubit = BlocProvider.of<GameCubit>(context);
    _flappyDashGame = FlappyDashGame(gameCubit);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GameCubit, GameState>(
        listener: (context, state){
          if(state.currentPlayingState==PlayingState.none && _latestState ==PlayingState.gameOver){
           setState(() {
             _flappyDashGame =FlappyDashGame(gameCubit);
           });
          }
          _latestState =state.currentPlayingState;
        },
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              GameWidget(game: _flappyDashGame),
              if(state.currentPlayingState== PlayingState.gameOver)
              Container(
                color: Colors.black54,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Game Over",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: ()=>gameCubit.restartGame(),
                        child: const Text('PLAY AGAIN!'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
