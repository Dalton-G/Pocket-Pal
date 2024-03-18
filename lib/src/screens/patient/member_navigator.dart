import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:pocket_pal/src/providers/member_navbar_selection_provider.dart';
import 'package:pocket_pal/src/screens/patient/pages/member_chat_page.dart';
import 'package:pocket_pal/src/screens/patient/pages/member_forum_page.dart';
import 'package:pocket_pal/src/screens/patient/pages/member_home_page.dart';
import 'package:pocket_pal/src/screens/patient/pages/member_schedule_page.dart';
import 'package:pocket_pal/src/widgets/navbar/g_navbar_enhanced.dart';
import 'package:provider/provider.dart';

class MemberNavigator extends StatelessWidget {
  const MemberNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MemberNavBarSelectionProvider>(context);

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
            children: [
              MemberHomePage(),
              MemberSchedulePage(),
              MemberChatPage(),
              MemberForumPage(),
            ],
          ),
        ],
      ),
      bottomNavigationBar: GNavBarEnhanced(
        tabs: [
          GButton(
            icon: Icons.home,
            text: 'Home',
            textStyle: TextStyle(
              color: Colors.white,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.bold,
            ),
            onPressed: () {
              provider.setSelectedIndex(0);
              pageController.animateToPage(
                0,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            },
          ),
          GButton(
            icon: Icons.calendar_month,
            text: 'Schedule',
            textStyle: TextStyle(
              color: Colors.white,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.bold,
            ),
            onPressed: () {
              provider.setSelectedIndex(1);
              pageController.animateToPage(
                1,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            },
          ),
          GButton(
            icon: Icons.forum,
            text: 'Chat',
            textStyle: TextStyle(
              color: Colors.white,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.bold,
            ),
            onPressed: () {
              provider.setSelectedIndex(2);
              pageController.animateToPage(
                2,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            },
          ),
          GButton(
            icon: Icons.post_add,
            text: 'Forum',
            textStyle: TextStyle(
              color: Colors.white,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.bold,
            ),
            onPressed: () {
              provider.setSelectedIndex(3);
              pageController.animateToPage(
                3,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            },
          ),
        ],
        selectedIndex: provider.selectedIndex,
      ),
    );
  }
}
