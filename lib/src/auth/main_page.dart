import 'package:flutter/material.dart';
import 'package:pocket_pal/src/auth/auth_page.dart';
import 'package:pocket_pal/src/models/user_model.dart';
import 'package:pocket_pal/src/screens/admin/pages/admin_home_page.dart';
import 'package:pocket_pal/src/screens/patient/member_navigator.dart';
import 'package:pocket_pal/src/screens/therapist/pages/therapist_home_page.dart';
import 'package:provider/provider.dart';
import 'package:pocket_pal/src/providers/user_provider.dart';

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
                if (role == 'member') {
                  return const MemberNavigator();
                } else if (role == 'admin') {
                  return const AdminHomePage();
                } else if (role == 'therapist') {
                  return const TherapistHomePage();
                } else {
                  return const Text('Role not recognized.');
                }
              }
            },
          );
        }
      },
    );
  }
}
