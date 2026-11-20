import 'package:flappy_dash/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shows the start prompt when the app launches', (
      WidgetTester tester,
      ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('PRESS TO START'), findsOneWidget);

    // Unmount the game and its widgets.
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump();
  });
}