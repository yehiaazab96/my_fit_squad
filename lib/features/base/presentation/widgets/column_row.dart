import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ColumnRow extends StatelessWidget {
  final List<Widget> children;
  final double breakPoint;
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;
  final MainAxisAlignment? rowMainAxisAlignment;
  final CrossAxisAlignment? rowCrossAxisAlignment;
  const ColumnRow(
      {super.key,
      required this.children,
      required this.breakPoint,
      this.crossAxisAlignment,
      this.mainAxisAlignment,
      this.rowCrossAxisAlignment,
      this.rowMainAxisAlignment});

  @override
  Widget build(BuildContext context) {
    return Device.width < (breakPoint)
        ? Column(
            mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
            crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
            children: children,
          )
        : Row(
            mainAxisAlignment: rowMainAxisAlignment ?? MainAxisAlignment.start,
            crossAxisAlignment:
                rowCrossAxisAlignment ?? CrossAxisAlignment.center,
            children: children,
          );
  }
}
