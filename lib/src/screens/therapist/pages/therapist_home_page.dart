import 'package:flutter/material.dart';
import 'package:pocket_pal/src/providers/auth/user_provider.dart';
import 'package:provider/provider.dart';

class TherapistHomePage extends StatelessWidget {
  const TherapistHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // APP BAR
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text(
          'Home Page',
        ),
      ),

      // BODY
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<UserProvider>().logout(),
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.logout),
      ),
    );
  }
}
