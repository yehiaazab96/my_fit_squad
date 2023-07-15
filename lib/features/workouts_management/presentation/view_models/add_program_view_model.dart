import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_fit_squad/common/api/api_error_type.dart';
import 'package:my_fit_squad/common/constants/constants.dart';
import 'package:my_fit_squad/common/injection/injection_container.dart';
import 'package:my_fit_squad/features/base/data/helpers/base_api_result.dart';
import 'package:my_fit_squad/features/base/data/helpers/base_state.dart';
import 'package:my_fit_squad/features/base/presentation/view_models/base_view_model.dart';
import 'package:my_fit_squad/features/workouts_management/data/model/program.dart';
import 'package:my_fit_squad/features/workouts_management/data/model/program_data.dart';
import 'package:my_fit_squad/features/workouts_management/data/repositories/workout_repository_impl.dart';
import 'package:my_fit_squad/features/workouts_management/helpers/mixins/workout_validator_mixin.dart';
import 'package:my_fit_squad/features/workouts_management/presentation/global_states/add_program_state.dart';

class AddProgramViewModel extends StateNotifier<BaseState<AddProgramState>>
    with BaseViewModel, WorkoutValidatorMixin {
  final WorkoutRepositoryImpl _workoutsRepositoryImpl;

  AddProgramViewModel(this._workoutsRepositoryImpl)
      : super(BaseState(data: AddProgramState()));

  addProgram({required ProgramData programData}) async {
    hideKeyboard();

    state = state.copyWith(
        data: state.data.copyWith(
      errors: validateWorkoutFields(
        title: programData.title,
        description: programData.description,
        programClasses: programData.programClasses,
      ),
    ));
    if (state.data.errors.isEmpty) {
      state = state.copyWith(isLoading: true);
      BaseApiResult<Program> result =
          await _workoutsRepositoryImpl.addProgram(data: programData);
      if (result.data != null) {
        print(result.data);
        ProviderScope.containerOf(Constants.navigatorKey.currentContext!)
            .read(programsViewModelProvider.notifier)
            .addProgramToList(result.data!);
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
