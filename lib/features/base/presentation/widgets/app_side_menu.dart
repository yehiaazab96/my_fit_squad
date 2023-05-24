import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_fit_squad/common/constants/colors.dart';
import 'package:my_fit_squad/common/injection/injection_container.dart';
import 'package:my_fit_squad/features/base/data/helpers/navigation_bar_items.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AppSideMenu extends StatelessWidget {
  final double? sideMenuWidth;
  const AppSideMenu({super.key, this.sideMenuWidth});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, ref, __) {
      var notifier = ref.watch(currentPageProvider.notifier);
      var controller =
          ref.watch(currentPageProvider.notifier).sideMenuController;

      return SideMenu(
          // showToggle: true,
          style: SideMenuStyle(
              iconSize: 3.h,
              compactSideMenuWidth: sideMenuWidth,
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              selectedColor: Theme.of(context).colorScheme.secondary,
              displayMode: SideMenuDisplayMode.compact,
              unselectedTitleTextStyle: TextStyle(color: AppColors.white),
              unselectedIconColor: AppColors.white),
          items: NavigationBarItem.values
              .map((e) => SideMenuItem(
                    priority: e.index,
                    onTap: (ind, _) => notifier.setCurrentIndex(ind),
                    title: e.title,
                    icon: Icon(e.icon),
                  ))
              .toList(),
          controller: controller);
    });
  }
}
