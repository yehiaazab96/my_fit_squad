import 'package:my_fit_squad/features/user_management/data/model/user_model.dart';
import 'package:my_fit_squad/features/workouts_management/data/model/workout.dart';

extension JsonParser on Map<String, dynamic> {
  V? parse<V>() {
    switch (V) {
      case User:
        return User.fromJson(this) as V;

      case Workout:
        return Workout.fromJson(this) as V;
    }

    return null;
  }
}
