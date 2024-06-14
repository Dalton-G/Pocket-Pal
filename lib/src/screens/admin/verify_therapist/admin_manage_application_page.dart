import 'package:flutter/material.dart';
import 'package:pocket_pal/theme/app_theme.dart';

class AdminManageApplicationPage extends StatefulWidget {
  const AdminManageApplicationPage({super.key});

  @override
  State<AdminManageApplicationPage> createState() =>
      _AdminManageApplicationPageState();
}

class _AdminManageApplicationPageState
    extends State<AdminManageApplicationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundWhite,
      appBar: AppBar(
        title: Text("Manage Application"),
        automaticallyImplyLeading: false,
      ),
    );
  }
}
