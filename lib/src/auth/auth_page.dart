import 'package:flutter/material.dart';
import 'package:pocket_pal/src/auth/login_page.dart';
import 'package:pocket_pal/src/auth/register_page.dart';
import 'package:pocket_pal/src/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthPageProvider>(
      builder: (context, authProvider, child) {
        if (authProvider.showLoginPage) {
          return LoginPage(showRegisterPage: authProvider.toggleScreen);
        } else {
          return RegisterPage(showLoginPage: authProvider.toggleScreen);
        }
      },
    );
  }
}
