import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_fit_squad/common/api/api_error_type.dart';
import 'package:my_fit_squad/features/base/data/helpers/base_api_result.dart';
import 'package:my_fit_squad/features/base/data/helpers/base_state.dart';
import 'package:my_fit_squad/features/base/presentation/view_models/base_view_model.dart';
import 'package:my_fit_squad/features/workouts_management/data/model/class.dart';
import 'package:my_fit_squad/features/workouts_management/data/repositories/workout_repository_impl.dart';
import 'package:my_fit_squad/features/workouts_management/presentation/global_states/classes_state.dart';

class ClassesViewModel extends StateNotifier<BaseState<ClassesState>>
    with BaseViewModel {
  final WorkoutRepositoryImpl _workoutsRepositoryImpl;

  ClassesViewModel(this._workoutsRepositoryImpl)
      : super(BaseState(data: ClassesState()));

  Future<List<Class>?> getClasses() async {
    hideKeyboard();

    state = state.copyWith(isLoading: true);
    BaseApiResult<List<Class>> result =
        await _workoutsRepositoryImpl.getClasses();
    if (result.data != null) {
      print(result.data);
      state = state.copyWith(data: state.data.copyWith(classes: result.data));
      state = state.copyWith(isLoading: false);

      return result.data;
    } else {
      if (result.apiErrors != null) {
        showToastMessage(result.errorMessage ?? "Something went wrong");
      } else {
        handleError(errorType: result.errorType ?? ApiErrorType.generalError);
      }
    }
    state = state.copyWith(isLoading: false);
  }

  addClassToList(Class cls) {
    state = state.copyWith(
        data: state.data.copyWith(classes: [...state.data.classes, cls]));
  }
}
