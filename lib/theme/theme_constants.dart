import 'package:flutter/material.dart';

const primaryColor = Color(0xFFBAE1E8);
const accentColor = Color(0xFF71E7FF);
const errorColor = Color(0xFFF87968);
const backgroundColor = Color(0xFFF5F8F7);
const primaryTextColor = Color(0xFF101010);
const secondaryTextColor = Color(0xFF959595);

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: primaryColor,
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
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
);

ThemeData darkTheme = ThemeData(brightness: Brightness.dark);
