import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:my_fit_squad/common/api/api_urls.dart';
import 'package:my_fit_squad/common/constants/constants.dart';
import 'package:my_fit_squad/common/injection/injection_container.dart';
import 'package:my_fit_squad/features/base/presentation/widgets/app_network_image.dart';
import 'package:my_fit_squad/features/base/presentation/widgets/label.dart';
import 'package:my_fit_squad/features/workouts_management/data/model/class.dart';
import 'package:my_fit_squad/features/workouts_management/helpers/workout_screen_type.dart';
import 'package:my_fit_squad/features/workouts_management/presentation/screens/active_class_screen.dart';
import 'package:my_fit_squad/features/workouts_management/presentation/screens/workout_details_modal.dart';
import 'package:my_fit_squad/features/workouts_management/presentation/screens/workout_details_screen.dart';
import 'package:my_fit_squad/features/workouts_management/presentation/widgets/app_card.dart';
import 'package:my_fit_squad/gen/assets.gen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ClassDetailsWidget extends StatelessWidget {
  static const routeName = './class_details';
  final Class? cls;
  const ClassDetailsWidget({super.key, this.cls});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 20.h,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.network(
                    '${ApiUrls.baseImageUrl}${ApiUrls.workouts}/${cls?.classWorkouts?.first.workout?.image ?? ''}',
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
                    right: 2.5.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              cls?.title ?? '',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .inverseSurface,
                                  ),
                            ),
                            Text(
                              "${cls?.classWorkouts?.length} Workouts",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .inverseSurface,
                                  ),
                            ),
                          ],
                        ),
                        if (cls != null)
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  Constants.navigatorKey.currentContext!,
                                  MaterialPageRoute(
                                      builder: (context) => ActiveClassScreen(
                                          activeClass: cls!)));
                            },
                            child: Icon(
                              Icons.play_circle_fill_sharp,
                              size: 12.w,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          )
                      ],
                    ))
              ],
            ),
          ),
          AppCard(
            externalPadding: EdgeInsets.only(top: 1.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Equipment',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(
                  height: 1.h,
                ),
                Row(
                  children: [
                    if (cls != null && cls!.classWorkouts != null)
                      ...cls!.classWorkouts!
                          .map((e) => Padding(
                                padding: EdgeInsets.symmetric(horizontal: 1.w),
                                child:
                                    Label(title: e.workout?.equipment ?? '__'),
                              ))
                          .toList()
                  ],
                )
              ],
            ),
          ),
          AppCard(
            externalPadding: EdgeInsets.only(top: 1.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Description',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(
                  height: 1.h,
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 0.2.h, horizontal: 2.w),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(1.w),
                      color: Theme.of(context).colorScheme.secondaryContainer),
                  child: Text(
                    cls?.description ?? '',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                )
              ],
            ),
          ),
          AppCard(
            externalPadding: EdgeInsets.only(top: 1.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Workouts',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(
                  height: 1.h,
                ),
                Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 0.2.h, horizontal: 2.w),
                    // height: cls?.classWorkouts != null
                    //     ? (cls!.classWorkouts!.length) * 15.h
                    //     : 0,

                    height: 30.h,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(1.w)),
                    child: ListView(
                      children: [
                        if (cls?.classWorkouts != null)
                          ...cls!.classWorkouts!.map((e) {
                            return GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                      isScrollControlled: true,
                                      context: context,
                                      builder: (ctx) {
                                        return Container(
                                          height: 70.h,
                                          child: WorkoutDetailsModal(
                                            workout: e.workout,
                                          ),
                                        );
                                      });
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 1.h, horizontal: 3.w),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3.w),
                                      color: Theme.of(context)
                                          .colorScheme
                                          .surface),
                                  margin: EdgeInsets.symmetric(vertical: 1.h),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 10.h,
                                        width: 10.h,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(1.w),
                                          child: AppNetworkImage(
                                            hasToken: true,
                                            url: e.workout?.image ?? '',
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 12.w,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              e.workout?.title ?? '',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium,
                                            ),
                                            Text(
                                              '${e.reps ?? 0} ${e.type?.title ?? ''} * ${e.repeat ?? 0}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ));
                          }).toList()
                      ],
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
