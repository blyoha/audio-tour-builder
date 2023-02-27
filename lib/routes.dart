import 'package:flutter/material.dart';

import 'presentation/pages/builder/view/tour_builder_page.dart';
import 'presentation/pages/home/view/home_page.dart';
import 'presentation/pages/tour/tour_page.dart';

const String homePage = HomePage.route;
const String tourPage = TourPage.route;
const String tourBuilderPage = TourBuilderPage.route;

Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
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
