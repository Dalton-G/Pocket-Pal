import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:pocket_pal/src/providers/member_navbar_selection_provider.dart';
import 'package:pocket_pal/src/providers/user_provider.dart';
import 'package:pocket_pal/src/screens/admin/pages/admin_home_page.dart';
import 'package:pocket_pal/src/widgets/navbar/g_navbar_enhanced.dart';
import 'package:provider/provider.dart';

class AdminNavigator extends StatelessWidget {
  const AdminNavigator({super.key});

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
            children: const [
              AdminHomePage(),
            ],
          ),

          // Bottom Nav Bar (for dev's reference)
          // Not using 'bottomNavigationBar' property of Scaffold
          // because it does not allow styling the bottom nav bar
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: GNavBarEnhanced(
              tabs: [
                GButton(
                  icon: provider.selectedIndex == 0
                      ? Icons.dashboard
                      : Icons.dashboard_outlined,
                  text: 'Dashboard',
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
                      ? Icons.calendar_month
                      : Icons.calendar_month_outlined,
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
                      ? Icons.forum
                      : Icons.forum_outlined,
                  text: 'Chat',
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
                      ? Icons.group
                      : Icons.group_outlined,
                  text: 'Forum',
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
              ],
              selectedIndex: provider.selectedIndex,
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 80.0),
        child: FloatingActionButton(
          onPressed: () => context.read<UserProvider>().logout(),
          backgroundColor: Theme.of(context).primaryColor,
          child: const Icon(Icons.logout),
        ),
      ),
    );
  }
}
