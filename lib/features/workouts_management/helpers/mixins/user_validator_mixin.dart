import 'package:easy_localization/easy_localization.dart';
import 'package:my_fit_squad/features/base/data/models/forms_errors.dart';
import 'package:my_fit_squad/features/user_management/helpers/extensions/user_fields_extension.dart';

mixin UserValidatorMixin {
  List<BaseFormError> validateUserField({
    String? email,
    String? password,
  }) {
    List<BaseFormError> errors = [];
    if (email != null) {
      if (email.isEmpty) {
        errors.add(BaseFormError(
            field: UserFieldType.email.field, message: "emptyEmail".tr()));
      } else if (!isValidEmail(email)) {
        errors.add(BaseFormError(
            field: UserFieldType.email.field, message: "invalidEmail".tr()));
      }
    }

    if (password != null) {
      if (password.isEmpty) {
        errors.add(BaseFormError(
            field: UserFieldType.password.field,
            message: "emptyPassword".tr()));
      }
    }
    return errors;
  }

  List<BaseFormError> evaluateValidationError(
      Map<String, dynamic> validationErrors) {
    List<BaseFormError> errors = [];

    validationErrors.forEach((validationKey, value) {
      if (validationKey == UserFieldType.email.field) {
        errors.add(
            BaseFormError(field: UserFieldType.email.field, message: value));
      } else if (validationKey == UserFieldType.password.field) {
        errors.add(
            BaseFormError(field: UserFieldType.password.field, message: value));
      }
    });
    return errors;
  }

  bool isValidEmail(String email) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    return emailValid;
  }
}
