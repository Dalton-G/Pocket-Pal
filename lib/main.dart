import 'package:flutter/material.dart';
import 'package:pocket_pal/routes.dart';
import 'package:pocket_pal/src/screens/universal/onboarding/onboarding.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pocket Pal',
      home: const OnboardingPage(),
      routes: Routes.routes,
    );
  }
}
