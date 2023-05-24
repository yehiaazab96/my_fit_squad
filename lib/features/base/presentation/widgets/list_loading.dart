import 'package:flutter/material.dart';
import 'package:my_fit_squad/common/constants/colors.dart';
import 'package:shimmer/shimmer.dart';

class LoadingList extends StatelessWidget {
  final bool? enabled;
  final Widget child;
  final double childHeight;
  final EdgeInsetsGeometry? padding;
  const LoadingList(
      {this.enabled,
      required this.child,
      required this.childHeight,
      this.padding});

  @override
  Widget build(BuildContext context) {
    var listCount = MediaQuery.of(context).size.height / childHeight;
    return Expanded(
      child: Container(
        padding: padding,
        // color: Colors.white,
        child: Shimmer.fromColors(
            baseColor: Theme.of(context).colorScheme.inversePrimary,
            highlightColor: AppColors
                .black, //Theme.of(context).colorScheme.secondary.withOpacity(.3),
            enabled: enabled ?? false,
            child: ListView.builder(
              itemBuilder: (_, __) => child,
              itemCount: listCount.floor(),
            )),
      ),
    );
  }
}
