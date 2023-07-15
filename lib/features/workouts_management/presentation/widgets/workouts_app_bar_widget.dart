import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_fit_squad/common/injection/injection_container.dart';
import 'package:my_fit_squad/features/workouts_management/helpers/workout_screen_type.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class WorkoutsAppBarWidget extends StatelessWidget {
  const WorkoutsAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, ref, __) {
      var notifer = ref.watch(workoutScreenViewModelProvider.notifier);
      var currentSelectedScreen = ref.watch(workoutScreenViewModelProvider);

      return Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 2.w),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(children: [
                ...WorkoutScreenType.values
                    .map((e) => GestureDetector(
                          onTap: () {
                            notifer.changeCurrentScreen(e);
                          },
                          child: Container(
                            height: 3.h,
                            width: 30.w,
                            margin: EdgeInsetsDirectional.only(
                                start: 2.w, end: 2.w, bottom: 1.h),
                            decoration: BoxDecoration(
                                border: currentSelectedScreen != e
                                    ? null
                                    : Border(
                                        bottom: BorderSide(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary))),
                            child: Center(
                              child: Text(
                                e.title,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                        color: currentSelectedScreen.screen != e
                                            ? Theme.of(context)
                                                .colorScheme
                                                .onSurface
                                            : Theme.of(context)
                                                .colorScheme
                                                .secondary),
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              ]),
            ),
          ),
        ],
      );
    });
  }
}
