import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_fit_squad/common/injection/injection_container.dart';
import 'package:my_fit_squad/features/base/presentation/widgets/app_network_image.dart';
import 'package:my_fit_squad/features/workouts_management/data/model/class.dart';
import 'package:my_fit_squad/features/workouts_management/presentation/screens/class_details_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ClassWidget extends StatelessWidget {
  final Class? cls;
  const ClassWidget({super.key, this.cls});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Future.delayed(0.seconds, () {
          ProviderScope.containerOf(context)
              .read(workoutScreenViewModelProvider.notifier)
              .navigateTo(ClassDetailsScreen.routeName, arguments: cls);
        });
      },
      child: Container(
        margin: EdgeInsetsDirectional.fromSTEB(3.w, 0.5.h, 3.w, 0.5.h),
        height: 20.h,
        width: 90.w,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.inverseSurface,
            borderRadius: BorderRadius.circular(3.w),
            border: Border.all(
                color: Theme.of(context).colorScheme.inversePrimary,
                width: 1.w)),
        child: Stack(
          children: [
            Positioned.fill(
                child: AppNetworkImage(
              hasToken: true,
              url: cls?.classWorkouts?.first.workout?.image ?? '',
            )),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                // width: double.infinity,
                child: Container(
                  height: 8.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1.w),
                    color: Theme.of(context)
                        .colorScheme
                        .onInverseSurface
                        .withOpacity(0.4),
                  ),
                )),
            Positioned(
                bottom: 2.h,
                left: 2.5.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      cls?.title ?? '',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Theme.of(context).colorScheme.inverseSurface,
                          ),
                    ),
                    Text(
                      "${cls?.classWorkouts?.length} Workouts",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.inverseSurface,
                          ),
                    ),
                  ],
                ))
          ],
        ),
      ).animate().shimmer(duration: 3.seconds, delay: 1.seconds),
    );
  }
}
