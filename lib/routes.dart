import 'package:flutter/material.dart';
import 'package:pocket_pal/src/auth/auth_page.dart';
import 'package:pocket_pal/src/auth/banned_page.dart';
import 'package:pocket_pal/src/auth/forgot_password.dart';
import 'package:pocket_pal/src/auth/main_page.dart';
import 'package:pocket_pal/src/screens/admin/dashboard/admin_home_page.dart';
import 'package:pocket_pal/src/screens/admin/moderate_forum/add_post_page.dart';
import 'package:pocket_pal/src/screens/admin/manage_user/admin_register_page.dart';
import 'package:pocket_pal/src/screens/admin/profile/admin_edit_profile.dart';
import 'package:pocket_pal/src/screens/patient/member_navigator.dart';
import 'package:pocket_pal/src/screens/patient/pages/member_chat_page.dart';
import 'package:pocket_pal/src/screens/patient/pages/member_forum_page.dart';
import 'package:pocket_pal/src/screens/therapist/pages/therapist_home_page.dart';
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
  static const String bannedPage = '/banned-page';

  static const String memberHome = '/member-home-page';
  static const String memberSchedule = '/member-schedule-page';
  static const String memberChat = '/member-chat-page';
  static const String memberForum = '/member-forum-page';
  static const String memberNavigator = '/member-navigator';

  static const String adminHome = '/admin-home-page';
  static const String adminEditProfilePage = '/admin-edit-profile-page';
  static const String adminRegisterPage = '/admin-register-page';

  static const String therapistHome = '/therapist-home-page';

  static const String addPostPage = '/add-post-page';

  // routes
  static final dynamic routes = <String, WidgetBuilder>{
    onboarding: (BuildContext context) => const OnboardingPage(),
    authPage: (BuildContext context) => const AuthPage(),
    forgotPW: (BuildContext context) => const ForgotPasswordPage(),
    mainPage: (BuildContext context) => const MainPage(),
    bannedPage: (BuildContext context) => const BannedPage(),
    memberHome: (BuildContext context) => const MemberHomePage(),
    memberSchedule: (BuildContext context) => const MemberSchedulePage(),
    memberChat: (BuildContext context) => const MemberChatPage(),
    memberForum: (BuildContext context) => const MemberForumPage(),
    memberNavigator: (BuildContext context) => const MemberNavigator(),
    adminHome: (BuildContext context) => const AdminHomePage(),
    adminEditProfilePage: (BuildContext context) =>
        const AdminEditProfilePage(),
    adminRegisterPage: (BuildContext context) => const AdminRegisterPage(),
    therapistHome: (BuildContext context) => const TherapistHomePage(),
    addPostPage: (BuildContext context) => const AddPostPage(),
  };
}
