import 'package:flutter/material.dart';
import 'package:pocket_pal/theme/colors/colors.dart';

class MemberSchedulePage extends StatelessWidget {
  const MemberSchedulePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // APP BAR
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text(
          'Schedule Page',
          style: TextStyle(
            fontFamily: 'Overpass',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: primaryGreen,
      ),

      // BODY
    );
  }
}
