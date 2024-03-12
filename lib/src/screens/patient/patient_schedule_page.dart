import 'package:flutter/material.dart';
import 'package:pocket_pal/src/widgets/navbar/patient_navbar.dart';
import 'package:pocket_pal/theme/colors/colors.dart';

class PatientSchedulePage extends StatelessWidget {
  const PatientSchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],

      // APP BAR
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text(
          'Schedule',
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
      bottomNavigationBar: const PatientNavBar(),
    );
  }
}
