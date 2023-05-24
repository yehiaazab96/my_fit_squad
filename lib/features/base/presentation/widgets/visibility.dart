import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class VisibilityWidget extends StatelessWidget {
  final bool? condition;
  final Widget child;
  final double? childWidth;

  const VisibilityWidget(
      {super.key, this.condition = true, required this.child, this.childWidth});

  @override
  Widget build(BuildContext context) {
    return (condition ?? true)
        ? Container(width: childWidth, child: child)
        : Container(
            width: 1.w,
          );
  }
}
