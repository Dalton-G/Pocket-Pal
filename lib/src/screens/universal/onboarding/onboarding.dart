import 'package:flutter/material.dart';
import 'package:pocket_pal/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:pocket_pal/src/screens/universal/onboarding/pages/intro_page_1.dart';
import 'package:pocket_pal/src/screens/universal/onboarding/pages/intro_page_2.dart';
import 'package:pocket_pal/src/screens/universal/onboarding/pages/intro_page_3.dart';
import 'package:pocket_pal/src/providers/onboarding/onboarding_page_provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<OnboardingPageProvider>(context);

    // Create a PageController instance
    final PageController pageController =
        PageController(initialPage: provider.currentPageIndex);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: double.infinity,
                  child:
                      Image.asset('lib/src/assets/images/abstractcontour2.png'),
                ),
              ],
            ),
          ),
          Container(
            child: Column(children: [
              Container(
                width: double.infinity,
                child: Image.asset('lib/src/assets/images/abstractcontour.png'),
              ),
            ]),
          ),
          Container(
            alignment: const Alignment(0, 0.9),
            child: Column(
              children: [
                const SizedBox(height: 50),
                Container(
                  height: 35,
                  child: Image.asset(
                      'lib/src/assets/images/pocketpallogowithword.png'),
                ),
              ],
            ),
          ),
          PageView(
            controller: pageController, // Pass the PageController to PageView
            onPageChanged: (index) {
              provider.setCurrentPageIndex(index);
            },
            children: const [
              IntroPage1(),
              IntroPage2(),
              IntroPage3(),
            ],
          ),
          Container(
            alignment: const Alignment(0, 0.75),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SmoothPageIndicator(
                  controller:
                      pageController, // Pass the PageController to SmoothPageIndicator
                  count: 3,
                  effect: const ExpandingDotsEffect(
                    activeDotColor: AppTheme.primaryGreen,
                    dotColor: AppTheme.primaryOrange,
                    dotHeight: 8,
                    dotWidth: 8,
                    spacing: 8,
                    expansionFactor: 3,
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  key: Key('start'),
                  onTap: () {
                    Navigator.pushNamed(context, '/main-page');
                  },
                  child: Container(
                    width: 180,
                    height: 50,
                    alignment: Alignment.center,
                    decoration: AppTheme.onboardingButton,
                    child: const Text(
                      "Get Started",
                      style: AppTheme.onboardingButtonText,
                    ),
                  ),
                ),
                const SizedBox(height: 80),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
