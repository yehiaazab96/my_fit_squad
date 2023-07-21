import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_fit_squad/common/extensions/widget_extensions.dart';
import 'package:my_fit_squad/common/injection/injection_container.dart';
import 'package:my_fit_squad/features/workouts_management/data/model/program_class.dart';
import 'package:my_fit_squad/features/workouts_management/helpers/entities/program_details_args.dart';
import 'package:my_fit_squad/features/workouts_management/helpers/workout_screen_type.dart';
import 'package:my_fit_squad/features/workouts_management/presentation/screens/class_details_screen.dart';
import 'package:my_fit_squad/features/workouts_management/presentation/screens/class_details_widget.dart';
import 'package:my_fit_squad/gen/assets.gen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ProgramDetailsScreen extends StatefulWidget {
  static const routeName = './program_details';
  final ProgramDetailsArgs? programArgs;

  const ProgramDetailsScreen({super.key, this.programArgs});

  @override
  State<ProgramDetailsScreen> createState() => _ProgramDetailsScreenState();
}

class _ProgramDetailsScreenState extends State<ProgramDetailsScreen> {
  ProgramClass? currentClass;
  DateTime startDate = DateTime.now();
  DateTime selectedData = DateTime.now();

  DateTime? endDate;

  @override
  void initState() {
    if (widget.programArgs?.startDateString != null) {
      startDate =
          DateFormat('dd/MM/yyyy').parse(widget.programArgs!.startDateString!);
      selectedData = startDate;
    }
    if (widget.programArgs?.startDate != null) {
      startDate = widget.programArgs!.startDate!;
      selectedData = startDate;
    }
    currentClass = widget.programArgs?.program?.classes?.first;
    if (widget.programArgs?.program?.duration != null) {
      endDate =
          startDate.add((widget.programArgs!.program!.duration! - 1).days);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: WillPopScope(
        onWillPop: () {
          return Future.value(ProviderScope.containerOf(context)
              .read(workoutScreenViewModelProvider.notifier)
              .pop(type: WorkoutScreenType.programs));
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20.h,
                child: Stack(
                  children: [
                    Positioned.fill(
                        child: Center(
                      child: Assets.images.logo
                          .image()
                          .animate()
                          .flipH(duration: 2.seconds, begin: 0, end: 10),
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
                              widget.programArgs?.program?.title ?? '',
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
                              "${widget.programArgs?.program?.classes?.length} Classes",
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
                        ))
                  ],
                ),
              ),
              CalendarTimeline(
                initialDate: selectedData,
                firstDate: DateTime.now().subtract(700.days),
                lastDate: endDate ?? DateTime.now().add(700.days),
                onDateSelected: (date) {
                  setState(() {
                    selectedData = date;
                    currentClass =
                        widget.programArgs?.program?.classes?.firstWhere(
                      (element) {
                        return startDate.add((element.day! - 1).days).day ==
                            date.day;
                      },
                      orElse: () => ProgramClass(),
                    );
                  });
                },
                monthColor: Theme.of(context).colorScheme.inverseSurface,
                dayColor: Theme.of(context).colorScheme.outlineVariant,
                activeDayColor: Theme.of(context).colorScheme.inverseSurface,
                activeBackgroundDayColor:
                    Theme.of(context).colorScheme.secondary,
                dotsColor: Theme.of(context).colorScheme.surface,

                // selectableDayPredicate: (date) => date.day != 23,
                locale: 'en_ISO',
              ).paddingHorizontal(1.w).paddingVertical(3.h),
              if (currentClass != null && currentClass!.cls != null)
                ClassDetailsWidget(
                  cls: currentClass?.cls,
                )
            ],
          ),
        ),
      ),
    );
  }
}
