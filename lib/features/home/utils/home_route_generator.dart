import 'package:flutter/material.dart';
import 'package:my_fit_squad/features/home/presentation/screens/home.dart';
import 'package:my_fit_squad/features/home/presentation/screens/home2.dart';

class HomeRouteGenerator {
  static generateRoute(RouteSettings settings) {
    // final args = settings.arguments;
    final name = settings.name;

    switch (name) {
      case HomeScreen.routeName:
        return const HomeScreen();
      case Home2Screen.routeName:
        return const Home2Screen();
      default:
        return const HomeScreen();
    }
  }
}
