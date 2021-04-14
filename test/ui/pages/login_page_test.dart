import 'dart:async';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fordev/ui/pages/pages.dart';
import 'package:mockito/mockito.dart';

class LoginPresenterSpy extends Mock implements LoginPresenter {}

void main() {
  LoginPresenter presenter;
  StreamController emailErrorController;
  StreamController passwordErrorController;
  StreamController<bool> isFormValidController;
  Future<void> loadPage(WidgetTester tester) async {
    presenter = LoginPresenterSpy();
    emailErrorController = StreamController<String>();
    passwordErrorController = StreamController<String>();
    isFormValidController = StreamController<bool>();
    when(presenter.emailErrorStream)
        .thenAnswer((_) => emailErrorController.stream);
    when(presenter.passwordErrorStream)
        .thenAnswer((_) => passwordErrorController.stream);
    when(presenter.isFormValidStream)
        .thenAnswer((_) => isFormValidController.stream);
    final loginPage = MaterialApp(
        home: LoginPage(
      presenter: presenter,
    ));
    await tester.pumpWidget(loginPage);
  }

  tearDown(() {
    emailErrorController.close();
    passwordErrorController.close();
    isFormValidController.close();
  });

  group("loginPage", () {
    testWidgets("Should load with initial state correct",
        (WidgetTester tester) async {
      //arrange
      await loadPage(tester);

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

    //validate form
    testWidgets("should call validate with correct values",
        (WidgetTester tester) async {
      //arrange
      await loadPage(tester);

      final email = faker.internet.email();
      await tester.enterText(find.bySemanticsLabel("Email"), email);
      verify(presenter.validateEmail(email));

      final password = faker.internet.password();
      await tester.enterText(find.bySemanticsLabel("Senha"), password);
      verify(presenter.validatePassword(password));
    });
  });

  //

  group("email test", () {
    testWidgets("should present error if email is invalid",
        (WidgetTester tester) async {
      await loadPage(tester);
      emailErrorController.add('any error');
      await tester.pump();
      expect(find.text('any error'), findsOneWidget);
    });
    testWidgets("should present no error if email is valid",
        (WidgetTester tester) async {
      await loadPage(tester);
      emailErrorController.add(null);
      await tester.pump();
      final emailTextChildren = find.descendant(
          of: find.bySemanticsLabel('Email'), matching: find.byType(Text));
      expect(emailTextChildren, findsOneWidget);
    });
    testWidgets("should present no error if email is valid with empty string",
        (WidgetTester tester) async {
      await loadPage(tester);
      emailErrorController.add('');
      await tester.pump();
      final emailTextChildren = find.descendant(
          of: find.bySemanticsLabel('Email'), matching: find.byType(Text));
      expect(emailTextChildren, findsOneWidget);
    });
  });
  group("password test", () {
    testWidgets("should present error if password is invalid",
        (WidgetTester tester) async {
      await loadPage(tester);
      passwordErrorController.add('any error');
      await tester.pump();
      expect(find.text('any error'), findsOneWidget);
    });
    testWidgets("should present no error if password is valid",
        (WidgetTester tester) async {
      await loadPage(tester);
      passwordErrorController.add(null);
      await tester.pump();
      final passwordTextChildren = find.descendant(
          of: find.bySemanticsLabel('Senha'), matching: find.byType(Text));
      expect(passwordTextChildren, findsOneWidget);
    });
    testWidgets("should present no error if email is valid with empty string",
        (WidgetTester tester) async {
      await loadPage(tester);
      passwordErrorController.add('');
      await tester.pump();
      final passwordTextChildren = find.descendant(
          of: find.bySemanticsLabel('Email'), matching: find.byType(Text));
      expect(passwordTextChildren, findsOneWidget);
    });
  });
  group("button", () {
    testWidgets("should enable button if form is valid",
        (WidgetTester tester) async {
      await loadPage(tester);
      isFormValidController.add(true);
      await tester.pump();
      final button = tester.widget<RaisedButton>(find.byType(RaisedButton));
      expect(button.onPressed, isNotNull);
    });
  });
}