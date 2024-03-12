import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:pocket_pal/src/widgets/navbar/g_navbar_enhanced.dart';
import 'package:pocket_pal/theme/colors/colors.dart';

class PatientHomePage extends StatelessWidget {
  const PatientHomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],

      // APP BAR
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text(
          'Home Page',
          style: TextStyle(
            fontFamily: 'Overpass',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: primaryGreen,
      ),

      // BODY

      // BOTTOM NAVIGATION BAR
      bottomNavigationBar: GNavBarEnhanced(
        tabs: const [
          GButton(
            icon: Icons.home,
            text: 'Home',
            textStyle: TextStyle(
              color: Colors.white,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.bold,
            ),
          ),
          GButton(
            icon: Icons.calendar_month,
            text: 'Schedule',
            textStyle: TextStyle(
              color: Colors.white,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.bold,
            ),
          ),
          GButton(
            icon: Icons.forum,
            text: 'Chat',
            textStyle: TextStyle(
              color: Colors.white,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.bold,
            ),
          ),
          GButton(
            icon: Icons.post_add,
            text: 'Confess',
            textStyle: TextStyle(
              color: Colors.white,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
