import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:pocket_pal/src/screens/therapist/pages/therapist_home_page.dart';
import 'package:pocket_pal/src/screens/therapist/pages/therapist_schedule_page.dart';
import 'package:pocket_pal/src/providers/therapist/navbar_selection_provider.dart';
import 'package:pocket_pal/src/screens/therapist/pages/therapist_session_page.dart';
import 'package:pocket_pal/src/widgets/navbar/g_navbar_enhanced.dart';
import 'package:provider/provider.dart';

class TherapistNavigator extends StatelessWidget {
  const TherapistNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NavbarSelectionProvider>(context);

    final PageController pageController =
    PageController(initialPage: provider.selectedIndex);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView(
            controller: pageController,
            onPageChanged: (index) {
              provider.setSelectedIndex(index);
            },
            children: const [
              TherapistHomePage(),
              TherapistSchedulePage(),
              TherapistSessionPage(),
            ],
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: GNavBarEnhanced(
              tabs: [
                GButton(
                  icon: provider.selectedIndex == 0
                      ? Icons.home
                      : Icons.home_outlined,
                  text: 'Home',
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.bold,
                  ),
                  onPressed: () {
                    provider.setSelectedIndex(0);
                    pageController.jumpToPage(0);
                  },
                ),
                GButton(
                  icon: provider.selectedIndex == 1
                      ? Icons.schedule
                      : Icons.schedule_outlined,
                  text: 'Schedule',
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.bold,
                  ),
                  onPressed: () {
                    provider.setSelectedIndex(1);
                    pageController.jumpToPage(1);
                  },
                ),
                GButton(
                  icon: provider.selectedIndex == 2
                      ? Icons.calendar_month
                      : Icons.calendar_month_outlined,
                  text: 'Session',
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.bold,
                  ),
                  onPressed: () {
                    provider.setSelectedIndex(2);
                    pageController.jumpToPage(2);
                  },
                ),
                GButton(
                  icon: provider.selectedIndex == 3
                      ? Icons.forum
                      : Icons.forum_outlined,
                  text: 'Chat',
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.bold,
                  ),
                  onPressed: () {
                    provider.setSelectedIndex(3);
                    pageController.jumpToPage(3);
                  },
                ),
                GButton(
                  icon: provider.selectedIndex == 4
                      ? Icons.group
                      : Icons.group_outlined,
                  text: 'Forum',
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.bold,
                  ),
                  onPressed: () {
                    provider.setSelectedIndex(4);
                    pageController.jumpToPage(4);
                  },
                ),
              ],
              selectedIndex: provider.selectedIndex,
            ),
          ),
        ],
      ),
    );
  }
}