import 'package:my_fit_squad/features/base/data/models/forms_errors.dart';

class SignUpState {
  List<BaseFormError> errors;
  SignUpState({
    this.errors = const [],
  });

  SignUpState copyWith({
    List<BaseFormError>? errors,
  }) {
    return SignUpState(
      errors: errors ?? this.errors,
    );
  }
}
