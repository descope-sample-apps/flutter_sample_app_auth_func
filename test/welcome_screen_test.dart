import 'package:flutter/cupertino.dart';
import 'package:flutter_sample_app_auth_func/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Renders WelcomeScreen message and button',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(
        find.text("Welcome to Descope's Flutter Sample App!"), findsOneWidget);
    expect(find.byType(CupertinoButton), findsOneWidget);
  });
}
