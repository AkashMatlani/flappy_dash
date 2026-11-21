import 'package:flappy_dash/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'shows the start prompt when the app launches',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MyApp(animatePrompt: false),
      );

      expect(find.text('TAP TO PLAY'), findsOneWidget);
    },
  );
}