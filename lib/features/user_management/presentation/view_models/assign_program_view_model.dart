import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_fit_squad/common/api/api_error_type.dart';
import 'package:my_fit_squad/common/constants/constants.dart';
import 'package:my_fit_squad/common/injection/injection_container.dart';
import 'package:my_fit_squad/features/base/data/helpers/base_api_result.dart';
import 'package:my_fit_squad/features/base/data/helpers/base_state.dart';
import 'package:my_fit_squad/features/base/presentation/view_models/base_view_model.dart';
import 'package:my_fit_squad/features/coaches_clients_management/data/repositories/coaches_clients_repository_impl.dart';
import 'package:my_fit_squad/features/user_management/data/model/user_model.dart';
import 'package:my_fit_squad/features/user_management/data/repositories/user_repository_impl.dart';
import 'package:my_fit_squad/features/user_management/presentation/global_states/profile_state.dart';
import 'package:my_fit_squad/features/workouts_management/data/model/program.dart';

class AssignProgramViewModel extends StateNotifier<BaseState<ProfileState>>
    with BaseViewModel {
  final CoachesAndClientsRepositoryImpl _repositoryImpl;

  AssignProgramViewModel(this._repositoryImpl)
      : super(BaseState(data: ProfileState()));

  updateClientProgram(
      Program program, String startDate, String ClientID) async {
    hideKeyboard();
    var user = ProviderScope.containerOf(Constants.navigatorKey.currentContext!)
        .read(userProvider);

    state = state.copyWith(isLoading: true);
    BaseApiResult<User> result = await _repositoryImpl.updateClientWithProgram(
        program, startDate, ClientID);
    if (result.data != null) {
      showToastMessage('Client updated with program');
      ProviderScope.containerOf(Constants.profileNavigatorKey.currentContext!)
          .read(profileViewModelProvider.notifier)
          .pop();
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
