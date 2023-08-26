import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:my_fit_squad/common/extensions/widget_extensions.dart';
import 'package:my_fit_squad/features/workouts_management/data/model/class.dart';
import 'package:my_fit_squad/features/workouts_management/presentation/screens/workout_details_screen.dart';
import 'package:my_fit_squad/features/workouts_management/presentation/widgets/app_card.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ActiveClassWidget extends StatefulWidget {
  final Class activeClass;

  const ActiveClassWidget({super.key, required this.activeClass});

  @override
  State<ActiveClassWidget> createState() => _ActiveClassWidgetState();
}

class _ActiveClassWidgetState extends State<ActiveClassWidget> {
  int currentWorkout = 0;
  int currentStep = 0;
  bool inRestTime = false;
  int restTime = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          return Future.value(true);
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: (widget.activeClass.classWorkouts ?? [])
                      .map((e) => SizedBox(
                          width: 70.w,
                          height: 15.h,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                      child: AppCard(
                                          child: Text(e.workout?.title ?? ''))),
                                  if (((widget.activeClass.classWorkouts
                                                  ?.indexOf(e) ??
                                              0) +
                                          1) !=
                                      (widget
                                          .activeClass.classWorkouts?.length))
                                    Icon(Icons.navigate_next_sharp)
                                ],
                              ),
                              SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: List.generate(
                                        e.repeat ?? 0,
                                        (index) => CircleAvatar(
                                              backgroundColor: (widget
                                                              .activeClass
                                                              .classWorkouts
                                                              ?.indexOf(e) ==
                                                          currentWorkout &&
                                                      index == currentStep)
                                                  ? Theme.of(context)
                                                      .colorScheme
                                                      .secondary
                                                  : null,
                                              child:
                                                  Text((index + 1).toString()),
                                            ).paddingHorizontal(1.w)),
                                  )).paddingHorizontal(2.w)
                            ],
                          )))
                      .toList(),
                ),
              ),
              SizedBox(
                width: 40.w,
                child: inRestTime
                    ? Stack(
                        children: [
                          SpinKitFadingCircle(
                            color: Theme.of(context).colorScheme.secondary,
                            size: 20.w,
                          ),
                          Center(
                              child: Text(
                            restTime.toString(),
                            style: Theme.of(context).textTheme.titleLarge,
                          )).paddingTop(6.5.w)
                        ],
                      )
                    : ElevatedButton.icon(
                        onPressed: () {
                          setState(() {
                            restTime = widget.activeClass
                                    .classWorkouts?[currentWorkout].restTime ??
                                0;
                            inRestTime = true;

                            Future.delayed(restTime.seconds, () {
                              inRestTime = false;
                              if (checkCurrentWorkoutLength()) {
                                if (checkCurrentStep()) {
                                  if (checkIfNotLastWorkout()) {
                                    currentStep = 0;
                                    currentWorkout++;
                                  }
                                } else {
                                  if (checkIfNotLastWorkoutAndLastStep()) {
                                    currentStep++;
                                  }
                                }
                              }
                            });
                          });
                          Timer.periodic(1.seconds, (Timer t) {
                            setState(() {
                              if (restTime > 0) {
                                restTime--;
                              } else {
                                t.cancel();
                              }
                            });
                          });
                        },
                        icon: Icon(Icons.navigate_next_rounded),
                        label: Text('Next Set')),
              ).paddingVertical(2.h),
              WorkoutDetailsScreen(
                workout:
                    widget.activeClass.classWorkouts?[currentWorkout].workout,
              )
            ],
          ),
        ));
  }

  bool checkCurrentStep() {
    return (currentStep + 1) ==
        (widget.activeClass.classWorkouts?[currentWorkout].repeat ?? 0);
  }

  bool checkCurrentWorkoutLength() {
    return ((currentWorkout + 1) <=
        (widget.activeClass.classWorkouts?.length ?? 0));
  }

  bool checkIfNotLastWorkout() {
    return ((currentWorkout + 1) !=
        (widget.activeClass.classWorkouts?.length ?? 0));
  }

  bool checkIfNotLastWorkoutAndLastStep() {
    return ((currentWorkout + 1) !=
            (widget.activeClass.classWorkouts?.length ?? 0) ||
        (currentStep + 1) !=
            (widget.activeClass.classWorkouts?[currentWorkout].repeat ?? 0));
  }
}
