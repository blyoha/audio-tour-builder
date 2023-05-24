import 'package:flutter/material.dart';

import '../../../theme/theme_constants.dart';

class SplashScreen extends StatefulWidget {
  static const String route = 'splash'; 
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryColor,
      alignment: Alignment.center,
      child: Image.asset("assets/images/logo.png"),
    );
  }

  _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 1))
        .then((_) => Navigator.pushReplacementNamed(context, "home"));
  }
}
