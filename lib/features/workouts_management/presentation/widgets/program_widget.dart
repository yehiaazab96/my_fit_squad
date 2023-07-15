import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_fit_squad/common/api/api_urls.dart';
import 'package:my_fit_squad/common/injection/workouts_injection_container.dart';
import 'package:my_fit_squad/features/base/presentation/widgets/app_network_image.dart';
import 'package:my_fit_squad/features/workouts_management/data/model/program.dart';
import 'package:my_fit_squad/features/workouts_management/helpers/entities/program_details_args.dart';
import 'package:my_fit_squad/features/workouts_management/presentation/screens/program_details_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ProgramWidget extends StatelessWidget {
  final Program? program;
  final Function? onTap;
  const ProgramWidget({super.key, this.program, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Future.delayed(0.seconds, () {
          if (onTap != null) {
            onTap!();
          } else {
            ProviderScope.containerOf(context)
                .read(workoutScreenViewModelProvider.notifier)
                .navigateTo(ProgramDetailsScreen.routeName,
                    arguments: ProgramDetailsArgs(program: program));
          }
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
              url:
                  '${ApiUrls.baseImageUrl}${ApiUrls.workouts}/${program?.classes?.first.cls?.classWorkouts?.first.workout?.image ?? ''}',
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
                      program?.title ?? '',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Theme.of(context).colorScheme.inverseSurface,
                          ),
                    ),
                    Text(
                      "${program?.duration} Days : ${program?.classes?.length} Classes",
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
