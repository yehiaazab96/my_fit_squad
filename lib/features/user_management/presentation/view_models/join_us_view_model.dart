import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_fit_squad/common/api/api_error_type.dart';
import 'package:my_fit_squad/common/constants/constants.dart';
import 'package:my_fit_squad/common/injection/user_injection_container.dart';
import 'package:my_fit_squad/common/utils/random_string_genartor.dart';
import 'package:my_fit_squad/features/base/data/helpers/base_api_result.dart';
import 'package:my_fit_squad/features/base/data/helpers/base_state.dart';
import 'package:my_fit_squad/features/base/presentation/view_models/base_view_model.dart';
import 'package:my_fit_squad/features/user_management/data/model/message.dart';
import 'package:my_fit_squad/features/user_management/data/model/user_model.dart';
import 'package:my_fit_squad/features/user_management/data/repositories/user_repository_impl.dart';
import 'package:my_fit_squad/features/user_management/helpers/coach_package.dart';
import 'package:my_fit_squad/features/user_management/helpers/join_us_steps.dart';
import 'package:my_fit_squad/features/user_management/helpers/mixins/user_validator_mixin.dart';
import 'package:my_fit_squad/features/user_management/helpers/user_type.dart';
import 'package:my_fit_squad/features/user_management/presentation/global_states/login_state.dart';

class JoinUsViewModel extends StateNotifier<BaseState<SignUpState>>
    with BaseViewModel, UserValidatorMixin {
  final UserRepositoryImpl _userRepositoryImpl;

  JoinUsViewModel(this._userRepositoryImpl)
      : super(BaseState(data: SignUpState()));

  signup({String? code}) async {
    hideKeyboard();

    state = state.copyWith(isLoading: true);
    BaseApiResult<User> result = await _userRepositoryImpl
        .signUp(state.data.user!, profileImage: state.data.profileImage);
    if (result.data != null) {
      print(result.data?.accessToken);

      Navigator.of(Constants.navigatorKey.currentContext!).pop();

      ProviderScope.containerOf(Constants.navigatorKey.currentContext!)
          .read(userProvider.notifier)
          .setState(result.data);
    } else {
      if (result.apiErrors != null) {
        showToastMessage(result.errorMessage ?? "Something went wrong");
      } else {
        handleError(errorType: result.errorType ?? ApiErrorType.generalError);
      }
    }
    state = state.copyWith(isLoading: false);
  }

  openForgetPasswordDialog(Dialog dialog) {
    showCustomDialog(dialog);
  }

  void validateInputsAndchangeStep(
      {required JoinUsSteps step,
      String? email,
      String? password,
      String? confirmPassword,
      String? firstName,
      String? lastName,
      XFile? profileImage,
      String? age}) {
    print(step);
    state = state.copyWith(
        data: state.data.copyWith(
      errors: validateUserField(
          email: email,
          password: password,
          confirmPassword: confirmPassword,
          firstName: firstName,
          lastName: lastName,
          age: age),
    ));
    if (state.data.errors.isEmpty) {
      if (state.data.currentStep == JoinUsSteps.userType) {
        state = state.copyWith(
            data: state.data.copyWith(
                user: User(
                    role: state.data.type.role,
                    subscribtionPlan: state.data.type.role == 'admin'
                        ? CoachPackages.free
                        : null),
                currentStep: step));
      } else {
        if (state.data.currentStep == JoinUsSteps.credentials) {
          state = state.copyWith(
              data: state.data.copyWith(
                  user: (state.data.user!)
                      .copyWith(email: email, password: password)));
        } else if (state.data.currentStep == JoinUsSteps.info) {
          state = state.copyWith(
              data: state.data.copyWith(
                  profileImage: profileImage,
                  user: (state.data.user!).copyWith(
                      firstName: firstName,
                      lastName: lastName,
                      age: age,
                      code: (firstName ?? '') +
                          RandomStringGenerator.generateRandomString(5) +
                          (lastName ?? ''))));
        }
        state = state.copyWith(data: state.data.copyWith(currentStep: step));
      }
    }
  }

  void changeUserType(UserType type) {
    state = state.copyWith(data: state.data.copyWith(type: type));
  }

  void changeCoachPlan(CoachPackages plan) {
    state = state.copyWith(
        data: state.data.copyWith(
            user: (state.data.user!).copyWith(subscribtionPlan: plan)));
  }

  validateCodeAndSignUp({required String code}) async {
    hideKeyboard();

    if (state.data.currentStep == JoinUsSteps.clientCoachCode) {
      state = state.copyWith(
          data: state.data
              .copyWith(user: (state.data.user!).copyWith(coachCode: code)));
    }

    state = state.copyWith(isLoading: true);

    BaseApiResult<User> result = await _userRepositoryImpl
        .signUp(state.data.user!, profileImage: state.data.profileImage);
    if (result.data != null) {
      print(result.data?.accessToken);

      ProviderScope.containerOf(Constants.navigatorKey.currentContext!)
          .read(userProvider.notifier)
          .setState(result.data);

      Future.delayed(0.5.seconds, () async {
        validateCode(code: code, id: result.data?.userId ?? '');
      });
    } else {
      if (result.apiErrors != null) {
        showToastMessage(result.errorMessage ?? "Something went wrong");
      } else {
        handleError(errorType: result.errorType ?? ApiErrorType.generalError);
      }
    }
    state = state.copyWith(isLoading: false);
  }

  validateCode({required String code, required String id}) async {
    BaseApiResult<ResponseMessage> resultMessage =
        await _userRepositoryImpl.validateCode(code: code, id: id);

    if (resultMessage.data != null) {
      showToastMessage(resultMessage.data?.message ?? '');
      Navigator.of(Constants.navigatorKey.currentContext!).pop();
    } else {
      showToastMessage('Code not valid');
    }
  }
}
