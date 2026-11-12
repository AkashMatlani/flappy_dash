import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/game/game_cubit.dart';

class GameOverWidget extends StatelessWidget {
  const GameOverWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Game Over",
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.read<GameCubit>().restartGame(),
              child: const Text('PLAY AGAIN!'),
            ),
          ],
        ),
      ),
    );
  }
}
