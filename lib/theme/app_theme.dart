import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();
  static const primaryGreen = Color(0xFF0b635c);
  static const primaryOrange = Color(0xFFe3776e);
  static const primaryBlue = Color(0xFF27344f);

  static const secondaryGreen = Color(0xFFdcece9);
  static const secondaryOrange = Color(0xFFf5c3ae);
  static const secondaryBlue = Color(0xFFaecdf5);

  static const accentGreen = Color(0xFFfafcfb);
  static const accentOrange = Color(0xFFfdf9f9);
  static const accentBlue = Color(0xFFf6f8fa);

  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color iconColor = primaryGreen;

  static const backgroundWhite = Color(0XFFFDF9F9);
  static const slateGrey = Color(0XFF27344F);

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: white,
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryGreen,
      foregroundColor: white,
      titleTextStyle: appBarTextStyle,
      iconTheme: IconThemeData(color: white),
    ),
    colorScheme: const ColorScheme.light(
      primary: primaryGreen,
      secondary: primaryOrange,
      onPrimary: secondaryGreen,
      onSecondary: secondaryOrange,
    ),
    iconTheme: const IconThemeData(
      color: iconColor,
    ),
    textTheme: _lightTextTheme,
  );

  static const TextTheme _lightTextTheme = TextTheme(
    displayLarge: lightH1TextStyle,
    displayMedium: lightH2TextStyle,
    displaySmall: lightH3TextStyle,
    bodyLarge: lightB1TextStyle,
    bodyMedium: lightB2TextStyle,
    bodySmall: lightB3TextStyle,
  );

  static const TextStyle appBarTextStyle = TextStyle(
    fontSize: 20.0,
    color: white,
    fontFamily: 'Overpass',
    fontWeight: FontWeight.bold,
  );
  static const TextStyle lightH1TextStyle = TextStyle(
    fontSize: 48.0,
    color: black,
    fontFamily: 'Overpass',
    fontWeight: FontWeight.bold,
  );
  static const TextStyle lightH2TextStyle = TextStyle(
    fontSize: 20.0,
    color: black,
    fontFamily: 'Overpass',
    fontWeight: FontWeight.bold,
  );
  static const TextStyle lightH3TextStyle = TextStyle(
    fontSize: 16.0,
    color: black,
    fontFamily: 'Overpass',
    fontWeight: FontWeight.bold,
  );
  static const TextStyle lightB1TextStyle = TextStyle(
    fontSize: 12.0,
    color: black,
    fontFamily: 'Nunito',
  );
  static const TextStyle lightB2TextStyle = TextStyle(
    fontSize: 10.0,
    color: black,
    fontFamily: 'Nunito',
  );
  static const TextStyle lightB3TextStyle = TextStyle(
    fontSize: 8.0,
    color: black,
    fontFamily: 'Nunito',
  );

  // Common
  static const TextStyle largeTextGreen = TextStyle(
    fontSize: 40.0,
    color: primaryGreen,
    fontFamily: 'Nunito',
    fontWeight: FontWeight.bold,
    height: 1,
  );
  static const TextStyle largeTextGrey = TextStyle(
    fontSize: 40.0,
    color: slateGrey,
    fontFamily: 'Nunito',
    fontWeight: FontWeight.bold,
    height: 1,
  );
  static const TextStyle largeTextGreen2 = TextStyle(
    fontSize: 36.0,
    color: primaryGreen,
    fontFamily: 'Nunito',
    fontWeight: FontWeight.bold,
    height: 1,
  );
  static const TextStyle largeTextGrey2 = TextStyle(
    fontSize: 36.0,
    color: slateGrey,
    fontFamily: 'Nunito',
    fontWeight: FontWeight.bold,
    height: 1,
  );
  static const TextStyle mediumTextGreen = TextStyle(
    fontSize: 24.0,
    color: primaryGreen,
    fontFamily: 'Nunito',
    fontWeight: FontWeight.bold,
  );
  static const TextStyle normalTextGrey = TextStyle(
    fontSize: 16.0,
    color: slateGrey,
    fontFamily: 'Nunito',
    fontWeight: FontWeight.w600,
  );
  static const TextStyle normalTextWhite = TextStyle(
    fontSize: 16.0,
    color: backgroundWhite,
    fontFamily: 'Nunito',
    fontWeight: FontWeight.w600,
  );
  static const TextStyle smallTextGreen = TextStyle(
    fontSize: 14.0,
    color: primaryGreen,
    fontFamily: 'Nunito',
    fontWeight: FontWeight.w600,
  );
  static const TextStyle smallTextGrey = TextStyle(
    fontSize: 14.0,
    color: slateGrey,
    fontFamily: 'Nunito',
    fontWeight: FontWeight.w600,
  );
  static const TextStyle boldTextGreen = TextStyle(
    fontSize: 16.0,
    color: primaryGreen,
    fontFamily: 'Nunito',
    fontWeight: FontWeight.bold,
  );

  // Onboarding Page Styles
  static const TextStyle onboardingTextH1 = TextStyle(
    fontSize: 16.0,
    color: slateGrey,
    fontWeight: FontWeight.w700,
    fontFamily: 'Nunito',
  );
  static const TextStyle onboardingTextB1 = TextStyle(
    fontSize: 14.0,
    color: slateGrey,
    fontFamily: 'Nunito',
  );
  static const TextStyle onboardingTextS1 = TextStyle(
    fontSize: 16.0,
    color: primaryGreen,
    fontFamily: 'Nunito',
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.italic,
  );
  static const BoxDecoration onboardingButton = BoxDecoration(
    color: primaryGreen,
    borderRadius: BorderRadius.all(Radius.circular(10)),
  );
  static BoxDecoration onboardingButtonOutline = BoxDecoration(
    color: Colors.transparent,
    borderRadius: BorderRadius.all(Radius.circular(10)),
    border: Border.all(color: primaryGreen, width: 2),
  );
  static const TextStyle onboardingButtonText = TextStyle(
    fontSize: 16.0,
    color: white,
    fontFamily: 'Nunito',
    fontWeight: FontWeight.bold,
  );

  // Auth Page Styles
  static BoxDecoration authBackButton = BoxDecoration(
    color: white,
    shape: BoxShape.circle,
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 2,
        blurRadius: 5,
        offset: const Offset(0, 3),
      ),
    ],
  );
  static const TextStyle textFieldHint1 = TextStyle(
    fontSize: 16.0,
    color: primaryGreen,
    fontFamily: 'Nunito',
    height: 0.75,
  );
  static const BoxDecoration lightGreenBorder = BoxDecoration(
    color: secondaryGreen,
    borderRadius: BorderRadius.all(Radius.circular(10)),
  );

  // Forun
  static InputDecoration categoryDropdownMenu = InputDecoration(
    fillColor: AppTheme.secondaryGreen,
    filled: true,
    prefixIcon: Icon(Icons.list, color: AppTheme.primaryGreen),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppTheme.secondaryGreen),
      borderRadius: BorderRadius.circular(10),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppTheme.secondaryGreen),
      borderRadius: BorderRadius.circular(10),
    ),
  );

  // static final ThemeData darkTheme = ThemeData(
  //   scaffoldBackgroundColor: _darkPrimaryVariantColor,
  //   appBarTheme: AppBarTheme(
  //     color: _darkPrimaryVariantColor,
  //     iconTheme: IconThemeData(color: _darkOnPrimaryColor),
  //   ),
  //   colorScheme: ColorScheme.light(
  //     primary: _darkPrimaryColor,
  //     primaryVariant: _darkPrimaryVariantColor,
  //     secondary: _darkSecondaryColor,
  //     onPrimary: _darkOnPrimaryColor,
  //   ),
  //   iconTheme: IconThemeData(
  //     color: _iconColor,
  //   ),
  //   textTheme: _darkTextTheme,
  // );

  //   static final TextTheme _darkTextTheme = TextTheme(
  //     headline: _darkScreenHeadingTextStyle,
  //     body1: _darkScreenTaskNameTextStyle,
  //     body2: _darkScreenTaskDurationTextStyle,
  //   );

  //   static final TextStyle _darkScreenHeadingTextStyle =
  //       _lightScreenHeadingTextStyle.copyWith(color: _darkOnPrimaryColor);
  //   static final TextStyle _darkScreenTaskNameTextStyle =
  //       _lightScreenTaskNameTextStyle.copyWith(color: _darkOnPrimaryColor);
  //   static final TextStyle _darkScreenTaskDurationTextStyle =
  //       _lightScreenTaskDurationTextStyle;
}
