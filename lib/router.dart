import 'package:flutter/material.dart';

import 'presentation/pages/auth/view/welcome_page.dart';
import 'presentation/pages/builder/view/builder_page.dart';
import 'presentation/pages/home/view/home_page.dart';
import 'presentation/pages/my_tours/view/my_tours_page.dart';
import 'presentation/pages/profile/profile_page.dart';
import 'presentation/pages/routing/view/routing_page.dart';
import 'presentation/pages/splash/splash_screen.dart';
import 'presentation/pages/tour/view/tour_page.dart';
import 'repositories/models/tour.dart';

class AppRouter {
  static const String splashScreen = SplashScreen.route;
  static const String welcomePage = WelcomePage.route;
  static const String homePage = HomePage.route;
  static const String myToursPage = MyToursPage.route;
  static const String tourPage = TourPage.route;
  static const String builderPage = BuilderPage.route;
  static const String routingPage = RoutingPage.route;
  static const String profilePage = ProfilePage.route;

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashScreen:
        return MaterialPageRoute(builder: (context) => const SplashScreen());

      case welcomePage:
        return MaterialPageRoute(builder: (context) => const WelcomePage());

      case homePage:
        return MaterialPageRoute(builder: (context) => const HomePage());

      case myToursPage:
        return MaterialPageRoute(builder: (context) => const MyToursPage());

      case tourPage:
        final args = settings.arguments as Tour;
        return MaterialPageRoute(builder: (context) => TourPage(tour: args));

      case builderPage:
        final args = settings.arguments as Tour;
        return MaterialPageRoute(builder: (context) => BuilderPage(tour: args));

      case routingPage:
        final args = settings.arguments as Tour;
        return MaterialPageRoute(builder: (context) => RoutingPage(tour: args));

      case profilePage:
        return MaterialPageRoute(builder: (context) => const ProfilePage());

      default:
        throw ('Unknown route: ${settings.name}');
    }
  }
}
