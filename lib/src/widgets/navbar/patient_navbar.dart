import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:pocket_pal/theme/colors/colors.dart';

class PatientNavBar extends StatelessWidget {
  const PatientNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(25),
        topRight: Radius.circular(25),
      ),
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: GNav(
            color: Colors.grey,
            activeColor: Colors.white,
            backgroundColor: Colors.white,
            tabBackgroundColor: primaryGreen,
            padding: const EdgeInsets.all(8),
            curve: Curves.easeInOutExpo,
            duration: const Duration(milliseconds: 600),
            gap: 6,
            onTabChange: (index) {
              if (index == 0) {
                print('Home');
              } else if (index == 1) {
                print('Schedule');
              } else if (index == 2) {
                print('Chat');
              } else if (index == 3) {
                print('Forum');
              }
            },
            tabs: const [
              GButton(
                icon: Icons.home,
                text: 'Home',
                textStyle: TextStyle(
                  fontFamily: 'Nunito',
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GButton(
                icon: Icons.calendar_month,
                text: 'Schedule',
                textStyle: TextStyle(
                  fontFamily: 'Nunito',
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GButton(
                icon: Icons.forum,
                text: 'Chat',
                textStyle: TextStyle(
                  fontFamily: 'Nunito',
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GButton(
                icon: Icons.post_add,
                text: 'Forum',
                textStyle: TextStyle(
                  fontFamily: 'Nunito',
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
