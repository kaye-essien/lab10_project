import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab10_project/logic/split.dart';
import 'package:lab10_project/main.dart';

void main() {
  group('shareOf unit tests', () {
    test('splits a bill evenly without tip', () {
      expect(shareOf(120, 4), 30);
      expect(() => shareOf(50, 0), throwsArgumentError);
    });

    // Exercise 3: Unit tests for tip options
    test('splits a bill including 5% and 10% tip', () {
      expect(shareOf(100, 2, tipPercent: 5), closeTo(52.5, 0.001));
      expect(shareOf(100, 4, tipPercent: 10), closeTo(27.5, 0.001));
      expect(() => shareOf(100, 2, tipPercent: -5), throwsArgumentError);
    });
  });

  group('SplitApp widget tests', () {
    testWidgets('shows each share after Split', (tester) async {
      await tester.pumpWidget(const SplitApp());
      expect(find.text('Enter the bill total'), findsOneWidget);

      await tester.enterText(find.byType(TextField), '90');
      await tester.tap(find.byIcon(Icons.add)); // now 3 people
      await tester.pump();
      expect(find.text('3 people'), findsOneWidget);

      await tester.tap(find.text('Split'));
      await tester.pump();
      expect(find.text('Each person pays GHS 30.00'), findsOneWidget);
    });

    // Exercise 1: Widget test for invalid input 'abc'
    testWidgets('shows error message when entering invalid text abc',
        (tester) async {
      await tester.pumpWidget(const SplitApp());

      await tester.enterText(find.byType(TextField), 'abc');
      await tester.tap(find.text('Split'));
      await tester.pump();

      expect(find.text('Please enter a valid amount'), findsOneWidget);
    });

    // Exercise 3: Widget test for SegmentedButton tip selection
    testWidgets('applies 10% tip option when selected', (tester) async {
      await tester.pumpWidget(const SplitApp());

      await tester.enterText(find.byType(TextField), '100');
      await tester.tap(find.text('10% tip'));
      await tester.pump();

      await tester.tap(find.text('Split'));
      await tester.pump();

      expect(find.text('Each person pays GHS 55.00'), findsOneWidget);
    });
  });
}