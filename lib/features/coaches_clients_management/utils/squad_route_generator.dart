import 'package:flutter/material.dart';
import 'package:my_fit_squad/features/coaches_clients_management/presentation/screens/squad_screen.dart';

class SquadRouteGenerator {
  static generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    final name = settings.name;

    switch (name) {
      case SquadScreen.routeName:
        const SquadScreen();
      default:
        return const SquadScreen();
    }
  }
}
