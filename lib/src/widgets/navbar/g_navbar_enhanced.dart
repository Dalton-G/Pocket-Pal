import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:pocket_pal/theme/colors/colors.dart';

class GNavBarEnhanced extends StatelessWidget {
  final List<GButton> tabs;
  final Function(int)? onTabChange;
  final int? selectedIndex;

  const GNavBarEnhanced({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    this.onTabChange,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(35),
                topRight: Radius.circular(35),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: const Offset(0, -1),
                ),
              ],
            ),
          ),
        ),
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(35),
            topRight: Radius.circular(35),
          ),
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: GNav(
                selectedIndex: selectedIndex!,
                color: Colors.grey,
                activeColor: Colors.white,
                backgroundColor: Colors.white,
                tabBackgroundColor: primaryGreen,
                padding: const EdgeInsets.all(8),
                curve: Curves.easeInOutExpo,
                duration: const Duration(milliseconds: 500),
                gap: 6,
                onTabChange: onTabChange,
                tabs: tabs,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
