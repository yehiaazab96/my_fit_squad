import 'package:my_fit_squad/features/home/presentation/screens/home.dart';
import 'package:my_fit_squad/features/home/presentation/screens/home2.dart';

enum HomeScreenType {
  home,
  home2;

  String get routeName {
    switch (this) {
      case home:
        return HomeScreen.routeName;
      case home2:
        return Home2Screen.routeName;
    }
  }

  static HomeScreenType getScreenTypeFromRouteName(String routeName) {
    switch (routeName) {
      case HomeScreen.routeName:
        return home;
      case Home2Screen.routeName:
        return home2;
      default:
        return home;
    }
  }
}
