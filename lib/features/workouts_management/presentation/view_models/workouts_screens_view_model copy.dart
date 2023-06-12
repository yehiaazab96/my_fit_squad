import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_fit_squad/features/workouts_management/helpers/workout_screen_type.dart';

class WorkoutsScreensViewModel extends StateNotifier<WorkoutScreenType> {
  WorkoutsScreensViewModel() : super(WorkoutScreenType.workouts);

  changeCurrentScreen(WorkoutScreenType type) {
    state = type;
  }
}
