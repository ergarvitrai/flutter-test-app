import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import '../lib/main.dart' as app;


void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group("integration tests", () {
    testWidgets('App opens successfully', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      app.main();
      await _pumpAndSettle(tester);

      // Verify that the app opens successfully.
      expect(find.text('Flutter Demo Home Page'), findsOneWidget);
    });

    testWidgets('Increment counter on FloatingActionButton tap', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      app.main();
      await _pumpAndSettle(tester);

      // Tap on the FloatingActionButton to increment the counter.
      await tester.tap(find.byType(FloatingActionButton));
      await _pumpAndSettle(tester);

      // Verify that the counter has been incremented.
      expect(find.text('1'), findsOneWidget);
    });

    testWidgets('App theme is applied correctly', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      app.main();
      await _pumpAndSettle(tester);

      // Verify that the app's theme is applied correctly.
      expect(
        tester.widget<AppBar>(find.byType(AppBar)).backgroundColor,
        Theme.of(tester.element(find.text('Flutter Demo Home Page'))).colorScheme.inversePrimary,
      );
    });

    testWidgets('App updates counter correctly after multiple increments', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(app.MyApp());

      // Tap on the FloatingActionButton multiple times to increment the counter.
      for (int i = 0; i < 5; i++) {
        await tester.tap(find.byType(FloatingActionButton));
        await tester.pump();
      }

      // Verify that the displayed counter is updated correctly.
      expect(find.text('5'), findsOneWidget);
    });
  });
}

Future<int> _pumpAndSettle(
    WidgetTester tester, [
      Duration duration = const Duration(milliseconds: 100),
      EnginePhase phase = EnginePhase.sendSemanticsUpdate,
      Duration timeout = const Duration(seconds: 30),
    ]) =>
    tester.pumpAndSettle(duration, phase, timeout);
