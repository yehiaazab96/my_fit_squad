import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_fit_squad/common/constants/constants.dart';
import 'package:my_fit_squad/common/injection/user_injection_container.dart';
import 'package:my_fit_squad/features/workouts_management/helpers/muscle_group.dart';
import 'package:my_fit_squad/features/workouts_management/helpers/workout_category.dart';

class Workout {
  String? id;
  String? title;
  bool? underReview;
  String? image;
  String? equipment;
  String? createdBy;
  List<String>? workoutsMedia;
  WorkoutCategory? category;
  String? description;
  MuscleGroup? muscleGroup;

  Workout({
    this.id,
    this.title,
    this.underReview,
    this.image,
    this.workoutsMedia,
    this.category,
    this.description,
    this.createdBy,
    this.equipment,
    this.muscleGroup,
  });

  Workout.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    title = json['title'];
    underReview = json['under_review'];
    createdBy = json['added_by'];
    image = json['image'];
    equipment = json['equipment'];
    workoutsMedia = json['workouts_media'] is List
        ? (json['workouts_media'] as List).map((e) => e.toString()).toList()
        : null;
    category = (json['category'] != null)
        ? WorkoutCategory.getWorkoutCategory(json['category'])
        : null;
    description = json['description'];
    muscleGroup = (json['muscle_group'] != null)
        ? MuscleGroup.getMuscleGroup(json['muscle_group'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = id;
    data['title'] = title;
    data['under_review'] = underReview;
    data['image'] = image;
    data['workouts_media'] = workoutsMedia;
    data['category'] = category;
    data['description'] = description;
    data['muscle_group'] = muscleGroup;
    data['added_by'] = createdBy;

    return data;
  }

  Map<String, dynamic> toJsonID() {
    final Map<String, dynamic> data = {};
    data['_id'] = id;

    return data;
  }

  copyWith(
      {String? id,
      String? title,
      bool? underReview,
      String? image,
      String? equipment,
      List<String>? workoutsMedia,
      WorkoutCategory? category,
      String? description,
      MuscleGroup? muscleGroup}) {
    this.id = id ?? this.id;
    this.title = title ?? this.title;
    this.underReview = underReview ?? this.underReview;
    this.image = image ?? this.image;
    this.workoutsMedia = workoutsMedia ?? this.workoutsMedia;
    this.category = category ?? this.category;
    this.equipment = equipment ?? this.equipment;
    this.description = description ?? this.description;
    this.muscleGroup = muscleGroup ?? this.muscleGroup;
  }
}
