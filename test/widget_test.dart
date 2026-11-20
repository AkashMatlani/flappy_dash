
import 'package:flappy_dash/main.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'shows the start prompt when the app launches',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      expect(find.text('TAP TO PLAY'), findsOneWidget);

      // Dispose the widget tree.
      await tester.pumpWidget(const SizedBox.shrink());
    },
  );
}
