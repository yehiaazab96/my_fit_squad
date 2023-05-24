import 'package:flutter/material.dart';
import 'package:my_fit_squad/common/constants/colors.dart';
import 'package:my_fit_squad/features/base/presentation/widgets/active_shimmer_card.dart';
import 'package:my_fit_squad/features/base/presentation/widgets/list_loading.dart';
import 'package:my_fit_squad/features/base/presentation/widgets/row_column.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Place2Screen extends StatelessWidget {
  const Place2Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RowColumn(breakPoint: 800, children: [
        Expanded(
          child: Center(
            child: Column(
              children: [
                LoadingList(child: MyShimmerCard(), childHeight: 10.h)
              ],
            ),
          ),
        ),
        Expanded(
            child: Card(
          child: Container(
            margin: EdgeInsets.all(20),
            color: AppColors.primaryGrey,
            height: 200,
          ),
        )),
      ]),
    );
  }
}
