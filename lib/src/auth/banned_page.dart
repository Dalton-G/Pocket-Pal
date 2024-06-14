import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pocket_pal/src/providers/auth/user_provider.dart';
import 'package:pocket_pal/src/widgets/admin/manage_profile/ban_button.dart';
import 'package:pocket_pal/theme/app_theme.dart';
import 'package:provider/provider.dart';

class BannedPage extends StatelessWidget {
  const BannedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final currentUser = userProvider.userModel;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(35.0),
          child: Column(
            children: [
              const SizedBox(height: 30),
              Container(
                height: 35,
                child: Image.asset(
                    'lib/src/assets/images/pocketpallogowithword.png'),
              ),
              const SizedBox(height: 60),
              Text("Access Denied", style: AppTheme.largeTextRed),
              const SizedBox(height: 10),
              const Image(
                image: AssetImage('lib/src/assets/images/banned.png'),
              ),
              const SizedBox(height: 20),
              Text("Hi, ${currentUser?.firstName} ${currentUser?.lastName}",
                  style: AppTheme.smallTextGrey),
              const Text('You have been banned.',
                  style: AppTheme.mediumTextGrey),
              const SizedBox(height: 20),
              const Text(
                'Your account has been \n suspended for misconduct.',
                style: AppTheme.normalTextGrey,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              GestureDetector(
                onTap: () => context.read<UserProvider>().logout(),
                child: BanButton(
                  buttonText: "Log Out",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
