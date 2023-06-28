import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_fit_squad/features/base/data/models/forms_errors.dart';
import 'package:my_fit_squad/features/user_management/data/model/user_model.dart';
import 'package:my_fit_squad/features/user_management/helpers/join_us_steps.dart';
import 'package:my_fit_squad/features/user_management/helpers/user_type.dart';

class SignUpState {
  List<BaseFormError> errors;
  JoinUsSteps currentStep;
  User? user;
  UserType type;
  XFile? profileImage;

  SignUpState(
      {this.errors = const [],
      this.currentStep = JoinUsSteps.userType,
      this.type = UserType.client,
      this.profileImage,
      this.user});

  SignUpState copyWith({
    List<BaseFormError>? errors,
    JoinUsSteps? currentStep,
    UserType? type,
    XFile? profileImage,
    User? user,
  }) {
    return SignUpState(
        errors: errors ?? this.errors,
        user: user ?? this.user,
        type: type ?? this.type,
        profileImage: profileImage ?? this.profileImage,
        currentStep: currentStep ?? this.currentStep);
  }
}
