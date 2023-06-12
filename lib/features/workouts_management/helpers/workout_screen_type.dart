import 'package:flutter/material.dart';
import 'package:my_fit_squad/features/workouts_management/presentation/screens/classes.dart';
import 'package:my_fit_squad/features/workouts_management/presentation/screens/programs.dart';
import 'package:my_fit_squad/features/workouts_management/presentation/screens/workouts.dart';

enum WorkoutScreenType {
  workouts,
  classes,
  programs;

  String get title {
    switch (this) {
      case workouts:
        return "Workouts";
      case classes:
        return "Classes";
      case programs:
        return "Programs";
      default:
        return '';
    }
  }

  Widget get Screen {
    switch (this) {
      case workouts:
        return const WorkoutsScreen();
      case classes:
        return const ClassesScreen();
      case programs:
        return const ProgramsScreen();
      default:
        return const WorkoutsScreen();
    }
  }
}
