import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_fit_squad/common/api/api_error_type.dart';
import 'package:my_fit_squad/common/constants/constants.dart';
import 'package:my_fit_squad/common/injection/workouts_injection_container.dart';
import 'package:my_fit_squad/features/base/data/helpers/base_api_result.dart';
import 'package:my_fit_squad/features/base/data/helpers/base_state.dart';
import 'package:my_fit_squad/features/base/presentation/view_models/base_view_model.dart';
import 'package:my_fit_squad/features/workouts_management/data/repositories/workout_repository_impl.dart';
import 'package:my_fit_squad/features/workouts_management/helpers/workout_category.dart';
import 'package:my_fit_squad/features/workouts_management/presentation/global_states/categories_state.dart';

class CategoriesViewModel extends StateNotifier<BaseState<CategoriesState>>
    with BaseViewModel {
  final WorkoutRepositoryImpl _workoutsRepositoryImpl;

  CategoriesViewModel(this._workoutsRepositoryImpl)
      : super(BaseState(data: CategoriesState()));

  getCategories() async {
    hideKeyboard();

    state = state.copyWith(isLoading: true);
    BaseApiResult<List<WorkoutCategory>> result =
        await _workoutsRepositoryImpl.getCategories();
    if (result.data != null) {
      state =
          state.copyWith(data: state.data.copyWith(categories: result.data));
    } else {
      if (result.apiErrors != null) {
        showToastMessage(result.errorMessage ?? "Something went wrong");
      } else {
        handleError(errorType: result.errorType ?? ApiErrorType.generalError);
      }
    }
    state = state.copyWith(isLoading: false);
  }

  changeCurrentSelectedCategory(WorkoutCategory? category) {
    state =
        state.copyWith(data: state.data..currentSelectedCategory = category);
    Future.delayed(0.seconds, () {
      ProviderScope.containerOf(Constants.navigatorKey.currentContext!)
          .read(workoutsViewModelProvider.notifier)
          .getWorkouts(category: category);
    });
  }
}
