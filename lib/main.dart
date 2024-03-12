import 'package:flutter/material.dart';
import 'package:pocket_pal/src/screens/universal/onboarding_pages/onboarding.dart';
import 'package:pocket_pal/src/screens/patient/patient_home_page.dart';
import 'package:pocket_pal/src/screens/patient/patient_schedule_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnboardingPage(),
      routes: {
        '/patient-homepage': (context) => PatientHomePage(),
        '/patient-schedule': (context) => PatientSchedulePage(),
      },
    );
  }
}
