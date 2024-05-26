import 'package:flutter/material.dart';
import 'package:pocket_pal/theme/app_theme.dart';

class IntroPage1 extends StatelessWidget {
  const IntroPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 100),
              Container(
                width: double.infinity,
                child: Image.asset('lib/src/assets/images/onboardingpage1.png'),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Wellness is just ",
                    style: AppTheme.onboardingTextH1,
                  ),
                  Text(
                    "one",
                    style: AppTheme.onboardingTextS1,
                  ),
                  Text(
                    " step away",
                    style: AppTheme.onboardingTextH1,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: Text(
                  "Don't let anything stop you from achieving your inner peace.",
                  style: AppTheme.onboardingTextB1,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
