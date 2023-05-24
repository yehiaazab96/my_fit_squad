import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_fit_squad/common/constants/colors.dart';
import 'package:my_fit_squad/common/constants/constants.dart';
import 'package:my_fit_squad/features/base/presentation/widgets/active_shimmer_card.dart';
import 'package:my_fit_squad/features/base/presentation/widgets/list_loading.dart';
import 'package:my_fit_squad/features/base/presentation/widgets/row_column.dart';
import 'package:my_fit_squad/features/home/data/helpers/home_screen_type.dart';
import 'package:my_fit_squad/features/home/presentation/view_models/home_base_view_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const routeName = './home';

  @override
  Widget build(BuildContext context) {
    return RowColumn(breakPoint: 800, children: [
      Expanded(
        child: Center(
          child: Column(
            children: [LoadingList(child: MyShimmerCard(), childHeight: 10.h)],
          ),
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
    ]);
  }
}
