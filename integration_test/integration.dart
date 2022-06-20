import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:notes/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group("end to end test", () {
    testWidgets("read note", (tester) async {
      app.main();
      await tester.pumpAndSettle();
      final Finder noteFinder =
          find.byKey(const Key('note_d3YN1Y0wXB6mWktYU3f3'));
      expect(noteFinder, findsOneWidget);
    });

    // testWidgets("tap login button", (tester) async {
    //   app.main();
    //   await tester.pumpAndSettle();
    //   expect(find.text("NotApp"), findsOneWidget);

    //   final Finder onboardButton =
    //       find.byKey(const Key("onboard_login_button"));
    //   expect(onboardButton, findsOneWidget);
    //   await tester.tap(onboardButton);

    //   await tester.pumpAndSettle();
    //   final Finder emailField = find.byKey(const Key("email_field"));
    //   expect(emailField, findsOneWidget);
    //   await tester.enterText(emailField, "fahmi.ali1945@gmail.com");
    //   await tester.pumpAndSettle();
    //   final Finder passwordField = find.byKey(const Key("password_field"));
    //   expect(passwordField, findsOneWidget);
    //   await tester.enterText(passwordField, "123456");
    //   await tester.pumpAndSettle();

    //   final Finder loginButton = find.byKey(const Key("login_button"));
    //   expect(loginButton, findsOneWidget);
    //   await tester.pumpAndSettle();
    //   await tester.tap(loginButton);
    //   await tester.pumpAndSettle();
    // });
  });
}
