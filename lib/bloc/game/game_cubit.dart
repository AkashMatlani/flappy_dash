
import 'package:flutter_bloc/flutter_bloc.dart';

import 'game_state.dart';
class GameCubit extends Cubit<GameState> {
  GameCubit() : super(GameState());

  void startPLaying() {
    emit(
      state.copyWith(
        currentPlayingState: PlayingState.playing,
        currentScore: 0,
      ),
    );
  }

  void increaseScore() {
    emit(state.copyWith(currentScore: state.currentScore + 1));
  }

  void gameOver(){
    emit(state.copyWith(currentPlayingState: PlayingState.gameOver));
  }

  void restartGame(){
    emit(state.copyWith(
      currentPlayingState: PlayingState.none,
      currentScore: 0,
    ));
  }
}
