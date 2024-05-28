// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:pocket_pal/src/providers/user_provider.dart';
import 'package:pocket_pal/src/widgets/auth/alertDialog.dart';
import 'package:pocket_pal/src/widgets/auth/authButton.dart';
import 'package:pocket_pal/src/widgets/auth/emailTextFields.dart';
import 'package:pocket_pal/src/widgets/auth/pwTextFields.dart';
import 'package:pocket_pal/theme/app_theme.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const LoginPage({super.key, required this.showRegisterPage});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _validateAndLogin(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      bool loginSuccessful = await context.read<UserProvider>().login(
            _emailController.text,
            _passwordController.text,
          );
      if (!loginSuccessful) {
        showAuthDialog(
          context,
          'Login Failed',
          'Incorrect credentails, please try again',
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;

    return Scaffold(
      backgroundColor: AppTheme.backgroundWhite,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('lib/src/assets/images/dottedlinebg.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),
                  InkWell(
                    onTap: () async {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: AppTheme.authBackButton,
                      child: const Icon(
                        Icons.arrow_back,
                        color: AppTheme.primaryGreen,
                        size: 24,
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  Text("Login", style: AppTheme.largeTextGreen),
                  Text("Account", style: AppTheme.largeTextGrey),
                  SizedBox(height: screenHeight * 0.08),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Your Email:", style: AppTheme.normalTextGrey),
                        const SizedBox(height: 10),
                        EmailTextField(
                          controller: _emailController,
                          width: screenWidth,
                        ),
                        const SizedBox(height: 10),
                        Text("Your Password:", style: AppTheme.normalTextGrey),
                        const SizedBox(height: 10),
                        PasswordTextField(
                          controller: _passwordController,
                          width: screenWidth,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(context, "/forgot-pw"),
                        child: Text(
                          "Forgot password?",
                          style: AppTheme.smallTextGreen,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 45),
                  AuthButton(
                    buttonText: "Sign In",
                    onTap: () => _validateAndLogin(context),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: AppTheme.smallTextGrey,
                      ),
                      GestureDetector(
                        onTap: widget.showRegisterPage,
                        child: Text(
                          " Register now.",
                          style: AppTheme.smallTextGreen,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
