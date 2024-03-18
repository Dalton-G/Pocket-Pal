import 'package:flutter/material.dart';
import 'package:pocket_pal/theme/colors/colors.dart';

class MemberForumPage extends StatelessWidget {
  const MemberForumPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],

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
