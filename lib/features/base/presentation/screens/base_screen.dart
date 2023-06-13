import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_fit_squad/common/injection/injection_container.dart';
import 'package:my_fit_squad/features/base/data/helpers/navigation_bar_items.dart';
import 'package:my_fit_squad/features/base/presentation/widgets/app_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:my_fit_squad/features/base/presentation/widgets/app_logo.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BaseScreen extends StatelessWidget {
  const BaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Consumer(builder: (_, ref, __) {
        NavigationBarItem item = ref.watch(currentPageProvider);

        return Scaffold(
            appBar: Device.width < 800
                ? AppBar(
                    leading: item.leadingWidget,
                    bottom: item.appBarBottomWidget,
                  )
                : null,
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              shape: const CircleBorder(),
              child: const Text('Add'),
            ),
            floatingActionButtonLocation: Device.width > 800
                ? FloatingActionButtonLocation.endFloat
                : FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar:
                Device.width < 800 ? const AppBottomNavigationBar() : null,
            body: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: IndexedStack(
                  index: item.index,
                  children: NavigationBarItem.values
                      .map((e) => e.currentPage)
                      .toList(),
                )
                //   ],
                // ),
                ));
      }),
    );
  }
}
