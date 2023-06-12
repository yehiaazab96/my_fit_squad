import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_fit_squad/common/injection/injection_container.dart';
import 'package:my_fit_squad/features/base/presentation/widgets/active_shimmer_card.dart';
import 'package:my_fit_squad/features/base/presentation/widgets/column_row.dart';
import 'package:my_fit_squad/features/base/presentation/widgets/list_loading.dart';
import 'package:my_fit_squad/features/workouts_management/presentation/widgets/workout_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class WorkoutsScreen extends StatefulWidget {
  const WorkoutsScreen({super.key});

  @override
  State<WorkoutsScreen> createState() => _WorkoutsScreenState();
}

class _WorkoutsScreenState extends State<WorkoutsScreen> {
  @override
  void initState() {
    Future.delayed(0.seconds, () {
      ProviderScope.containerOf(context)
          .read(workoutsViewModelProvider.notifier)
          .getWorkouts();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ColumnRow(
        breakPoint: 800,
        // columnMainAxisAlignment: MainAxisAlignment.start,
        children: [
          Consumer(builder: (_, ref, __) {
            var notifer = ref.watch(categoriesViewModelProvider.notifier);
            var categories =
                ref.watch(categoriesViewModelProvider).data.categories;
            var currentSelectedCategory = ref
                .watch(categoriesViewModelProvider)
                .data
                .currentSelectedCategory;

            return Card(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(children: [
                    GestureDetector(
                      onTap: () {
                        notifer.changeCurrentSelectedCategory(null);
                      },
                      child: Container(
                        height: 5.h,
                        width: 30.w,
                        margin: EdgeInsets.symmetric(horizontal: 2.w),
                        decoration: BoxDecoration(
                          color: currentSelectedCategory != null
                              ? Theme.of(context).colorScheme.inverseSurface
                              : Theme.of(context).colorScheme.inversePrimary,
                          borderRadius: BorderRadius.circular(2.w),
                        ),
                        child: Center(
                          child: Text(
                            'All',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                    color: currentSelectedCategory != null
                                        ? Theme.of(context)
                                            .colorScheme
                                            .onInverseSurface
                                        : Theme.of(context)
                                            .colorScheme
                                            .inverseSurface),
                          ),
                        ),
                      ),
                    ),
                    ...categories
                        .map((e) => GestureDetector(
                              onTap: () {
                                notifer.changeCurrentSelectedCategory(e);
                              },
                              child: Container(
                                height: 5.h,
                                width: 30.w,
                                margin: EdgeInsets.symmetric(horizontal: 2.w),
                                decoration: BoxDecoration(
                                  color: currentSelectedCategory != e
                                      ? Theme.of(context)
                                          .colorScheme
                                          .inverseSurface
                                      : Theme.of(context)
                                          .colorScheme
                                          .inversePrimary,
                                  borderRadius: BorderRadius.circular(2.w),
                                ),
                                child: Center(
                                  child: Text(
                                    e.title,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                            color: currentSelectedCategory != e
                                                ? Theme.of(context)
                                                    .colorScheme
                                                    .onInverseSurface
                                                : Theme.of(context)
                                                    .colorScheme
                                                    .inverseSurface),
                                  ),
                                ),
                              ),
                            ))
                        .toList(),
                  ]),
                ),
              ),
            );
          }),
          Consumer(builder: (_, ref, __) {
            var workouts = ref.watch(workoutsViewModelProvider).data.workouts;
            var isLoading = ref.watch(workoutsViewModelProvider).isLoading;

            return Expanded(
              child: Card(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 1.5.h),
                  child: isLoading
                      ? LoadingList(
                          enabled: true,
                          childHeight: 20.h,
                          child: const MyShimmerCard(),
                        )
                      : SingleChildScrollView(
                          child: Column(
                            children: workouts
                                .map((e) => WorkoutWidget(
                                      workout: e,
                                    ))
                                .toList(),
                          ),
                        ),
                ),
              ),
            );
          }),
        ]);
  }
}
