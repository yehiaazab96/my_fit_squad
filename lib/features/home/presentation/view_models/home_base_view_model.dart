import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_fit_squad/common/constants/constants.dart';
import 'package:my_fit_squad/features/base/presentation/view_models/base_view_model.dart';
import 'package:my_fit_squad/features/home/data/helpers/home_screen_type.dart';

class HomeBaseViewModel extends StateNotifier<HomeScreenType>
    with BaseViewModel {
  HomeBaseViewModel() : super(HomeScreenType.home);

  void navigateTo(HomeScreenType screen,
      {arguments, Function? onReturn}) async {
    navigateToScreenNamed(screen.routeName,
        arguments: arguments,
        onReturn: onReturn,
        navigatorKey: Constants.homeNavigatorKey);

    state = screen;
    print(state.name);
  }

  void pop({onPop}) {
    Constants.homeNavigatorKey.currentState!.pop(onPop);
  }

  resetState() {
    state = HomeScreenType.home;
  }
}

final homeBaseScreenProvider =
    StateNotifierProvider<HomeBaseViewModel, HomeScreenType>(
        (ref) => HomeBaseViewModel());
