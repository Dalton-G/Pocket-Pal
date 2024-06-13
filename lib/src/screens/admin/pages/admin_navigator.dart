import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:pocket_pal/src/providers/admin/nav/admin_navbar_provider.dart';
import 'package:pocket_pal/src/screens/admin/dashboard/admin_home_page.dart';
import 'package:pocket_pal/src/screens/admin/manage_application/admin_manage_application_page.dart';
import 'package:pocket_pal/src/screens/admin/manage_forum/admin_manage_forum_page.dart';
import 'package:pocket_pal/src/screens/admin/manage_user/admin_manage_user_page.dart';
import 'package:pocket_pal/src/widgets/navbar/g_navbar_enhanced.dart';
import 'package:pocket_pal/theme/app_theme.dart';
import 'package:provider/provider.dart';

class AdminNavigator extends StatelessWidget {
  const AdminNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AdminNavbarProvider>(context);

    final PageController pageController =
        PageController(initialPage: provider.selectedIndex);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppTheme.backgroundWhite,
      body: Stack(
        children: [
          PageView(
            controller: pageController,
            onPageChanged: (index) {
              provider.setSelectedIndex(index);
            },
            children: const [
              AdminHomePage(),
              AdminManageApplicationPage(),
              AdminManageUserPage(),
              AdminManageForumPage(),
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
                      ? Icons.verified_user
                      : Icons.verified_user_outlined,
                  text: 'Manage Application',
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
                      ? Icons.group
                      : Icons.group_outlined,
                  text: 'Manage User',
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
                  text: 'Manage Forum',
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
    );
  }
}
