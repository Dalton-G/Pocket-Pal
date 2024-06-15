import 'package:flutter/material.dart';
import 'package:pocket_pal/src/auth/auth_page.dart';
import 'package:pocket_pal/src/auth/banned_page.dart';
import 'package:pocket_pal/src/auth/rejected_page.dart';
import 'package:pocket_pal/src/auth/waiting_page.dart';
import 'package:pocket_pal/src/models/auth/user_model.dart';
import 'package:pocket_pal/src/screens/admin/navigation/admin_navigator.dart';
import 'package:pocket_pal/src/screens/patient/member_navigator.dart';
import 'package:pocket_pal/src/screens/therapist/pages/therapist_home_page.dart';
import 'package:provider/provider.dart';
import 'package:pocket_pal/src/providers/auth/user_provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  Future<void>? _fetchUserModelFuture;

  @override
  void initState() {
    super.initState();
    _fetchUserModelFuture = context.read<UserProvider>().fetchAndSetUserModel();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fetchUserModelFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Selector<UserProvider, UserModel?>(
            selector: (_, provider) => provider.userModel,
            builder: (_, userModel, __) {
              if (userModel == null) {
                return const AuthPage();
              } else {
                final String role = userModel.role;
                if ((role == 'member' || role == 'Member') &&
                    !userModel.isBanned) {
                  return const MemberNavigator();
                } else if ((role == 'admin' || role == 'Admin') &&
                    !userModel.isBanned) {
                  return const AdminNavigator();
                } else if (role == 'therapist' || role == 'Therapist') {
                  if (!userModel.isSubmitted!) {
                    return const WaitingPage(); // TODO: redirect to submission page
                  } else {
                    if (!userModel.isBanned && userModel.isApproved!) {
                      return const TherapistHomePage();
                    } else if (!userModel.isBanned && !userModel.isApproved!) {
                      return const WaitingPage();
                    } else if (userModel.isBanned && !userModel.isApproved!) {
                      return const RejectedPage();
                    } else {
                      return const BannedPage();
                    }
                  }
                } else {
                  return const BannedPage();
                }
              }
            },
          );
        }
      },
    );
  }
}
