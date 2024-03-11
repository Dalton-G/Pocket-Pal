import 'package:flutter/material.dart';
import 'package:pocket_pal/intro_screens/intro_page_1.dart';
import 'package:pocket_pal/intro_screens/intro_page_2.dart';
import 'package:pocket_pal/intro_screens/intro_page_3.dart';
import 'package:pocket_pal/view/home_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:pocket_pal/utils/colors.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  // CONTROLLER
  PageController _controller = PageController();

  // ON LAST PAGE
  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // PAGE VIEW
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == 2);
              });
            },
            children: [
              IntroPage1(),
              IntroPage2(),
              IntroPage3(),
            ],
          ),

          // SMOOTH PAGE INDICATOR
          Container(
            alignment: Alignment(0, 0.75),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // SKIP BUTTON
                GestureDetector(
                  onTap: () {
                    _controller.jumpToPage(2);
                  },
                  child: Text('Skip'),
                ),

                // DOT INDICATOR
                SmoothPageIndicator(controller: _controller, count: 3),

                // NEXT OR DONE
                onLastPage
                    ? GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return HomePage();
                              },
                            ),
                          );
                        },
                        child: Text('Done'),
                      )
                    : GestureDetector(
                        onTap: () {
                          _controller.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeIn,
                          );
                        },
                        child: Text('Next'),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
