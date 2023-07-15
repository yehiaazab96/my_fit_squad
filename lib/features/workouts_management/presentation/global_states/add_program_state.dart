import 'package:my_fit_squad/features/base/data/models/forms_errors.dart';

class AddProgramState {
  List<BaseFormError> errors;
  AddProgramState({
    this.errors = const [],
  });

  AddProgramState copyWith({List<BaseFormError>? errors}) {
    return AddProgramState(
      errors: errors ?? this.errors,
    );
  }
}
