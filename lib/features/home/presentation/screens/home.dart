import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_fit_squad/common/constants/colors.dart';
import 'package:my_fit_squad/common/constants/constants.dart';
import 'package:my_fit_squad/common/injection/injection_container.dart';
import 'package:my_fit_squad/features/base/presentation/widgets/active_shimmer_card.dart';
import 'package:my_fit_squad/features/base/presentation/widgets/list_loading.dart';
import 'package:my_fit_squad/features/base/presentation/widgets/row_column.dart';
import 'package:my_fit_squad/features/home/data/helpers/home_screen_type.dart';
import 'package:my_fit_squad/features/home/presentation/view_models/home_base_view_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const routeName = './home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    return SafeArea(
      child: RowColumn(breakPoint: 800, children: [
        Expanded(
          child: Center(
            child: Consumer(builder: (_, ref, __) {
              var workouts = ref.watch(workoutsViewModelProvider).data.workouts;
              return Column(
                children: workouts.map((e) => Text(e.title ?? '')).toList(),
              );
            }),
          ),
        ),
        Expanded(
            child: Card(
          child: Container(
            margin: const EdgeInsets.all(20),
            color: AppColors.orange,
            height: 200,
            child: Center(
              child: TextButton(
                  onPressed: () {
                    ProviderScope.containerOf(
                            Constants.homeNavigatorKey.currentContext!)
                        .read(homeBaseScreenProvider.notifier)
                        .navigateTo(HomeScreenType.home2);
                  },
                  child: const Text('go to home 2 ')),
            ),
          ),
        )),
      ]),
    );
  }
}
