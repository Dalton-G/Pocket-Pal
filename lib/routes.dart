import 'package:flutter/material.dart';
import 'package:pocket_pal/src/auth/auth_page.dart';
import 'package:pocket_pal/src/auth/forgot_password.dart';
import 'package:pocket_pal/src/screens/admin/pages/admin_home_page.dart';
import 'package:pocket_pal/src/screens/patient/member_navigator.dart';
import 'package:pocket_pal/src/screens/patient/pages/member_chat_page.dart';
import 'package:pocket_pal/src/screens/patient/pages/member_forum_page.dart';
import 'package:pocket_pal/src/screens/therapist/pages/therapist_home_page.dart';
import 'package:pocket_pal/src/screens/therapist/pages/therapist_schedule_page.dart';
import 'package:pocket_pal/src/screens/therapist/therapist_navigator.dart';
import 'src/screens/patient/pages/member_home_page.dart';
import 'package:pocket_pal/src/screens/universal/onboarding/onboarding.dart';
import 'package:pocket_pal/src/screens/patient/pages/member_schedule_page.dart';

class Routes {
  Routes._();
  // static variables
  static const String onboarding = '/onboarding';
  static const String authPage = '/auth-page';
  static const String forgotPW = '/forgot-pw';
  static const String mainPage = '/main-page';

  static const String memberHome = '/member-home-page';
  static const String memberSchedule = '/member-schedule-page';
  static const String memberChat = '/member-chat-page';
  static const String memberForum = '/member-forum-page';
  static const String memberNavigator = '/member-navigator';

  static const String adminHome = '/admin-home-page';

  // Therapist routes
  static const String therapistHome = '/therapist-home-page';
  static const String therapistSchedule = '/therapist-schedule-page';
  static const String therapistNavigator = '/therapist-navigator';

  // routes
  static final dynamic routes = <String, WidgetBuilder>{
    onboarding: (BuildContext context) => const OnboardingPage(),
    authPage: (BuildContext context) => const AuthPage(),
    forgotPW: (BuildContext context) => const ForgotPasswordPage(),
    memberHome: (BuildContext context) => const MemberHomePage(),
    memberSchedule: (BuildContext context) => const MemberSchedulePage(),
    memberChat: (BuildContext context) => const MemberChatPage(),
    memberForum: (BuildContext context) => const MemberForumPage(),
    memberNavigator: (BuildContext context) => const MemberNavigator(),
    adminHome: (BuildContext context) => const AdminHomePage(),
    therapistHome: (BuildContext context) => const TherapistHomePage(),
    therapistSchedule: (BuildContext context) => const TherapistSchedulePage(),
    therapistNavigator: (BuildContext context) => const TherapistNavigator(),
  };
}
