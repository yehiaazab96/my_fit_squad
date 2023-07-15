import 'package:flutter/material.dart';
import 'package:my_fit_squad/features/user_management/presentation/screens/profile_screen.dart';
import 'package:my_fit_squad/features/workouts_management/helpers/entities/program_details_args.dart';
import 'package:my_fit_squad/features/workouts_management/presentation/screens/program_details_screen.dart';

class ProfileRouteGenrator {
  static generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    final name = settings.name;

    switch (name) {
      case ProfileScreen.routeName:
        return const ProfileScreen();
      case ProgramDetailsScreen.routeName:
        return ProgramDetailsScreen(
          programArgs: args as ProgramDetailsArgs,
        );
      default:
        return const ProfileScreen();
    }
  }
}
