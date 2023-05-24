import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class RowColumn extends StatelessWidget {
  final List<Widget> children;
  final double breakPoint;
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;
  final MainAxisAlignment? columnMainAxisAlignment;
  final CrossAxisAlignment? columnCrossAxisAlignment;
  const RowColumn(
      {super.key,
      required this.children,
      required this.breakPoint,
      this.columnCrossAxisAlignment,
      this.columnMainAxisAlignment,
      this.crossAxisAlignment,
      this.mainAxisAlignment});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Device.width < (breakPoint)
          ? Row(
              mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
              crossAxisAlignment:
                  crossAxisAlignment ?? CrossAxisAlignment.center,
              children: children,
            )
          : Column(
              mainAxisAlignment:
                  columnMainAxisAlignment ?? MainAxisAlignment.start,
              crossAxisAlignment:
                  columnCrossAxisAlignment ?? CrossAxisAlignment.center,
              children: children,
            ),
    );
  }
}
