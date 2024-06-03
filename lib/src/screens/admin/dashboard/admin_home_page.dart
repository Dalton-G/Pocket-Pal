import 'package:flutter/material.dart';
import 'package:pocket_pal/src/providers/auth/user_provider.dart';
import 'package:pocket_pal/theme/app_theme.dart';
import 'package:provider/provider.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final currentUser = userProvider.userModel;
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;

    return Scaffold(
      backgroundColor: AppTheme.backgroundWhite,

      // APP BAR
      appBar: AppBar(
        title: const Text('Admin Home Page'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () => context.read<UserProvider>().logout()),
        ],
      ),

      // BODY
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 20.0),
          child: Container(
            constraints: BoxConstraints(
                minHeight: screenHeight * 0.8, minWidth: screenWidth),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ID: ${currentUser?.id}',
                  style: AppTheme.normalTextGrey,
                ),
                Text(
                  'First Name: ${currentUser?.firstName}',
                  style: AppTheme.normalTextGrey,
                ),
                Text(
                  'Last Name: ${currentUser?.lastName}',
                  style: AppTheme.normalTextGrey,
                ),
                Text(
                  'Gender: ${currentUser?.gender}',
                  style: AppTheme.normalTextGrey,
                ),
                Text(
                  'Email: ${currentUser?.email}',
                  style: AppTheme.normalTextGrey,
                ),
                Text(
                  'Phone: ${currentUser?.phone}',
                  style: AppTheme.normalTextGrey,
                ),
                Text(
                  'Role: ${currentUser?.role}',
                  style: AppTheme.normalTextGrey,
                ),
                Text(
                  'Date of Birth: ${currentUser?.dateOfBirth}',
                  style: AppTheme.normalTextGrey,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
