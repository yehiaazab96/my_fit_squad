import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ShimmerText extends StatelessWidget {
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? margin;
  const ShimmerText({Key? key, this.height, this.width, this.margin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.symmetric(vertical: 1.h),
      child: Container(
        height: height ?? 3.h,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(1.w),
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
      ),
    );
  }
}
