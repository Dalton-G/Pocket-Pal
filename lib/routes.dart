import 'package:flutter/material.dart';
import './src/screens/patient/patient_home_page.dart';
import 'package:pocket_pal/src/screens/universal/onboarding/onboarding.dart';
import 'package:pocket_pal/src/screens/patient/patient_schedule_page.dart';

class Routes {
  Routes._();
  // static variables
  static const String onboarding = '/onboarding';

  static const String patientHome = '/patient-home-page';
  static const String patientSchedule = '/patient-schedule-page';

  // routes
  static final dynamic routes = <String, WidgetBuilder>{
    patientHome: (BuildContext context) => const PatientHomePage(),
    patientSchedule: (BuildContext context) => const PatientSchedulePage(),
    onboarding: (BuildContext context) => const OnboardingPage(),
  };
}
