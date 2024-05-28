import 'package:flutter/material.dart';
import 'package:pocket_pal/src/providers/user_provider.dart';
import 'package:pocket_pal/theme/app_theme.dart';
import 'package:provider/provider.dart';

class MemberHomePage extends StatelessWidget {
  const MemberHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final currentUser = userProvider.userModel;

    return Scaffold(
      backgroundColor: Colors.white,

      // APP BAR
      appBar: AppBar(
        title: const Text(
          'Home Page',
        ),
      ),

      // BODY
      body: currentUser != null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('User ID: ${currentUser.id}',
                      style: AppTheme.lightH2TextStyle),
                  Text('User Email: ${currentUser.email}',
                      style: AppTheme.lightH2TextStyle),
                  Text('User Name: ${currentUser.firstName}',
                      style: AppTheme.lightH2TextStyle),
                  Text('User Role: ${currentUser.role}',
                      style: AppTheme.lightH2TextStyle),
                ],
              ),
            )
          : const Center(
              child: Text('No user model detected'),
            ),
    );
  }
}
