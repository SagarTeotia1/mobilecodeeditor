import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:coding_practice_app/main.dart';
import 'package:coding_practice_app/providers/app_state.dart';
import 'package:coding_practice_app/screens/home_page.dart';

void main() {
  testWidgets('CodingPracticeApp widget test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (context) => AppState(),
        child: CodingPracticeApp(),
      ),
    );

    // Verify that the app title is displayed
    expect(find.text('Coding Practice App'), findsOneWidget);

    // Verify that the HomePage is the initial route
    expect(find.byType(HomePage), findsOneWidget);
  });

  testWidgets('HomePage displays language list', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (context) => AppState(),
        child: MaterialApp(home: HomePage()),
      ),
    );

    // Verify that the language list is displayed
    expect(find.byType(ListView), findsOneWidget);

    // Verify that some of the languages are displayed
    expect(find.text('Python'), findsOneWidget);
    expect(find.text('JavaScript'), findsOneWidget);
    expect(find.text('Java'), findsOneWidget);

    // Verify that the language icons are displayed
    expect(find.text('🐍'), findsOneWidget); // Python icon
    expect(find.text('🌐'), findsOneWidget); // JavaScript icon
    expect(find.text('☕'), findsOneWidget); // Java icon
  });

  testWidgets('Tapping a language navigates to LanguagePage', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (context) => AppState(),
        child: MaterialApp(home: HomePage()),
      ),
    );

    // Tap the Python language item
    await tester.tap(find.text('Python'));
    await tester.pumpAndSettle();

    // Verify that we've navigated to the LanguagePage
    expect(find.text('Python'), findsOneWidget);
    expect(find.byType(AppBar), findsOneWidget);
    expect(find.text('Run Code'), findsOneWidget);
  });
}