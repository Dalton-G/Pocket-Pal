import 'package:flutter/material.dart';
import 'package:pocket_pal/theme/app_theme.dart';

class AuthButtonOutline extends StatelessWidget {
  // Attributes
  final Function()? onTap;
  final String buttonText;

  // Constructors
  const AuthButtonOutline({
    Key? key,
    this.onTap,
    required this.buttonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
          decoration: AppTheme.onboardingButtonOutline,
          child: Center(
            child: Text(buttonText, style: AppTheme.normalTextGrey),
          ),
        ),
      ),
    );
  }
}
