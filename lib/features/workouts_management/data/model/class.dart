import 'package:my_fit_squad/features/workouts_management/data/model/class_workout.dart';

class Class {
  String? id;
  String? title;
  String? description;
  List<ClassWorkout>? classWorkouts;
  Class({
    this.id,
    this.title,
    this.description,
    this.classWorkouts,
  });

  Class.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    title = json['title'];

    description = json['description'];
    classWorkouts = (json['workouts'] != null)
        ? (json['workouts'] as List)
            .map((e) => ClassWorkout.fromJson(e))
            .toList()
        : null;
  }

  copyWith(
      {String? id,
      String? title,
      String? description,
      List<ClassWorkout>? classWorkouts}) {
    this.id = id ?? this.id;
    this.title = title ?? this.title;
    this.description = description ?? this.description;
    this.classWorkouts = classWorkouts ?? this.classWorkouts;
  }
}
