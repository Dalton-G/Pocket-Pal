import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pocket_pal/src/screens/universal/onboarding/onboarding.dart';
import 'package:pocket_pal/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:pocket_pal/routes.dart';
import './providers.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: Providers.providers,
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Pocket Pal',
        theme: AppTheme.lightTheme,
        home: const OnboardingPage(),
        routes: Routes.routes,
      ),
    );
  }
}
