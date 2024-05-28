import 'package:flutter/material.dart';
import 'package:pocket_pal/src/providers/user_provider.dart';
import 'package:pocket_pal/theme/app_theme.dart';
import 'package:provider/provider.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final currentUser = userProvider.userModel;

    return Scaffold(
      backgroundColor: AppTheme.backgroundWhite,

      // APP BAR
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text('Admin Home Page'),
      ),

      // BODY
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            currentUser != null
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('User ID: ${currentUser.id}',
                            style: AppTheme.normalTextGrey),
                        Text('User Email: ${currentUser.email}',
                            style: AppTheme.normalTextGrey),
                        Text('User Name: ${currentUser.firstName}',
                            style: AppTheme.normalTextGrey),
                        Text('User Role: ${currentUser.role}',
                            style: AppTheme.normalTextGrey),
                      ],
                    ),
                  )
                : const Center(
                    child: Text('No user model detected'),
                  ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
