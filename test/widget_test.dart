import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:simple_color_generator/main.dart';

void main() {
  /// Test generate color
  testWidgets('Generate new color on screen tap', (WidgetTester tester) async {
    await tester.pumpWidget(const Main());

    // Verify that our app begins with a random color
    expect(find.text('Hello there'), findsOneWidget);
    expect(find.textContaining(RegExp(r'0x[0-9A-F]{8}$')), findsOneWidget);

    // Click anywhere in app
    await tester.tap(find.byKey(const Key('home_bg')));
    expect(find.textContaining(RegExp(r'0x[0-9A-F]{8}$')), findsOneWidget);
  });

  /// Test copy color
  testWidgets('Copy current color in HEX format', (WidgetTester tester) async {
    await tester.pumpWidget(const Main());

    // Find the Copy icon
    expect(find.byIcon(Icons.copy), findsOneWidget);
  });
}
