import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_fit_squad/common/constants/colors.dart';
import 'package:my_fit_squad/features/base/presentation/widgets/active_shimmer_card.dart';
import 'package:my_fit_squad/features/base/presentation/widgets/list_loading.dart';
import 'package:my_fit_squad/features/base/presentation/widgets/row_column.dart';
import 'package:my_fit_squad/features/home/presentation/view_models/home_base_view_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Home2Screen extends StatelessWidget {
  const Home2Screen({super.key});
  static const routeName = './home2Screen';

  @override
  Widget build(BuildContext context) {
    return RowColumn(breakPoint: 800, children: [
      Expanded(
          child: Card(
        child: Container(
          margin: EdgeInsets.all(20),
          color: AppColors.grey,
          height: 200,
          child: Center(
            child: TextButton(
                onPressed: () {
                  ProviderScope.containerOf(context)
                      .read(homeBaseScreenProvider.notifier)
                      .pop();
                },
                child: Text('pop to home  ')),
          ),
        ),
      )),
      Expanded(
        child: Center(
          child: Column(
            children: [LoadingList(child: MyShimmerCard(), childHeight: 10.h)],
          ),
        ),
      ),
    ]);
  }
}
