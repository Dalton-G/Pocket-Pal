import 'package:flutter/material.dart';
import 'package:pocket_pal/src/providers/user_provider.dart';
import 'package:pocket_pal/src/widgets/admin/manage_profile/ban_button.dart';
import 'package:pocket_pal/theme/app_theme.dart';
import 'package:provider/provider.dart';

class WaitingPage extends StatelessWidget {
  const WaitingPage({super.key});

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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              Container(
                height: 35,
                child: Image.asset(
                    'lib/src/assets/images/pocketpallogowithword.png'),
              ),
              const SizedBox(height: 30),
              Text("Pending\nApproval", style: AppTheme.largeTextGreen),
              const SizedBox(height: 20),
              const Image(
                image: AssetImage('lib/src/assets/images/waiting.png'),
              ),
              const SizedBox(height: 20),
              Text("Hi, ${currentUser?.firstName} ${currentUser?.lastName}",
                  style: AppTheme.smallTextGrey),
              const Text('Hang in there!', style: AppTheme.mediumTextGrey),
              const SizedBox(height: 20),
              const Text(
                'Your application is being \n reviewed by an Admin. \n Please check back later.',
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
