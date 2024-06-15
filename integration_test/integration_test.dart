import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:pocket_pal/main.dart' as app;
import 'package:pocket_pal/src/screens/admin/navigation/admin_navigator.dart';
import 'package:pocket_pal/src/widgets/auth/emailTextFields.dart';
import 'package:pocket_pal/src/widgets/auth/pwTextFields.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

  group(
    'Authentication end-to-end testing',
    () {
      testWidgets(
        'login with incorrect username and password',
        (WidgetTester tester) async {
          await app.main();
          await tester.pumpAndSettle();

          print('App started');

          // Ensure the initial screen is displayed
          expect(find.text('Get Started'), findsOneWidget);

          // Tap 'Get Started'
          await tester.tap(find.text('Get Started'));
          await tester.pumpAndSettle();

          // Enter email
          Future.delayed(const Duration(seconds: 2));
          await tester.enterText(
              find.byType(EmailTextField), 'rudory@gmail.com');
          Future.delayed(const Duration(seconds: 2));
          await tester.pumpAndSettle();
          print('Entered incorrect email');

          // Enter password
          Future.delayed(const Duration(seconds: 2));
          await tester.enterText(find.byType(PasswordTextField), '12345678');
          Future.delayed(const Duration(seconds: 2));
          await tester.pumpAndSettle();
          print('Entered incorrect password');

          // Tap 'Sign In'
          Future.delayed(const Duration(seconds: 2));
          await tester.tap(find.text('Sign In'));
          await tester.pumpAndSettle();
          print('Tapped Sign In');

          // Wait for navigation to MemberHomePage
          await Future.delayed(const Duration(seconds: 2));
          await tester.pumpAndSettle();

          // Verify that MemberHomePage is shown
          expect(find.text('Login Failed'), findsOneWidget);
          print('Login failed, Alert Dialog Shown');
          await tester.tap(find.text('OK'));
          print('^ Test Passed: Auth rejects incorrect admin credentials');
        },
      );
      testWidgets(
        'login with correct username and password',
        (WidgetTester tester) async {
          await app.main();
          await tester.pumpAndSettle();

          print('App started');

          // Ensure the initial screen is displayed
          expect(find.text('Get Started'), findsOneWidget);

          // Tap 'Get Started'
          await tester.tap(find.text('Get Started'));
          await tester.pumpAndSettle();
          print('Tapped Get Started');

          // Enter email
          Future.delayed(const Duration(seconds: 2));
          await tester.enterText(
              find.byType(EmailTextField), 'study.daltongan@gmail.com');
          Future.delayed(const Duration(seconds: 2));
          await tester.pumpAndSettle();
          print('Entered correct email');

          // Enter password
          Future.delayed(const Duration(seconds: 2));
          await tester.enterText(find.byType(PasswordTextField), 'onewbaby02');
          Future.delayed(const Duration(seconds: 2));
          await tester.pumpAndSettle();
          print('Entered correct password');

          // Tap 'Sign In'
          Future.delayed(const Duration(seconds: 2));
          await tester.tap(find.text('Sign In'));
          await tester.pumpAndSettle();
          print('Tapped Sign In');

          // Wait for navigation to MemberHomePage
          await Future.delayed(const Duration(seconds: 2));
          await tester.pumpAndSettle();

          // Verify that MemberHomePage is shown
          expect(find.byType(AdminNavigator), findsOneWidget);
          print('Login successful, Admin Home Page found');
          print('^ Test Passed: Auth accepts correct admin credentials');
        },
      );
    },
  );
}
