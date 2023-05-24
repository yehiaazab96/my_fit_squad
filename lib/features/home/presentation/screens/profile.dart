import 'package:flutter/material.dart';
import 'package:my_fit_squad/common/constants/colors.dart';
import 'package:my_fit_squad/features/base/presentation/widgets/active_shimmer_card.dart';
import 'package:my_fit_squad/features/base/presentation/widgets/list_loading.dart';
import 'package:my_fit_squad/features/base/presentation/widgets/row_column.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RowColumn(breakPoint: 800, children: [
        Expanded(
            child: Card(
          child: Container(
            margin: EdgeInsets.all(20),
            color: AppColors.white,
            height: 200,
          ),
        )),
        Expanded(
          child: Center(
            child: Column(
              children: [
                LoadingList(child: MyShimmerCard(), childHeight: 10.h)
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
