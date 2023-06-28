import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AppCard extends StatelessWidget {
  final Widget? child;
  final EdgeInsets? externalPadding;
  final EdgeInsets? internalPadding;
  final double? height;
  final Color? color;

  const AppCard(
      {super.key,
      this.child,
      this.color,
      this.externalPadding,
      this.internalPadding,
      this.height});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: externalPadding ??
          EdgeInsets.symmetric(vertical: 1.h, horizontal: 1.w),
      child: Card(
        color: color,
        child: Container(
            height: height,
            padding: internalPadding ??
                EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
            width: double.infinity,
            child: child),
      ),
    );
  }
}
