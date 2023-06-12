import 'package:my_fit_squad/features/home/presentation/screens/home.dart';

enum HomeScreenType {
  home;

  String get routeName {
    switch (this) {
      case home:
        return HomeScreen.routeName;
    }
  }

  static HomeScreenType getScreenTypeFromRouteName(String routeName) {
    switch (routeName) {
      case HomeScreen.routeName:
        return home;
      default:
        return home;
    }
  }
}
