import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:pocket_pal/src/auth/auth_page.dart';
import 'package:pocket_pal/src/providers/auth/auth_provider.dart';
import 'package:pocket_pal/src/providers/auth/user_provider.dart';

void main() {
  testWidgets('Switches to registration page when "Register now." is clicked',
      (WidgetTester tester) async {
    // Build the app and trigger a frame
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthPageProvider()),
          ChangeNotifierProvider(create: (_) => UserProvider()),
        ],
        child: MaterialApp(
          home: AuthPage(),
        ),
      ),
    );

    // Verify that LoginPage is displayed initially
    expect(find.text('Login'), findsOneWidget);
    expect(find.text('Account'), findsOneWidget);
    expect(find.text("Don't have an account?"), findsOneWidget);
    expect(find.text(" Register now."), findsOneWidget);

    // Tap on the "Register now." text
    await tester.tap(find.text(" Register now."));
    await tester.pumpAndSettle();

    // Verify that RegisterPage is displayed after tapping "Register now."
    expect(find.text('Register '), findsOneWidget);
    expect(find.text('Account'), findsOneWidget);
    expect(find.text("Already have an account?"), findsOneWidget);
    expect(find.text(" Login now."), findsOneWidget);
  });
}
