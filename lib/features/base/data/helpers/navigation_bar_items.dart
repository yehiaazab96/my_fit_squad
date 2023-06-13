import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_fit_squad/common/constants/constants.dart';
import 'package:my_fit_squad/common/injection/workouts_injection_container.dart';
import 'package:my_fit_squad/features/base/presentation/screens/side_menu_screen.dart';
import 'package:my_fit_squad/features/base/presentation/widgets/app_logo.dart';
import 'package:my_fit_squad/features/home/presentation/screens/home_base_screen.dart';
import 'package:my_fit_squad/features/home/presentation/screens/place2.dart';
import 'package:my_fit_squad/features/home/presentation/screens/profile.dart';
import 'package:my_fit_squad/features/workouts_management/helpers/workout_screen_type.dart';
import 'package:my_fit_squad/features/workouts_management/presentation/screens/workouts_base_screen.dart';
import 'package:my_fit_squad/features/workouts_management/presentation/widgets/workouts_app_bar_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

enum NavigationBarItem {
  home,
  workouts,
  placeholder2,
  profile;

  IconData get icon {
    switch (this) {
      case home:
        return Icons.home;
      case workouts:
        return Icons.play_circle_outlined;
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
      case workouts:
        return 'workouts'.tr();
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
        return const SideMenuScreen(screen: HomeBaseScreen());
      case workouts:
        return const SideMenuScreen(screen: WorkoutsBaseScreen());
      case placeholder2:
        return SideMenuScreen(screen: const Place2Screen());
      case profile:
        return SideMenuScreen(screen: const ProfileScreen());
      default:
        return const SideMenuScreen(screen: HomeBaseScreen());
    }
  }

  PreferredSizeWidget? get appBarBottomWidget {
    switch (this) {
      case home:
        return null;
      case workouts:
        return PreferredSize(
            preferredSize: Size.fromHeight(4.h),
            child: Consumer(builder: (_, ref, __) {
              var currentScreen = ref.watch(workoutScreenViewModelProvider);
              return currentScreen == WorkoutScreenType.other
                  ? Container()
                  : WorkoutsAppBarWidget();
            }));
      case placeholder2:
        return null;
      case profile:
        return null;
      default:
        return null;
    }
  }

  Widget? get leadingWidget {
    switch (this) {
      case workouts:
        return Consumer(builder: (_, ref, __) {
          var currentScreen = ref.watch(workoutScreenViewModelProvider);
          return currentScreen == WorkoutScreenType.other
              ? InkWell(
                  onTap: () {
                    ref
                        .watch(workoutScreenViewModelProvider.notifier)
                        .pop(type: WorkoutScreenType.workouts);
                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                  ),
                )
              : AppLogo(
                  margin: EdgeInsetsDirectional.only(start: 3.w, bottom: 1.h),
                );
        });

      default:
        return AppLogo(
          margin: EdgeInsetsDirectional.only(start: 3.w, bottom: 1.h),
        );
    }
  }

  static NavigationBarItem itemFromIndex(int ind) {
    switch (ind) {
      case 0:
        return NavigationBarItem.home;
      case 1:
        return NavigationBarItem.workouts;
      case 2:
        return NavigationBarItem.placeholder2;
      case 3:
        return NavigationBarItem.profile;
      default:
        return NavigationBarItem.home;
    }
  }
}
