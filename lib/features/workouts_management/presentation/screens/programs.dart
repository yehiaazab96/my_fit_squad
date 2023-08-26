import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_fit_squad/common/injection/injection_container.dart';
import 'package:my_fit_squad/features/base/presentation/screens/screen_handler.dart';
import 'package:my_fit_squad/features/base/presentation/widgets/active_shimmer_card.dart';
import 'package:my_fit_squad/features/base/presentation/widgets/column_row.dart';
import 'package:my_fit_squad/features/base/presentation/widgets/list_loading.dart';
import 'package:my_fit_squad/features/workouts_management/presentation/widgets/program_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ProgramsScreen extends StatefulWidget {
  const ProgramsScreen({super.key});

  @override
  State<ProgramsScreen> createState() => _ProgramsScreenState();
}

class _ProgramsScreenState extends State<ProgramsScreen> {
  @override
  void initState() {
    fetchPrograms();
    super.initState();
  }

  void fetchPrograms() {
    Future.delayed(0.seconds, () {
      ProviderScope.containerOf(context)
          .read(programsViewModelProvider.notifier)
          .getPrograms();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ColumnRow(
            breakPoint: 800,
            // columnMainAxisAlignment: MainAxisAlignment.start,
            children: [
              Consumer(builder: (_, ref, __) {
                var programs =
                    ref.watch(programsViewModelProvider).data.programs;
                var isLoading = ref.watch(programsViewModelProvider).isLoading;
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
                          : RefreshIndicator(
                              onRefresh: () {
                                fetchPrograms();
                                return Future.delayed(1.seconds);
                              },
                              child: ListView(
                                children: programs
                                    .map((e) => ProgramWidget(
                                          program: e,
                                        ))
                                    .toList(),
                              ),
                            ),
                    ),
                  ),
                );
              }),
            ]),
        ScreenHandler(
            showLoading: false, screenProvider: programsViewModelProvider)
      ],
    );
  }
}
