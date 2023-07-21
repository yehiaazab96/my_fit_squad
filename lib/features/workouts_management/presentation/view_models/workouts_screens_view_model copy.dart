import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_fit_squad/common/constants/constants.dart';
import 'package:my_fit_squad/features/base/presentation/view_models/base_view_model.dart';
import 'package:my_fit_squad/features/workouts_management/helpers/workout_screen_type.dart';
import 'package:my_fit_squad/features/workouts_management/presentation/global_states/workout_screens_state.dart';
import 'package:my_fit_squad/features/workouts_management/presentation/screens/add_class_screen.dart';
import 'package:my_fit_squad/features/workouts_management/presentation/screens/add_program_screen.dart';
import 'package:my_fit_squad/features/workouts_management/presentation/screens/add_workout_screen.dart';

class WorkoutsScreensViewModel extends StateNotifier<WorkoutsScreensState>
    with BaseViewModel {
  WorkoutsScreensViewModel()
      : super(WorkoutsScreensState(screen: WorkoutScreenType.workouts));

  changeCurrentScreen(WorkoutScreenType type) {
    state = state.copyWith(screen: type);
  }

  void navigateTo(String routeName,
      {arguments, Function? onReturn, WorkoutScreenType? screenType}) async {
    state = state.copyWith(returnScreen: state.screen);
    changeCurrentScreen(WorkoutScreenType.other);
    navigateToScreenNamed(routeName,
        arguments: arguments,
        onReturn: onReturn,
        navigatorKey: Constants.workoutsNavigtorKey);
  }

  bool pop({onPop, WorkoutScreenType? type}) {
    changeCurrentScreen(
        type ?? (state.returnScreen ?? WorkoutScreenType.workouts));
    Constants.workoutsNavigtorKey.currentState!.pop(onPop);
    return true;
  }

  navigateToAddScreen() {
    if (state.screen == WorkoutScreenType.workouts) {
      navigateTo(AddWorkoutScreen.routeName);
    }
    if (state.screen == WorkoutScreenType.classes) {
      navigateTo(AddClassScreen.routeName);
    }
    if (state.screen == WorkoutScreenType.programs) {
      navigateTo(AddProgramScreen.routeName);
    }
  }
}
