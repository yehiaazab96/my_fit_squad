import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Label extends StatelessWidget {
  final String? title;
  const Label({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 0.2.h, horizontal: 2.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(1.w),
          color: Theme.of(context).colorScheme.secondaryContainer),
      child: Text(
        title ?? '',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}
