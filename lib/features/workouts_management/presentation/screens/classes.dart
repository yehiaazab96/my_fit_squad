import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_fit_squad/common/injection/injection_container.dart';
import 'package:my_fit_squad/features/base/presentation/widgets/active_shimmer_card.dart';
import 'package:my_fit_squad/features/base/presentation/widgets/column_row.dart';
import 'package:my_fit_squad/features/base/presentation/widgets/list_loading.dart';
import 'package:my_fit_squad/features/workouts_management/presentation/widgets/class_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ClassesScreen extends StatefulWidget {
  const ClassesScreen({super.key});

  @override
  State<ClassesScreen> createState() => _ClassesScreenState();
}

class _ClassesScreenState extends State<ClassesScreen> {
  @override
  void initState() {
    Future.delayed(0.seconds, () {
      ProviderScope.containerOf(context)
          .read(classesViewModelProvider.notifier)
          .getClasses();
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
            var classes = ref.watch(classesViewModelProvider).data.classes;
            var isLoading = ref.watch(classesViewModelProvider).isLoading;
            print(classes);
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
                            children: classes
                                .map((e) => ClassWidget(
                                      cls: e,
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
