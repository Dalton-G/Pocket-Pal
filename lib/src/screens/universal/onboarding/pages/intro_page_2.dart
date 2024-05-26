import 'package:flutter/material.dart';
import 'package:pocket_pal/theme/app_theme.dart';

class IntroPage2 extends StatelessWidget {
  const IntroPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundWhite,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 100),
            Container(
              width: double.infinity,
              child: Image.asset('lib/src/assets/images/onboardingpage2.png'),
            ),
            const SizedBox(height: 20),
            Text(
              "Unlock a whole",
              style: AppTheme.onboardingTextH1,
              textAlign: TextAlign.center,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "new world of ",
                  style: AppTheme.onboardingTextH1,
                ),
                Text(
                  "therapy",
                  style: AppTheme.onboardingTextS1,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: Text(
                "Expanasion doesn't have to be expensive - join us, and help our community flourish.",
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
