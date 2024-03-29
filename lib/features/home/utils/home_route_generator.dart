import 'package:flutter/material.dart';
import 'package:my_fit_squad/features/home/presentation/screens/home.dart';

class HomeRouteGenerator {
  static generateRoute(RouteSettings settings) {
    // final args = settings.arguments;
    final name = settings.name;

    switch (name) {
      case HomeScreen.routeName:
        return const HomeScreen();
      default:
        return const HomeScreen();
    }
  }
}
