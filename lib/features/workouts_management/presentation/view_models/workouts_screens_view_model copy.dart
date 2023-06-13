import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_fit_squad/common/constants/constants.dart';
import 'package:my_fit_squad/features/base/presentation/view_models/base_view_model.dart';
import 'package:my_fit_squad/features/workouts_management/helpers/workout_screen_type.dart';

class WorkoutsScreensViewModel extends StateNotifier<WorkoutScreenType>
    with BaseViewModel {
  WorkoutsScreensViewModel() : super(WorkoutScreenType.workouts);

  changeCurrentScreen(WorkoutScreenType type) {
    state = type;
  }

  void navigateTo(String routeName, {arguments, Function? onReturn}) async {
    changeCurrentScreen(WorkoutScreenType.other);
    navigateToScreenNamed(routeName,
        arguments: arguments,
        onReturn: onReturn,
        navigatorKey: Constants.workoutsNavigtorKey);
  }

  void pop({onPop, required WorkoutScreenType type}) {
    changeCurrentScreen(type);
    Constants.workoutsNavigtorKey.currentState!.pop(onPop);
  }
}
