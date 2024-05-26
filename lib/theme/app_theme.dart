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

  // onboarding page
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
  static const TextStyle onboardingButtonText = TextStyle(
    fontSize: 16.0,
    color: white,
    fontFamily: 'Nunito',
    fontWeight: FontWeight.bold,
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
