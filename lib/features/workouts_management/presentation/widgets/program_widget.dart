import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:my_fit_squad/common/api/api_urls.dart';
import 'package:my_fit_squad/features/workouts_management/data/model/program.dart';
import 'package:my_fit_squad/gen/assets.gen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ProgramWidget extends StatelessWidget {
  final Program? program;
  const ProgramWidget({super.key, this.program});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
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
              child: Image.network(
                '${ApiUrls.baseImageUrl}${ApiUrls.workouts}/${program?.classes?.first.classWorkouts?.first.workout?.image ?? ''}',
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return SpinKitWaveSpinner(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    waveColor: Theme.of(context).colorScheme.inversePrimary,
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Assets.images.loginBg.image(fit: BoxFit.cover);
                },
                opacity: const AlwaysStoppedAnimation(0.85),
              ),
            ),
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