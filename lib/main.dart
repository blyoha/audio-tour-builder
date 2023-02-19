import 'package:flutter/material.dart';
import 'package:interview/features/tours/pages/tours_page.dart';

import 'common/utils/styles.dart';

void main() {
  runApp(const HomeScreen());
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.white,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: AppColors.primary,
          selectedItemColor: AppColors.black,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.black,
        ),
        fontFamily: 'Lato',
        cardTheme: CardTheme(
          color: AppColors.white,
          shadowColor: AppColors.black,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        textTheme: TextTheme(
          bodyMedium: TextStyle(
            fontSize: 16,
            color: AppColors.black,
          ),
        ),
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: AppColors.black,
        ),
      ),
      home: const ToursPage(),
    );
  }
}
