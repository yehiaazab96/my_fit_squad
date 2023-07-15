import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_fit_squad/common/injection/injection_container.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class WorkoutsBaseScreenTypeScreen extends StatelessWidget {
  static const routeName = './workout_base_screen';

  const WorkoutsBaseScreenTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        minimum: EdgeInsets.fromLTRB(0.w, 2.h, 0.w, 2.h),
        child: Consumer(builder: (_, ref, __) {
          var currentSelectedScreen = ref.watch(workoutScreenViewModelProvider);
          return currentSelectedScreen.screen!.Screen;
        }));
  }
}
