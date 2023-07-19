import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_fit_squad/common/api/api_error_type.dart';
import 'package:my_fit_squad/common/constants/constants.dart';
import 'package:my_fit_squad/common/injection/injection_container.dart';
import 'package:my_fit_squad/features/base/data/helpers/base_api_result.dart';
import 'package:my_fit_squad/features/base/data/helpers/base_state.dart';
import 'package:my_fit_squad/features/base/presentation/view_models/base_view_model.dart';
import 'package:my_fit_squad/features/user_management/data/model/message.dart';
import 'package:my_fit_squad/features/workouts_management/data/model/workout.dart';
import 'package:my_fit_squad/features/workouts_management/data/model/workout_data.dart';
import 'package:my_fit_squad/features/workouts_management/data/repositories/workout_repository_impl.dart';
import 'package:my_fit_squad/features/workouts_management/helpers/mixins/workout_validator_mixin.dart';
import 'package:my_fit_squad/features/workouts_management/presentation/global_states/add_workout_state.dart';

class AddWorkoutViewModel extends StateNotifier<BaseState<AddWorkoutState>>
    with BaseViewModel, WorkoutValidatorMixin {
  final WorkoutRepositoryImpl _workoutsRepositoryImpl;

  AddWorkoutViewModel(this._workoutsRepositoryImpl)
      : super(BaseState(data: AddWorkoutState()));

  addWorkout({required WorkoutData workoutData}) async {
    hideKeyboard();

    state = state.copyWith(
        data: state.data.copyWith(
      errors: validateWorkoutFields(
          title: workoutData.title,
          description: workoutData.description,
          image: workoutData.image,
          validateImage: true),
    ));
    if (state.data.errors.isEmpty) {
      state = state.copyWith(isLoading: true);
      BaseApiResult<Workout> result =
          await _workoutsRepositoryImpl.addWorkout(data: workoutData);
      if (result.data != null) {
        print(result.data);
        ProviderScope.containerOf(Constants.navigatorKey.currentContext!)
            .read(workoutsViewModelProvider.notifier)
            .addWorkoutToList(result.data!);

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

  Future<String?> updateWorkoutWithMedia(
      {required String id, required List<XFile> files}) async {
    hideKeyboard();

    if (state.data.errors.isEmpty) {
      state = state.copyWith(isLoading: true);
      BaseApiResult<ResponseMessage> result = await _workoutsRepositoryImpl
          .updateWorkoutWithMedia(id: id, files: files);
      if (result.data != null) {
        return result.data?.message ?? '';
        // ProviderScope.containerOf(Constants.workoutsNavigtorKey.currentContext!)
        //     .read(workoutScreenViewModelProvider.notifier)
        //     .pop();
      } else {
        if (result.apiErrors != null) {
          showToastMessage(result.errorMessage ?? "Something went wrong");
        } else {
          handleError(errorType: result.errorType ?? ApiErrorType.generalError);
        }
      }
      state = state.copyWith(isLoading: false);
    }
    return null;
  }
}
