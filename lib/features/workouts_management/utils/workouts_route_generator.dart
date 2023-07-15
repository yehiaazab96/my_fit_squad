import 'package:flutter/material.dart';
import 'package:my_fit_squad/features/workouts_management/data/model/class.dart';
import 'package:my_fit_squad/features/workouts_management/data/model/program.dart';
import 'package:my_fit_squad/features/workouts_management/data/model/workout.dart';
import 'package:my_fit_squad/features/workouts_management/helpers/entities/program_details_args.dart';
import 'package:my_fit_squad/features/workouts_management/presentation/screens/add_class_screen.dart';
import 'package:my_fit_squad/features/workouts_management/presentation/screens/add_program_screen.dart';
import 'package:my_fit_squad/features/workouts_management/presentation/screens/add_workout_screen.dart';
import 'package:my_fit_squad/features/workouts_management/presentation/screens/class_details_screen.dart';
import 'package:my_fit_squad/features/workouts_management/presentation/screens/program_details_screen.dart';
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

      case ProgramDetailsScreen.routeName:
        return ProgramDetailsScreen(programArgs: args as ProgramDetailsArgs);

      case AddWorkoutScreen.routeName:
        return const AddWorkoutScreen();

      case AddClassScreen.routeName:
        return const AddClassScreen();

      case AddProgramScreen.routeName:
        return const AddProgramScreen();

      case ClassDetailsScreen.routeName:
        return ClassDetailsScreen(cls: args as Class);
      default:
        return const WorkoutsBaseScreenTypeScreen();
    }
  }
}
