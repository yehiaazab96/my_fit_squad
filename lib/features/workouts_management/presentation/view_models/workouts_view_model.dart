import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_fit_squad/common/api/api_error_type.dart';
import 'package:my_fit_squad/features/base/data/helpers/base_api_result.dart';
import 'package:my_fit_squad/features/base/data/helpers/base_state.dart';
import 'package:my_fit_squad/features/base/presentation/view_models/base_view_model.dart';
import 'package:my_fit_squad/features/workouts_management/data/model/workout.dart';
import 'package:my_fit_squad/features/workouts_management/data/repositories/workout_repository_impl.dart';
import 'package:my_fit_squad/features/workouts_management/helpers/workout_category.dart';
import 'package:my_fit_squad/features/workouts_management/presentation/global_states/workouts_state.dart';

class WorkoutsViewModel extends StateNotifier<BaseState<WorkoutsState>>
    with BaseViewModel {
  final WorkoutRepositoryImpl _workoutsRepositoryImpl;

  WorkoutsViewModel(this._workoutsRepositoryImpl)
      : super(BaseState(data: WorkoutsState()));

  getWorkouts({WorkoutCategory? category}) async {
    hideKeyboard();

    state = state.copyWith(isLoading: true, hasNoData: false);
    BaseApiResult<List<Workout>> result =
        await _workoutsRepositoryImpl.getWorkouts(category: category);
    if (result.data != null) {
      print(result.data);

      state = state.copyWith(
          data: state.data.copyWith(
        workouts: result.data,
      ));
    } else {
      if (result.apiErrors != null) {
        showToastMessage(result.errorMessage ?? "Something went wrong");
      } else {
        handleError(errorType: result.errorType ?? ApiErrorType.generalError);
      }
    }
    state = state.copyWith(
        isLoading: false, hasNoData: state.data.workouts.isEmpty);
  }

  addWorkoutToList(Workout workout) {
    state = state.copyWith(
        data: state.data.copyWith(workouts: [...state.data.workouts, workout]));
  }
}
