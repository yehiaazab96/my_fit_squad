import 'package:flutter/material.dart';
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
    // var listCount = 100.h / childHeight;
    return Container(
      padding: padding,
      height: childHeight,
      // color: Colors.white,
      child: Shimmer.fromColors(
          baseColor: Theme.of(context).colorScheme.inversePrimary,
          highlightColor: Theme.of(context)
              .colorScheme
              .inverseSurface, //Theme.of(context).colorScheme.secondary.withOpacity(.3),
          enabled: enabled ?? false,
          child: ListView.builder(
            itemBuilder: (_, __) => child,
            // itemCount: listCount.floor(),
          )),
    );
  }
}
