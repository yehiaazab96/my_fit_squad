import 'package:flutter/material.dart';
import 'package:my_fit_squad/common/api/api_urls.dart';
import 'package:my_fit_squad/common/constants/constants.dart';
import 'package:my_fit_squad/features/base/presentation/widgets/app_network_image.dart';
import 'package:my_fit_squad/features/base/presentation/widgets/label.dart';
import 'package:my_fit_squad/features/workouts_management/data/model/workout.dart';
import 'package:my_fit_squad/features/workouts_management/presentation/screens/media_screen.dart';
import 'package:my_fit_squad/features/workouts_management/presentation/widgets/app_card.dart';
import 'package:my_fit_squad/gen/assets.gen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:path/path.dart' as p;

class WorkoutDetailsScreen extends StatelessWidget {
  static const routeName = './workout_details';
  final Workout? workout;
  const WorkoutDetailsScreen({super.key, this.workout});

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
                    child: AppNetworkImage(
                  url:
                      '${ApiUrls.baseImageUrl}${ApiUrls.workouts}/${workout?.image ?? ''}',
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
                          workout?.title ?? '',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .inverseSurface,
                                  ),
                        ),
                        Text(
                          "${workout?.category?.title ?? ''} : ${workout?.muscleGroup?.title ?? ''}",
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .inverseSurface,
                                  ),
                        ),
                      ],
                    )),
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
                Label(
                  title: workout?.equipment ?? '__',
                )
              ],
            ),
          ),
          AppCard(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Category && Muscle Group',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(
                  height: 1.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Label(
                          title: workout?.category?.title ?? '',
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Label(
                          title: workout?.muscleGroup?.title ?? '',
                        )
                      ],
                    ),
                    Assets.images.chest.image(height: 30.h)
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
                    workout?.description ?? '',
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
                  'Media',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(
                  height: 1.h,
                ),
                Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 0.2.h, horizontal: 2.w),
                    height: workout?.workoutsMedia != null
                        ? (workout!.workoutsMedia!.length / 3) * 20.h
                        : 0,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(1.w)),
                    child: GridView(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 1.h,
                          mainAxisSpacing: 1.h),
                      children: [
                        if (workout?.workoutsMedia != null)
                          ...workout!.workoutsMedia!.map((e) {
                            final extension = p.extension(e);
                            print(extension);
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    Constants.navigatorKey.currentContext!,
                                    MaterialPageRoute(
                                        builder: (context) => MediaScreen(
                                              title: workout?.title ?? '',
                                              isVideo: extension == '.mp4',
                                              url:
                                                  '${ApiUrls.baseImageUrl}${ApiUrls.workouts}/$e',
                                            )));
                              },
                              child: Hero(
                                  tag: e,
                                  child: AppNetworkImage(
                                    url:
                                        '${ApiUrls.baseImageUrl}${ApiUrls.workouts}/$e',
                                    extention: extension,
                                  )),
                            );
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
