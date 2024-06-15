import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pocket_pal/routes.dart';
import 'package:pocket_pal/src/providers/auth/auth_provider.dart';
import 'package:pocket_pal/src/providers/auth/user_provider.dart';
import 'package:pocket_pal/src/providers/onboarding/onboarding_page_provider.dart';
import 'package:pocket_pal/src/screens/universal/onboarding/onboarding.dart';
import 'package:provider/provider.dart';

void main() async {
  testWidgets('Login and Register Flow Integration Test',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthPageProvider()),
          ChangeNotifierProvider(create: (_) => UserProvider()),
          ChangeNotifierProvider(create: (_) => OnboardingPageProvider()),
        ],
        child: MaterialApp(
          home: OnboardingPage(),
          routes: Routes.routes,
        ),
      ),
    );

    // Verify that the onboarding page is displayed initially
    expect(find.text('Get Started'), findsOneWidget);

    // Tap on "Get Started" to navigate to the login page
    await tester.tap(find.text("Get Started"));
    await tester.pumpAndSettle();

    // Verify that the login page is displayed
    expect(find.text('Login'), findsOneWidget);
    expect(find.text('Account'), findsOneWidget);
    expect(find.text("Don't have an account?"), findsOneWidget);
    expect(find.text(" Register now."), findsOneWidget);

    // Tap on "Register now." to navigate to the register page
    await tester.tap(find.text(" Register now."));
    await tester.pumpAndSettle();

    // Verify that the register page is displayed
    expect(find.text('Register '), findsOneWidget);
    expect(find.text('Account'), findsOneWidget);
    expect(find.text("Already have an account?"), findsOneWidget);
    expect(find.text(" Login now."), findsOneWidget);

    // Tap on "Login now." to navigate back to the login page
    await tester.tap(find.text(" Login now."));
    await tester.pumpAndSettle();

    // Fill out login form
    await tester.enterText(
        find.byKey(Key('emailTF')), 'study.daltongan@gmail.com');
    await tester.enterText(find.byKey(Key('passwordTF')), 'onewbaby02');

    // Tap on "Sign In" button
    await tester.tap(find.text("Sign In"));
    await tester.pumpAndSettle();

    // Verify successful navigation or registration completion
    expect(find.text('Welcome back, '), findsOneWidget);
    expect(find.text('Dalton Gan'), findsOneWidget);
  });
}
