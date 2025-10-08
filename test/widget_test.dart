// This is a basic Flutter widget test for the Air Hockey game.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flame/game.dart';

import 'package:running/main.dart';

void main() {
  testWidgets('Game app loads correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: GameWidget(
          game: AirHockeyGame(),
        ),
      ),
    ));

    // Verify that the game loads without errors
    expect(find.byType(GameWidget), findsOneWidget);
    expect(find.byType(Scaffold), findsOneWidget);
  });
}
