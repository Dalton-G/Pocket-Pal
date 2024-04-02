import 'package:flutter/material.dart';
import 'package:pocket_pal/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:pocket_pal/routes.dart';
import 'package:pocket_pal/src/screens/universal/onboarding/onboarding.dart';
import './providers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: Providers.providers,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pocket Pal',
        theme: AppTheme.lightTheme,
        home: const OnboardingPage(),
        routes: Routes.routes,
      ),
    );
  }
}
