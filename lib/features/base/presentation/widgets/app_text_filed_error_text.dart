import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AppTextFieldErrorText extends StatelessWidget {
  final String? errorText;
  const AppTextFieldErrorText({Key? key, this.errorText}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.2.h),
      padding: EdgeInsets.symmetric(vertical: 0.4.h),
      // width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.errorContainer.withOpacity(0.8),
          border: Border.all(
            color: Colors.transparent,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(8))),
      child: Text(
        errorText ?? "",
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.error,
            ),
      ),
    );
  }
}
