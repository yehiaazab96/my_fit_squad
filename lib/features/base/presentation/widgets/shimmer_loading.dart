import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoading extends StatelessWidget {
  final bool? enabled;
  final Widget child;
  final int childHeight;
  final EdgeInsetsGeometry? padding;
  ShimmerLoading(
      {this.enabled,
      required this.child,
      required this.childHeight,
      this.padding});

  @override
  Widget build(BuildContext context) {
    // var listCount = MediaQuery.of(context).size.height / childHeight;
    return Container(
      padding: padding,
      // width: MediaQuery.of(context).size.width,
      // height: MediaQuery.of(context).size.height,
      // color: Colors.white,
      child: Shimmer.fromColors(
          baseColor: const Color(0xffE9E9EA),
          highlightColor: const Color(
              0xffE9E9EA), //Theme.of(context).colorScheme.secondary.withOpacity(.3),
          enabled: enabled ?? false,
          child: child),
    );
  }
}
