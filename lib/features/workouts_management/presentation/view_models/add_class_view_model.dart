import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_fit_squad/common/api/api_error_type.dart';
import 'package:my_fit_squad/common/constants/constants.dart';
import 'package:my_fit_squad/common/injection/injection_container.dart';
import 'package:my_fit_squad/features/base/data/helpers/base_api_result.dart';
import 'package:my_fit_squad/features/base/data/helpers/base_state.dart';
import 'package:my_fit_squad/features/base/presentation/view_models/base_view_model.dart';
import 'package:my_fit_squad/features/workouts_management/data/model/class.dart';
import 'package:my_fit_squad/features/workouts_management/data/model/class_data.dart';
import 'package:my_fit_squad/features/workouts_management/data/repositories/workout_repository_impl.dart';
import 'package:my_fit_squad/features/workouts_management/helpers/mixins/workout_validator_mixin.dart';
import 'package:my_fit_squad/features/workouts_management/presentation/global_states/add_class_state.dart';

class AddClassViewModel extends StateNotifier<BaseState<AddClassState>>
    with BaseViewModel, WorkoutValidatorMixin {
  final WorkoutRepositoryImpl _workoutsRepositoryImpl;

  AddClassViewModel(this._workoutsRepositoryImpl)
      : super(BaseState(data: AddClassState()));

  addClass({required ClassData classData}) async {
    hideKeyboard();

    state = state.copyWith(
        data: state.data.copyWith(
      errors: validateWorkoutFields(
        title: classData.title,
        description: classData.description,
        classWorkouts: classData.classWorkout,
      ),
    ));
    if (state.data.errors.isEmpty) {
      state = state.copyWith(isLoading: true);
      BaseApiResult<Class> result =
          await _workoutsRepositoryImpl.addClass(data: classData);
      if (result.data != null) {
        print(result.data);
        ProviderScope.containerOf(Constants.navigatorKey.currentContext!)
            .read(classesViewModelProvider.notifier)
            .addClassToList(result.data!);
        ProviderScope.containerOf(Constants.workoutsNavigtorKey.currentContext!)
            .read(workoutScreenViewModelProvider.notifier)
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
}
