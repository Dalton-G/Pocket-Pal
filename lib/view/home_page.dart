import 'package:flutter/material.dart';
import 'package:pocket_pal/components/buttons/button_fill.dart';
import 'package:pocket_pal/utils/colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: primaryGreen,
        title: Text(
          'Sign In',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Overpass',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'Home Page',
              style: TextStyle(
                fontFamily: 'Nunito',
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),

          // Add the ButtonFill widget here
          ButtonFill(
            text: "Click me",
            btnColor: primaryOrange,
            txtColor: Colors.white,
            onPressed: () {},
          ),
          SizedBox(
            height: 30,
          ),

          // Add the ShadowButton widget here
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60),
            child: ShadowButton(
              text: 'Click me',
              txtColor: Colors.white,
              btnColor: secondaryBlue,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
