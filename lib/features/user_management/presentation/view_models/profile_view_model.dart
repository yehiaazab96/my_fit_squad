import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_fit_squad/common/api/api_error_type.dart';
import 'package:my_fit_squad/common/constants/constants.dart';
import 'package:my_fit_squad/common/injection/injection_container.dart';
import 'package:my_fit_squad/features/base/data/helpers/base_api_result.dart';
import 'package:my_fit_squad/features/base/data/helpers/base_state.dart';
import 'package:my_fit_squad/features/base/presentation/view_models/base_view_model.dart';
import 'package:my_fit_squad/features/coaches_clients_management/data/repositories/coaches_clients_repository_impl.dart';
import 'package:my_fit_squad/features/coaches_clients_management/presentation/global_states/coaches_state.dart';
import 'package:my_fit_squad/features/user_management/data/model/message.dart';
import 'package:my_fit_squad/features/user_management/data/model/user_model.dart';
import 'package:my_fit_squad/features/user_management/data/repositories/user_repository_impl.dart';
import 'package:my_fit_squad/features/user_management/presentation/global_states/profile_state.dart';

class ProfileViewModel extends StateNotifier<BaseState<ProfileState>>
    with BaseViewModel {
  final UserRepositoryImpl _userRepositoryImpl;

  ProfileViewModel(this._userRepositoryImpl)
      : super(BaseState(data: ProfileState()));

  getUserProfile() async {
    hideKeyboard();
    var user = ProviderScope.containerOf(Constants.navigatorKey.currentContext!)
        .read(userProvider);

    state = state.copyWith(isLoading: true);
    BaseApiResult<User> result =
        await _userRepositoryImpl.getUserProfile(user?.userId ?? '');
    if (result.data != null) {
      var temp = result.data;
      temp?.accessToken = user?.accessToken;
      ProviderScope.containerOf(Constants.navigatorKey.currentContext!)
          .read(userProvider.notifier)
          .setState(temp);
    } else {
      if (result.apiErrors != null) {
        showToastMessage(result.errorMessage ?? "Something went wrong");
      } else {
        handleError(errorType: result.errorType ?? ApiErrorType.generalError);
      }
    }
    state = state.copyWith(isLoading: false);
  }

  void navigateTo(String routeName, {arguments, Function? onReturn}) async {
    navigateToScreenNamed(routeName,
        arguments: arguments,
        onReturn: onReturn,
        navigatorKey: Constants.profileNavigatorKey);
  }

  void pop({onPop}) {
    Constants.profileNavigatorKey.currentState!.pop(onPop);
  }
}
