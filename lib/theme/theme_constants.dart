import 'package:flutter/material.dart';

const primaryColor = Color(0xFFBAE1E8);
const accentColor = Color(0xFF71E7FF);
const errorColor = Color(0xFFF87968);
const backgroundColor = Color(0xFFF5F8F7);
const primaryTextColor = Color(0xFF101010);
const secondaryTextColor = Color(0xFF959595);

ThemeData lightTheme = ThemeData(
  snackBarTheme: SnackBarThemeData(
    backgroundColor: errorColor,
    elevation: 4.0,
    behavior: SnackBarBehavior.floating,
    contentTextStyle: const TextStyle(
      color: Colors.white,
      fontSize: 20.0,
    ),
    insetPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4.0),
    ),
  ),
  brightness: Brightness.light,
  primaryColor: primaryColor,
  scaffoldBackgroundColor: backgroundColor,
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    elevation: 0.0,
    type: BottomNavigationBarType.fixed,
    selectedLabelStyle: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 20.0,
    ),
    unselectedLabelStyle: TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 16.0,
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: primaryColor,
    foregroundColor: primaryTextColor,
    extendedSizeConstraints: BoxConstraints(minWidth: 100.0, minHeight: 55.0),
    elevation: 4.0,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0))),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.symmetric(vertical: 18.0, horizontal: 14.0)),
      shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      )),
      // backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
    ),
  ),
  searchBarTheme: SearchBarThemeData(
    elevation: MaterialStateProperty.all<double>(0.0),
    shape: MaterialStateProperty.all<OutlinedBorder>(
      RoundedRectangleBorder(
        side: BorderSide(
          width: 1.0,
          color: primaryTextColor.withOpacity(0.2),
        ),
        borderRadius: BorderRadius.circular(15.0),
      ),
    ),
    textStyle: MaterialStateProperty.all<TextStyle>(const TextStyle(
      color: primaryTextColor,
      fontSize: 16.0,
    )),
    hintStyle: MaterialStateProperty.all<TextStyle>(const TextStyle(
      color: secondaryTextColor,
      fontSize: 16.0,
      fontWeight: FontWeight.w300,
    )),
  ),
  appBarTheme: const AppBarTheme(
    elevation: 0.0,
    titleTextStyle: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 24.0,
      color: primaryTextColor,
    ),
    foregroundColor: primaryTextColor,
    backgroundColor: backgroundColor,
  ),
  tabBarTheme: TabBarTheme(
    labelColor: primaryTextColor,
    unselectedLabelColor: primaryTextColor,
    labelStyle: const TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 16.0,
    ),
    unselectedLabelStyle: const TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 16.0,
    ),
    indicator: BoxDecoration(
      color: primaryColor.withOpacity(0.5),
      borderRadius: BorderRadius.circular(10.0),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      backgroundColor: primaryColor,
      foregroundColor: primaryTextColor,
      elevation: 4.0,
      shadowColor: primaryColor.withOpacity(0.25),
      minimumSize: const Size(120.0, 60.0),
      padding: const EdgeInsets.symmetric(
        horizontal: 18.0,
        vertical: 14.0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      textStyle: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 22.0,
      ),
    ),
  ),
  textTheme: const TextTheme(
    // FAB text
    labelLarge: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 18.0,
    ),
    bodyLarge: TextStyle(
      color: primaryTextColor,
      fontSize: 18.0,
    ),
    // Casual text
    bodyMedium: TextStyle(
      color: primaryTextColor,
      fontSize: 16.0,
    ),
    titleMedium: TextStyle(
      color: primaryTextColor,
      fontSize: 22.0,
      fontWeight: FontWeight.w600,
    ),
    titleLarge: TextStyle(
      color: primaryTextColor,
      fontSize: 26.0,
      fontWeight: FontWeight.w600,
    ),
  ),
  dialogTheme: const DialogTheme(
    elevation: 4.0,
    backgroundColor: backgroundColor,
    alignment: Alignment.center,
    actionsPadding: const EdgeInsets.symmetric(),
  ),
  progressIndicatorTheme: const ProgressIndicatorThemeData(color: primaryColor),
);

ThemeData darkTheme = ThemeData(brightness: Brightness.dark);
