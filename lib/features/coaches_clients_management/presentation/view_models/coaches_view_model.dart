import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_fit_squad/common/api/api_error_type.dart';
import 'package:my_fit_squad/features/base/data/helpers/base_api_result.dart';
import 'package:my_fit_squad/features/base/data/helpers/base_state.dart';
import 'package:my_fit_squad/features/base/presentation/view_models/base_view_model.dart';
import 'package:my_fit_squad/features/coaches_clients_management/data/repositories/coaches_clients_repository_impl.dart';
import 'package:my_fit_squad/features/coaches_clients_management/presentation/global_states/coaches_state.dart';
import 'package:my_fit_squad/features/user_management/data/model/user_model.dart';

class CoachesViewModel extends StateNotifier<BaseState<CoachesState>>
    with BaseViewModel {
  final CoachesAndClientsRepositoryImpl _workoutsRepositoryImpl;

  CoachesViewModel(this._workoutsRepositoryImpl)
      : super(BaseState(data: CoachesState()));

  getCoaches() async {
    hideKeyboard();

    state = state.copyWith(isLoading: true);
    BaseApiResult<List<User>> result =
        await _workoutsRepositoryImpl.getCoaches();
    if (result.data != null) {
      state = state.copyWith(data: state.data.copyWith(coaches: result.data));
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
