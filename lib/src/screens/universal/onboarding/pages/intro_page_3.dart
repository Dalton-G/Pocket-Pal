import 'package:flutter/material.dart';
import 'package:pocket_pal/theme/app_theme.dart';

class IntroPage3 extends StatelessWidget {
  const IntroPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 100),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                width: double.infinity,
                child: Image.asset('lib/src/assets/images/onboardingpage3.png'),
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Managing",
                  style: AppTheme.onboardingTextS1,
                ),
                Text(
                  " a platform",
                  style: AppTheme.onboardingTextH1,
                ),
              ],
            ),
            Text(
              "has never been easier",
              style: AppTheme.onboardingTextH1,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: Text(
                "Sign up and gain access to a whole suite of tools that make your daily tasks so much quicker to complete.",
                style: AppTheme.onboardingTextB1,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
