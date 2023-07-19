import 'package:my_fit_squad/features/workouts_management/helpers/workout_screen_type.dart';

class WorkoutsScreensState {
  WorkoutScreenType? screen;
  WorkoutScreenType? returnScreen;

  WorkoutsScreensState({this.screen, this.returnScreen});

  WorkoutsScreensState copyWith(
      {WorkoutScreenType? screen, WorkoutScreenType? returnScreen}) {
    return WorkoutsScreensState(
        screen: screen ?? this.screen,
        returnScreen: returnScreen ?? this.returnScreen);
  }
}
