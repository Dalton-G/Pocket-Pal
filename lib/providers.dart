import 'package:pocket_pal/src/providers/auth_provider.dart';
import 'package:pocket_pal/src/providers/role_provider.dart';
import 'package:pocket_pal/src/providers/therapist/application_provider.dart';
import 'package:pocket_pal/src/providers/therapist/navbar_selection_provider.dart';
import 'package:pocket_pal/src/providers/therapist/booking_provider.dart';
import 'package:pocket_pal/src/providers/therapist/availability_provider.dart';
import 'package:pocket_pal/src/providers/therapist/session_note_provider.dart';
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
    ChangeNotifierProvider<RoleProvider>(
      create: (_) => RoleProvider(),
    ),
    ChangeNotifierProvider<BookingProvider>(
      create: (_) => BookingProvider(),
    ),
    ChangeNotifierProvider<NavbarSelectionProvider>(
      create: (_) => NavbarSelectionProvider(),
    ),
    ChangeNotifierProvider<ApplicationProvider>(
      create: (_) => ApplicationProvider(),
    ),
    ChangeNotifierProvider<AvailabilityProvider>(
      create: (_) => AvailabilityProvider(),
    ),
    ChangeNotifierProvider<SessionNoteProvider>(
      create: (_) => SessionNoteProvider(),
    ),
  ].toList();
}
