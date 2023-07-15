import 'package:my_fit_squad/features/base/data/models/forms_errors.dart';

class AddWorkoutState {
  List<BaseFormError> errors;
  AddWorkoutState({
    this.errors = const [],
  });

  AddWorkoutState copyWith({List<BaseFormError>? errors}) {
    return AddWorkoutState(
      errors: errors ?? this.errors,
    );
  }
}
