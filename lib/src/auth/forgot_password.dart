// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:pocket_pal/src/providers/user_provider.dart';
import 'package:pocket_pal/src/utils/confetti.dart';
import 'package:pocket_pal/src/widgets/auth/alertDialog.dart';
import 'package:pocket_pal/src/widgets/auth/authButton.dart';
import 'package:pocket_pal/src/widgets/auth/authTextFields.dart';
import 'package:provider/provider.dart';
import 'package:pocket_pal/theme/app_theme.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage>
    with SingleTickerProviderStateMixin {
  final _emailController = TextEditingController();
  late AnimationController _confettiController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _confettiController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  void _validateAndReset(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      await context.read<UserProvider>().resetPassword(
            _emailController.text.trim(),
          );
      var ticker = _confettiController.forward();
      ticker.whenComplete(() {
        _confettiController.reset();
      });
      showAuthDialog(
        context,
        'Reset Password Email Sent',
        'Please check your email for more information',
      );
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
          ConfettiAnimation(controller: _confettiController),
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
                  Text("Reset", style: AppTheme.largeTextGreen),
                  Text("Password", style: AppTheme.largeTextGrey),
                  SizedBox(height: screenHeight * 0.08),
                  Row(
                    children: [
                      Text(
                        "Please enter your ",
                        style: AppTheme.normalTextGrey,
                      ),
                      Text(
                        "email address",
                        style: AppTheme.onboardingTextS1,
                      ),
                    ],
                  ),
                  Text(
                    " to request a password reset.",
                    style: AppTheme.normalTextGrey,
                  ),
                  SizedBox(height: 60),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Your Email:", style: AppTheme.normalTextGrey),
                        const SizedBox(height: 10),
                        AuthTextField(
                          hintText: "Enter your email",
                          controller: _emailController,
                          obscureText: false,
                          mainColor: AppTheme.secondaryGreen,
                          width: screenWidth * 0.8,
                        ),
                        const SizedBox(height: 45),
                        AuthButton(
                          buttonText: "Send Password Reset Email",
                          onTap: () => _validateAndReset(context),
                        ),
                      ],
                    ),
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
