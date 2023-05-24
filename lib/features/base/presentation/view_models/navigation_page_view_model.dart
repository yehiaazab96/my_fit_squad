import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_fit_squad/features/base/data/helpers/navigation_bar_items.dart';

class NavigationPageViewModel extends StateNotifier<NavigationBarItem> {
  NavigationPageViewModel() : super(NavigationBarItem.home);

  final SideMenuController sideMenuController = SideMenuController();
  // final PageController pageController = PageController();

  void setCurrentPage(NavigationBarItem page) {
    state = page;
  }

  void setCurrentIndex(int index) {
    // pageController.jumpToPage(index);

    setCurrentPage(NavigationBarItem.itemFromIndex(index));
    sideMenuController.changePage(index);
  }
}
