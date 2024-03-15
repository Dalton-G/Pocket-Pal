import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pocket_pal/src/screens/universal/onboarding/pages/intro_page_1.dart';
import 'package:pocket_pal/src/screens/universal/onboarding/pages/intro_page_2.dart';
import 'package:pocket_pal/src/screens/universal/onboarding/pages/intro_page_3.dart';
import 'package:pocket_pal/src/providers/onboarding_page_provider.dart';
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
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView(
            controller: pageController, // Pass the PageController to PageView
            onPageChanged: (index) {
              provider.setCurrentPageIndex(index);
            },
            children: [
              IntroPage1(),
              IntroPage2(),
              IntroPage3(),
            ],
          ),
          Container(
            alignment: const Alignment(0, 0.85),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    provider.setCurrentPageIndex(2);
                  },
                  child: const Text(
                    'Skip',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SmoothPageIndicator(
                  controller:
                      pageController, // Pass the PageController to SmoothPageIndicator
                  count: 3,
                  effect: const ExpandingDotsEffect(
                    activeDotColor: Colors.blue,
                    dotColor: Colors.grey,
                    dotHeight: 10,
                    dotWidth: 10,
                    spacing: 10,
                    expansionFactor: 3,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (provider.currentPageIndex == 2) {
                      Navigator.pushNamed(context, '/patient-home-page');
                    } else {
                      provider
                          .setCurrentPageIndex(provider.currentPageIndex + 1);
                      pageController.animateToPage(
                        provider.currentPageIndex,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: Text(
                    provider.currentPageIndex == 2 ? 'Done' : 'Next',
                    style: const TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
