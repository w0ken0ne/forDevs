import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fordev/ui/pages/login_page.dart';

void main() {
  testWidgets("Should load with initial state correct",
      (WidgetTester tester) async {
    //arrange
    final loginPage = MaterialApp(home: LoginPage());
    await tester.pumpWidget(loginPage);

    final emailTextChildren = find.descendant(
        of: find.bySemanticsLabel("Email"), matching: find.byType(Text));

    expect(emailTextChildren, findsOneWidget,
        reason:
            'when a textformfield has only one child, means it has no error, since this child is the hint text');

    final passwordTextChildren = find.descendant(
        of: find.bySemanticsLabel("Senha"), matching: find.byType(Text));

    expect(passwordTextChildren, findsOneWidget,
        reason:
            'when a textformfield has only one child, means it has no error, since this child is the hint text');

    final button = tester.widget<RaisedButton>(find.byType(RaisedButton));

    expect(button.onPressed, null);
  });
}
