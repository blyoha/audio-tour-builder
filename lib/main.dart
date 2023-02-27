import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'config/theme.dart';
import 'presentation/pages/home/view/home_page.dart';

// TODO
// - Remove debug mode banner
// - Isolate ThemeData

void main() async {
  // Initialize Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Run the app
  runApp(const TourBuilderApp());
}

class TourBuilderApp extends StatefulWidget {
  const TourBuilderApp({Key? key}) : super(key: key);

  @override
  State<TourBuilderApp> createState() => _TourBuilderAppState();
}

class _TourBuilderAppState extends State<TourBuilderApp> {
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
      home: const HomePage(),
    );
  }
}
