import 'package:flutter/material.dart';
import 'package:my_fit_squad/features/workouts_management/data/model/class.dart';
import 'package:my_fit_squad/features/workouts_management/data/model/workout.dart';
import 'package:my_fit_squad/features/workouts_management/presentation/screens/class_details_screen.dart';
import 'package:my_fit_squad/features/workouts_management/presentation/screens/workout_details_screen.dart';
import 'package:my_fit_squad/features/workouts_management/presentation/screens/workouts_base_type_screen.dart';

class WorkoutsRouteGenerator {
  static generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    final name = settings.name;

    switch (name) {
      case WorkoutsBaseScreenTypeScreen.routeName:
        return const WorkoutsBaseScreenTypeScreen();

      case WorkoutDetailsScreen.routeName:
        return WorkoutDetailsScreen(workout: args as Workout);

      case ClassDetailsScreen.routeName:
        return ClassDetailsScreen(cls: args as Class);
      default:
        return const WorkoutsBaseScreenTypeScreen();
    }
  }
}
