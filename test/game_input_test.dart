import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flappy_dash/bloc/game/game_cubit.dart';
import 'package:flappy_dash/bloc/game/game_state.dart';
import 'package:flappy_dash/component/dash.dart';
import 'package:flappy_dash/component/flappy_dash_root_component.dart';
import 'package:flappy_dash/component/pipe_pair.dart';
import 'package:flappy_dash/flappy_dash_game.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  for (final useTap in [true, false]) {
    testWidgets(
      '${useTap ? 'tap' : 'space'} starts and restarts a fresh game',
      (tester) async {
        final cubit = GameCubit();
        final game = FlappyDashGame(cubit);
        addTearDown(cubit.close);
        await tester.pumpWidget(GameWidget(game: game));
        await tester.runAsync(() async {
          await game.toBeLoaded();
          await game.ready();
        });
        await tester.pump();
        game.pauseEngine();

        void input() {
          if (useTap) {
            game.firstChild<MultiTapDispatcher>()!.onTapDown(
              TapDownEvent(
                1,
                game,
                TapDownDetails(globalPosition: const Offset(300, 500)),
              ),
            );
          } else {
            expect(
              game.onKeyEvent(
                const KeyDownEvent(
                  physicalKey: PhysicalKeyboardKey.space,
                  logicalKey: LogicalKeyboardKey.space,
                  timeStamp: Duration.zero,
                ),
                {LogicalKeyboardKey.space},
              ),
              KeyEventResult.handled,
            );
          }
        }

        final root = game.world.children.single.children
            .whereType<FlappyDashRootComponent>()
            .single;
        final dash = root.children.whereType<Dash>().single;
        input();
        expect(cubit.state.currentPlayingState, PlayingState.playing);
        dash.update(0.1);
        expect(dash.y, lessThan(0));

        for (var restart = 0; restart < 2; restart++) {
          final oldPipes = root.children.whereType<PipePair>().toList();
          dash.position.setValues(100, 200);
          cubit.increaseScore();
          cubit.gameOver();
          input();
          expect(cubit.state.currentPlayingState, PlayingState.playing);
          expect(cubit.state.currentScore, 0);
          expect(dash.position, Vector2.zero());
          await tester.runAsync(game.ready);
          final pipes = root.children.whereType<PipePair>().toList();
          expect(pipes, hasLength(5));
          expect(pipes.any(oldPipes.contains), isFalse);
          expect(pipes.first.x, 350);
          dash.update(0.1);
          expect(dash.x, 0);
          expect(dash.y, closeTo(-38, 0.001));
        }
      },
    );
  }
}
