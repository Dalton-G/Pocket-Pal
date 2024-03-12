import 'package:flutter/material.dart';
import 'package:pocket_pal/theme/colors/colors.dart';

class IntroPage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryBlue,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 60),

            // Thumbnail
            Center(
              child: Container(
                height: 300,
                width: 300,
                child: Image.asset('lib/src/assets/images/onboarding_1.png'),
              ),
            ),

            // Title
            Padding(
              padding: EdgeInsets.fromLTRB(40, 50, 40, 0),
              child: Text(
                'Therapy made easy and accessible',
                style: TextStyle(
                  fontFamily: 'Overpass',
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
                textAlign: TextAlign.left,
              ),
            ),

            // Description
            Padding(
              padding: EdgeInsets.fromLTRB(40, 10, 40, 0),
              child: Text(
                "Pocket Pal brings therapy to your fingertips by connecting you with world-class counsellors and therapists.",
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  height: 1.5,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
