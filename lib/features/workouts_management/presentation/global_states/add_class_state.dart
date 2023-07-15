import 'package:my_fit_squad/features/base/data/models/forms_errors.dart';

class AddClassState {
  List<BaseFormError> errors;
  AddClassState({
    this.errors = const [],
  });

  AddClassState copyWith({List<BaseFormError>? errors}) {
    return AddClassState(
      errors: errors ?? this.errors,
    );
  }
}
