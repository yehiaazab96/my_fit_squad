import 'package:my_fit_squad/features/workouts_management/data/model/workout.dart';

class WorkoutsState {
  List<Workout> workouts;
  WorkoutsState({
    this.workouts = const [],
  });

  WorkoutsState copyWith({
    List<Workout>? workouts,
  }) {
    return WorkoutsState(
      workouts: workouts ?? this.workouts,
    );
  }
}
