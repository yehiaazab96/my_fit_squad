import 'package:flutter/material.dart';
import 'package:my_fit_squad/features/user_management/presentation/screens/join_us.dart';
import 'package:my_fit_squad/route_screen.dart';

class AppRouteGenerator {
  static generateRoute(RouteSettings settings) {
    final name = settings.name;

    switch (name) {
      case RouteScreen.routeName:
        return RouteScreen();

      case JoinUs.routeName:
        return const JoinUs();
      default:
        return RouteScreen();
    }
  }
}
