import 'package:my_fit_squad/features/workouts_management/data/model/class.dart';

class ClassesState {
  List<Class> classes;
  ClassesState({
    this.classes = const [],
  });

  ClassesState copyWith({
    List<Class>? classes,
  }) {
    return ClassesState(
      classes: classes ?? this.classes,
    );
  }
}
