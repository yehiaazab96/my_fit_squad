import 'package:my_fit_squad/features/workouts_management/helpers/muscle_group.dart';
import 'package:my_fit_squad/features/workouts_management/helpers/workout_category.dart';

class Workout {
  String? id;
  String? title;
  bool? underReview;
  String? image;
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
    this.muscleGroup,
  });

  Workout.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    title = json['title'];
    underReview = json['under_review'];
    image = json['image'];
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

  copyWith(
      {String? id,
      String? title,
      bool? underReview,
      String? image,
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
    this.description = description ?? this.description;
    this.muscleGroup = muscleGroup ?? this.muscleGroup;
  }
}
