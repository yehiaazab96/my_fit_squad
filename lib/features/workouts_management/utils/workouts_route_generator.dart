import 'package:flutter/material.dart';
import 'package:my_fit_squad/features/home/presentation/screens/home.dart';
import 'package:my_fit_squad/features/workouts_management/presentation/screens/workouts_base_type_screen.dart';

class WorkoutsRouteGenerator {
  static generateRoute(RouteSettings settings) {
    // final args = settings.arguments;
    final name = settings.name;

    switch (name) {
      case HomeScreen.routeName:
        return const WorkoutsBaseScreenTypeScreen();
      default:
        return const WorkoutsBaseScreenTypeScreen();
    }
  }
}
