// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:electrician_app/main.dart';
import 'package:electrician_app/injection_container.dart';

void main() {
  testWidgets('App loads without crashing', (WidgetTester tester) async {
    // Initialize dependencies before building the app
    await initializeDependencies();

    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());
    
    // Wait for initialization to complete
    await tester.pumpAndSettle();

    // Verify that the app loads without crashing
    // The app should show either onboarding or the dashboard
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
