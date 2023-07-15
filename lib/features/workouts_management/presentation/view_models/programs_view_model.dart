import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_fit_squad/common/api/api_error_type.dart';
import 'package:my_fit_squad/features/base/data/helpers/base_api_result.dart';
import 'package:my_fit_squad/features/base/data/helpers/base_state.dart';
import 'package:my_fit_squad/features/base/presentation/view_models/base_view_model.dart';
import 'package:my_fit_squad/features/workouts_management/data/model/program.dart';
import 'package:my_fit_squad/features/workouts_management/data/repositories/workout_repository_impl.dart';
import 'package:my_fit_squad/features/workouts_management/presentation/global_states/programs_state.dart';

class ProgramsViewModel extends StateNotifier<BaseState<ProgramsState>>
    with BaseViewModel {
  final WorkoutRepositoryImpl _workoutsRepositoryImpl;

  ProgramsViewModel(this._workoutsRepositoryImpl)
      : super(BaseState(data: ProgramsState()));

  getPrograms() async {
    hideKeyboard();

    state = state.copyWith(isLoading: true);
    BaseApiResult<List<Program>> result =
        await _workoutsRepositoryImpl.getPrograms();
    if (result.data != null) {
      print(result.data);
      state = state.copyWith(data: state.data.copyWith(programs: result.data));
    } else {
      if (result.apiErrors != null) {
        showToastMessage(result.errorMessage ?? "Something went wrong");
      } else {
        handleError(errorType: result.errorType ?? ApiErrorType.generalError);
      }
    }
    state = state.copyWith(isLoading: false);
  }

  addProgramToList(Program program) {
    state = state.copyWith(
        data: state.data.copyWith(programs: [...state.data.programs, program]));
  }
}
