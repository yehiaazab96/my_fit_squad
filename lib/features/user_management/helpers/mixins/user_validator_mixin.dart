import 'package:easy_localization/easy_localization.dart';
import 'package:my_fit_squad/features/base/data/models/forms_errors.dart';
import 'package:my_fit_squad/features/user_management/helpers/extensions/user_fields_extension.dart';

mixin UserValidatorMixin {
  List<BaseFormError> validateUserField({
    String? email,
    String? password,
    String? confirmPassword,
    String? firstName,
    String? lastName,
    String? age,
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

    if (confirmPassword != null) {
      if (confirmPassword.isEmpty) {
        errors.add(BaseFormError(
            field: UserFieldType.confirmPassword.field,
            message: "emptyPassword".tr()));
      } else if (confirmPassword != password) {
        errors.add(BaseFormError(
            field: UserFieldType.confirmPassword.field,
            message: "passwordMatch".tr()));
      }
    }

    if (firstName != null) {
      if (firstName.isEmpty) {
        errors.add(BaseFormError(
            field: UserFieldType.firstName.field,
            message: "emptyFirstName".tr()));
      }
    }
    if (lastName != null) {
      if (lastName.isEmpty) {
        errors.add(BaseFormError(
            field: UserFieldType.lastName.field,
            message: "emptyLastName".tr()));
      }
    }
    if (age != null) {
      if (age.isEmpty) {
        errors.add(BaseFormError(
            field: UserFieldType.age.field, message: "emptyAge".tr()));
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
