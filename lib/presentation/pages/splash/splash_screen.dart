import 'package:flutter/material.dart';

import '../../../repositories/auth_repository.dart';
import '../../../theme/theme_constants.dart';
import '../auth/view/welcome_page.dart';
import '../home/view/home_page.dart';

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
      child: Image.asset("assets/images/logo.png", height: 160.0),
    );
  }

  _navigateToHome() async {
    final authRepo = AuthRepositoryImpl();
    final isLogged = await authRepo.isLogged();

    final route = PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          isLogged ? const HomePage() : const WelcomePage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(opacity: animation, child: child),
      transitionDuration: const Duration(seconds: 1),
    );

    await Future.delayed(const Duration(seconds: 1))
        .then((_) => Navigator.pushReplacement(context, route));
  }
}
