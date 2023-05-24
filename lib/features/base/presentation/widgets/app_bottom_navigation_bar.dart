import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_fit_squad/common/injection/injection_container.dart';
import 'package:my_fit_squad/features/base/data/helpers/navigation_bar_items.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    print(Device.width);
    return Consumer(builder: (_, ref, __) {
      var notifier = ref.watch(currentPageProvider.notifier);
      NavigationBarItem page = ref.watch(currentPageProvider);
      return AnimatedBottomNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        activeColor: Theme.of(context).colorScheme.secondary,
        icons: NavigationBarItem.values.map((e) => e.icon).toList(),
        activeIndex: page.index,
        onTap: (index) {
          notifier.setCurrentIndex(index);
        },
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.sharpEdge,
      );
    });
  }
}
