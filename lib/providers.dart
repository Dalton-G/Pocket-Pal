import 'package:pocket_pal/src/providers/admin/nav/admin_navbar_provider.dart';
import 'package:pocket_pal/src/providers/auth/auth_provider.dart';
import 'package:pocket_pal/src/providers/auth/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:pocket_pal/src/providers/onboarding/onboarding_page_provider.dart';
import 'package:pocket_pal/src/providers/member/member_navbar_selection_provider.dart';

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
    ChangeNotifierProvider<AdminNavbarProvider>(
        create: (_) => AdminNavbarProvider())
  ].toList();
}
