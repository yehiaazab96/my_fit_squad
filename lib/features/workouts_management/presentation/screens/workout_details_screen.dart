import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_fit_squad/common/constants/constants.dart';
import 'package:my_fit_squad/common/injection/injection_container.dart';
import 'package:my_fit_squad/features/base/data/helpers/base_state.dart';
import 'package:my_fit_squad/features/base/presentation/widgets/app_network_image.dart';
import 'package:my_fit_squad/features/base/presentation/widgets/label.dart';
import 'package:my_fit_squad/features/workouts_management/data/model/workout.dart';
import 'package:my_fit_squad/features/workouts_management/helpers/workout_screen_type.dart';
import 'package:my_fit_squad/features/workouts_management/presentation/global_states/add_workout_state.dart';
import 'package:my_fit_squad/features/workouts_management/presentation/screens/media_screen.dart';
import 'package:my_fit_squad/features/workouts_management/presentation/view_models/add_workout_view_model.dart';
import 'package:my_fit_squad/features/workouts_management/presentation/widgets/app_card.dart';
import 'package:my_fit_squad/gen/assets.gen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:path/path.dart' as p;

class WorkoutDetailsScreen extends StatefulWidget {
  static const routeName = './workout_details';
  final Workout? workout;
  const WorkoutDetailsScreen({super.key, this.workout});

  @override
  State<WorkoutDetailsScreen> createState() => _WorkoutDetailsScreenState();
}

class _WorkoutDetailsScreenState extends State<WorkoutDetailsScreen> {
  XFile? _imageFile;
  // ImageProvider? _workoutImage;
  final _vieModelProvider =
      StateNotifierProvider<AddWorkoutViewModel, BaseState<AddWorkoutState>>(
          (ref) {
    return AddWorkoutViewModel(
      ref.read(workoutsRepositoryProvider),
    );
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: WillPopScope(
        onWillPop: () {
          return Future.value(ProviderScope.containerOf(context)
              .read(workoutScreenViewModelProvider.notifier)
              .pop(type: WorkoutScreenType.workouts));
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20.h,
                child: Stack(
                  children: [
                    Positioned.fill(
                        child: AppNetworkImage(
                      hasToken: true,
                      url: widget.workout?.image ?? '',
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
                              widget.workout?.title ?? '',
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
                              "${widget.workout?.category?.title ?? ''} : ${widget.workout?.muscleGroup?.title ?? ''}",
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
                      title: widget.workout?.equipment ?? '__',
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
                              title: widget.workout?.category?.title ?? '',
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Label(
                              title: widget.workout?.muscleGroup?.title ?? '',
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
                      padding: EdgeInsets.symmetric(
                          vertical: 0.2.h, horizontal: 2.w),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(1.w),
                          color:
                              Theme.of(context).colorScheme.secondaryContainer),
                      child: Text(
                        widget.workout?.description ?? '',
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
                    Row(
                      children: [
                        Text(
                          'Media',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Spacer(),
                        TextButton.icon(
                            onPressed: () async {
                              final ImagePicker picker = ImagePicker();
                              final XFile? image = await picker.pickMedia();
                              final bytes = await image?.readAsBytes();
                              if (bytes != null) {
                                setState(() {
                                  _imageFile = image;
                                });
                              }
                              if (_imageFile != null) {
                                String? data =
                                    await ProviderScope.containerOf(context)
                                        .read(_vieModelProvider.notifier)
                                        .updateWorkoutWithMedia(
                                            id: widget.workout?.id ?? '',
                                            files: [_imageFile!]);
                                if (data != null) {
                                  setState(() {
                                    widget.workout?.workoutsMedia?.add(data);
                                  });
                                }
                              }
                            },
                            icon: Icon(Icons.add),
                            label: Text(''))
                      ],
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 0.2.h, horizontal: 2.w),
                        height: widget.workout?.workoutsMedia != null
                            ? min(
                                (widget.workout!.workoutsMedia!.length / 3) *
                                    30.h,
                                40.h)
                            : 0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(1.w)),
                        child: GridView(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 1.h,
                                  mainAxisSpacing: 1.h),
                          children: [
                            if (widget.workout?.workoutsMedia != null)
                              ...widget.workout!.workoutsMedia!.map((e) {
                                const startIndex = 0;
                                final endIndex =
                                    e.indexOf('?GoogleAccessId', 0);

                                var url = e.substring(startIndex + 0,
                                    endIndex); // brown fox jumps

                                final extension = p.extension(url);
                                print(extension);
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        Constants.navigatorKey.currentContext!,
                                        MaterialPageRoute(
                                            builder: (context) => MediaScreen(
                                                  title:
                                                      widget.workout?.title ??
                                                          '',
                                                  isVideo:
                                                      (extension == '.mp4' ||
                                                          extension == '.mov'),
                                                  url: e,
                                                )));
                                  },
                                  child: Hero(
                                      tag: e,
                                      child: AppNetworkImage(
                                        url: e,
                                        hasToken: true,
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
        ),
      ),
    );
  }
}
