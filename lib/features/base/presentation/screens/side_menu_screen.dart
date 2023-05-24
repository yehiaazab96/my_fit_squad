import 'package:my_fit_squad/features/base/presentation/widgets/app_side_menu.dart';
import 'package:my_fit_squad/features/base/presentation/widgets/visibility.dart';
import 'package:flutter/material.dart';

class SideMenuScreen extends StatelessWidget {
  final Widget screen;
  const SideMenuScreen({super.key, required this.screen});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        VisibilityWidget(
          childWidth: 50,
          condition: MediaQuery.of(context).size.width >= 800,
          child: const AppSideMenu(),
        ),
        screen
      ],
    );
  }
}
