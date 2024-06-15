import 'package:flutter/material.dart';
import 'package:pocket_pal/src/providers/user_provider.dart';
import 'package:pocket_pal/src/widgets/admin/manage_profile/ban_button.dart';
import 'package:pocket_pal/theme/app_theme.dart';
import 'package:provider/provider.dart';

class RejectedPage extends StatelessWidget {
  const RejectedPage({super.key});

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
              const SizedBox(height: 40),
              Text("Rejected", style: AppTheme.largeTextRed),
              const SizedBox(height: 20),
              const Image(
                image: AssetImage('lib/src/assets/images/rejected.png'),
              ),
              const SizedBox(height: 20),
              Text("Hi, ${currentUser?.firstName} ${currentUser?.lastName}",
                  style: AppTheme.smallTextGrey),
              const Text("You're not for us", style: AppTheme.mediumTextGrey),
              const SizedBox(height: 20),
              const Text(
                "We're sad to inform you that your application has been rejected.",
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
