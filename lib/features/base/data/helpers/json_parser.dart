import 'package:my_fit_squad/features/user_management/data/model/user_model.dart';
import 'package:my_fit_squad/features/workouts_management/data/model/class.dart';
import 'package:my_fit_squad/features/workouts_management/data/model/program.dart';
import 'package:my_fit_squad/features/workouts_management/data/model/workout.dart';
import 'package:my_fit_squad/features/workouts_management/helpers/workout_category.dart';

extension JsonParser on Map<String, dynamic> {
  V? parse<V>() {
    switch (V) {
      case User:
        return User.fromJson(this) as V;
      case Workout:
        return Workout.fromJson(this) as V;
      case Class:
        return Class.fromJson(this) as V;
      case Program:
        return Program.fromJson(this) as V;
      case WorkoutCategory:
        return WorkoutCategory.getWorkoutCategory(this.values.first) as V;
    }

    return null;
  }
}
