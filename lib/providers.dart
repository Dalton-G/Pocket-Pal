import 'package:pocket_pal/src/providers/auth_provider.dart';
import 'package:pocket_pal/src/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:pocket_pal/src/providers/onboarding_page_provider.dart';
import 'package:pocket_pal/src/providers/member_navbar_selection_provider.dart';

class Providers {
  Providers._();
  static final providers = [
    ChangeNotifierProvider<MemberNavBarSelectionProvider>(
      create: (_) => MemberNavBarSelectionProvider(),
    ),
    ChangeNotifierProvider<OnboardingPageProvider>(
      create: (_) => OnboardingPageProvider(),
    ),
    ChangeNotifierProvider<UserProvider>(
      create: (_) => UserProvider(),
    ),
    ChangeNotifierProvider<AuthPageProvider>(
      create: (_) => AuthPageProvider(),
    ),
  ].toList();
}
