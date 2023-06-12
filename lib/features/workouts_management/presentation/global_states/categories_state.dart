import 'package:my_fit_squad/features/workouts_management/helpers/workout_category.dart';

class CategoriesState {
  List<WorkoutCategory> categories;
  WorkoutCategory? currentSelectedCategory;
  CategoriesState({this.categories = const [], this.currentSelectedCategory});

  CategoriesState copyWith(
      {List<WorkoutCategory>? categories,
      WorkoutCategory? currentSelectedCategory}) {
    return CategoriesState(
        categories: categories ?? this.categories,
        currentSelectedCategory:
            currentSelectedCategory ?? this.currentSelectedCategory);
  }
}
