import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_fit_squad/common/api/api_error_type.dart';
import 'package:my_fit_squad/common/constants/constants.dart';
import 'package:my_fit_squad/common/injection/injection_container.dart';
import 'package:my_fit_squad/features/base/data/helpers/base_api_result.dart';
import 'package:my_fit_squad/features/base/data/helpers/base_state.dart';
import 'package:my_fit_squad/features/base/presentation/view_models/base_view_model.dart';
import 'package:my_fit_squad/features/coaches_clients_management/data/repositories/coaches_clients_repository_impl.dart';
import 'package:my_fit_squad/features/coaches_clients_management/presentation/global_states/client_state.dart';
import 'package:my_fit_squad/features/user_management/data/model/message.dart';
import 'package:my_fit_squad/features/user_management/data/model/user_model.dart';

class ClientsViewModl extends StateNotifier<BaseState<Clientstate>>
    with BaseViewModel {
  final CoachesAndClientsRepositoryImpl _workoutsRepositoryImpl;

  ClientsViewModl(this._workoutsRepositoryImpl)
      : super(BaseState(data: Clientstate()));

  getClients() async {
    hideKeyboard();

    state = state.copyWith(isLoading: true);
    BaseApiResult<List<User>> result =
        await _workoutsRepositoryImpl.getClients();
    if (result.data != null) {
      state = state.copyWith(data: state.data.copyWith(clients: result.data));
    } else {
      if (result.apiErrors != null) {
        showToastMessage(result.errorMessage ?? "Something went wrong");
      } else {
        handleError(errorType: result.errorType ?? ApiErrorType.generalError);
      }
    }
    state = state.copyWith(isLoading: false);
  }

  requestToJoinSquad(
      {String? coachID, bool? status, Function? onreturn}) async {
    hideKeyboard();

    state = state.copyWith(isLoading: true);
    BaseApiResult<ResponseMessage> result = await _workoutsRepositoryImpl
        .requestToJoinSquad(coachID: coachID, status: status);
    if (result.data != null) {
      ProviderScope.containerOf(Constants.navigatorKey.currentContext!)
          .read(userProvider.notifier)
          .changeRequestStatus(status);
      showToastMessage(result.data?.message ?? "");
      if (onreturn != null) {
        onreturn();
      }
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
