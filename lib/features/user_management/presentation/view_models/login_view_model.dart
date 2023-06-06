import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_fit_squad/common/api/api_error_type.dart';
import 'package:my_fit_squad/common/constants/constants.dart';
import 'package:my_fit_squad/common/injection/user_injection_container.dart';
import 'package:my_fit_squad/features/base/data/helpers/base_api_result.dart';
import 'package:my_fit_squad/features/base/data/helpers/base_state.dart';
import 'package:my_fit_squad/features/base/presentation/view_models/base_view_model.dart';
import 'package:my_fit_squad/features/user_management/data/model/user_model.dart';
import 'package:my_fit_squad/features/user_management/data/repositories/user_repository_impl.dart';
import 'package:my_fit_squad/features/user_management/presentation/global_states/login_state.dart';
import '../../helpers/mixins/user_validator_mixin.dart';

class LoginViewModel extends StateNotifier<BaseState<SignUpState>>
    with UserValidatorMixin, BaseViewModel {
  final UserRepositoryImpl _userRepositoryImpl;

  LoginViewModel(this._userRepositoryImpl)
      : super(BaseState(data: SignUpState()));

  login({
    String? email,
    String? password,
  }) async {
    hideKeyboard();
    state = state.copyWith(
        data: state.data.copyWith(
      errors: validateUserField(
        email: email,
        password: password,
      ),
    ));
    if (state.data.errors.isEmpty) {
      state = state.copyWith(isLoading: true);
      BaseApiResult<User> result =
          await _userRepositoryImpl.login(email ?? '', password ?? '');
      if (result.data != null) {
        print(result.data?.accessToken);
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
  }

  openForgetPasswordDialog(Dialog dialog) {
    showCustomDialog(dialog);
  }
}
