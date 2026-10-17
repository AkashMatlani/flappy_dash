import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';

import 'flappy_dash_game.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GameWidget(game: FlappyDashGame());
  }
}
