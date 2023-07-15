import 'package:my_fit_squad/features/workouts_management/data/model/workout.dart';
import 'package:my_fit_squad/features/workouts_management/helpers/workout_type.dart';

class ClassWorkout {
  int? reps;
  int? repeat;
  int? restTime;
  WorkoutType? type;
  Workout? workout;
  ClassWorkout(
      {this.reps, this.repeat, this.restTime, this.type, this.workout});

  ClassWorkout.fromJson(Map<String, dynamic> json) {
    reps = json['reps'];
    repeat = json['repeat'];
    restTime = json['rest_time'];

    type = (json['workout_type'] != null)
        ? WorkoutType.getWorkoutType(json['workout_type'])
        : null;
    if (json['workout'] is Map) {
      workout = Workout.fromJson(json['workout']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['reps'] = reps;
    data['repeat'] = repeat;
    data['rest_time'] = restTime;
    data['type'] = type?.title.toLowerCase();
    data['workout'] = workout?.toJsonID();

    return data;
  }

  copyWith(
      {int? reps,
      int? repeat,
      int? restTime,
      WorkoutType? type,
      Workout? workout}) {
    this.repeat = repeat ?? this.repeat;
    this.reps = reps ?? this.reps;
    this.restTime = restTime ?? this.restTime;
    this.type = type ?? this.type;
    this.workout = workout ?? this.workout;
  }
}
