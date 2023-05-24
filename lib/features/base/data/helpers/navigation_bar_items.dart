import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_fit_squad/features/base/presentation/screens/side_menu_screen.dart';
import 'package:my_fit_squad/features/home/presentation/screens/home_base_screen.dart';
import 'package:my_fit_squad/features/home/presentation/screens/place.dart';
import 'package:my_fit_squad/features/home/presentation/screens/place2.dart';
import 'package:my_fit_squad/features/home/presentation/screens/profile.dart';

enum NavigationBarItem {
  home,
  placeholder1,
  placeholder2,
  profile;

  IconData get icon {
    switch (this) {
      case home:
        return Icons.home;
      case placeholder1:
        return Icons.ac_unit_sharp;
      case placeholder2:
        return Icons.account_tree_outlined;
      case profile:
        return Icons.person;
      default:
        return Icons.home;
    }
  }

  String get title {
    switch (this) {
      case home:
        return 'home'.tr();
      case placeholder1:
        return 'place'.tr();
      case placeholder2:
        return 'place2'.tr();
      case profile:
        return 'profile'.tr();
      default:
        return 'home'.tr();
    }
  }

  Widget get currentPage {
    switch (this) {
      case home:
        return SideMenuScreen(screen: const HomeBaseScreen());

      case placeholder1:
        return SideMenuScreen(screen: const PlaceScreen());
      case placeholder2:
        return SideMenuScreen(screen: const Place2Screen());
      case profile:
        return SideMenuScreen(screen: const ProfileScreen());
      default:
        return SideMenuScreen(screen: const HomeBaseScreen());
    }
  }

  static NavigationBarItem itemFromIndex(int ind) {
    switch (ind) {
      case 0:
        return NavigationBarItem.home;
      case 1:
        return NavigationBarItem.placeholder1;
      case 2:
        return NavigationBarItem.placeholder2;
      case 3:
        return NavigationBarItem.profile;
      default:
        return NavigationBarItem.home;
    }
  }
}
