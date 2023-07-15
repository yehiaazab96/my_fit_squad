import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_fit_squad/common/constants/constants.dart';
import 'package:my_fit_squad/common/injection/user_injection_container.dart';
import 'package:my_fit_squad/features/workouts_management/data/model/class_workout.dart';

class Class {
  String? id;
  String? title;
  String? description;
  String? createdBy;
  List<ClassWorkout>? classWorkouts;

  Class({
    this.id,
    this.title,
    this.description,
    this.createdBy,
    this.classWorkouts,
  });

  Class.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    title = json['title'];
    createdBy = json['created_by'];
    description = json['description'];
    classWorkouts = (json['workouts'] != null)
        ? (json['workouts'] as List)
            .map((e) => ClassWorkout.fromJson(e))
            .toList()
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['created_by'] = '63df172a148541a26e0e0be8';
    data['workouts'] = classWorkouts?.map((e) => e.toJson()).toList();
    data['created_by'] = createdBy;

    return data;
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
