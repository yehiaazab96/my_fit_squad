import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CategoryContainer extends StatelessWidget {
  final BorderRadiusGeometry? borderRadius;
  final Function? onTap;
  final Widget? child;
  const CategoryContainer(
      {super.key, this.borderRadius, this.onTap, this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
      },
      child: Container(
          margin: EdgeInsetsDirectional.fromSTEB(4.w, 1.h, 1.5.w, 1.h),
          height: 10.h,
          width: 42.w,
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.inverseSurface,
              borderRadius: borderRadius ?? BorderRadius.circular(5.w),
              border: Border.all(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  width: 1.w)),
          child: child ?? Container()),
    );
  }
}
