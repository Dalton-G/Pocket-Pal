import 'package:flutter/material.dart';
import 'package:pocket_pal/utils/colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryBlue,
        title: Text(
          'Pocket Pal',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Text('Home Page'),
      ),
    );
  }
}
