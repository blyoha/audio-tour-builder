import 'package:flutter/material.dart';

import 'presentation/pages/auth/view/sign_in_page.dart';
import 'presentation/pages/builder/view/tour_builder_page.dart';
import 'presentation/pages/home/view/home_page.dart';
import 'presentation/pages/tour/tour_page.dart';

class AppRouter {
  static const String signInPage = SignInPage.route;
  static const String homePage = HomePage.route;
  static const String tourPage = TourPage.route;
  static const String tourBuilderPage = TourBuilderPage.route;

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case signInPage:
        return MaterialPageRoute(builder: (context) => const SignInPage());

      case homePage:
        return MaterialPageRoute(builder: (context) => const HomePage());

      case tourPage:
        return MaterialPageRoute(builder: (context) => const TourPage());

      case tourBuilderPage:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (context, animation, secondaryAnimation) =>
              const TourBuilderPage(),
        );

      default:
        throw ('Unknown route: ${settings.name}');
    }
  }
}
