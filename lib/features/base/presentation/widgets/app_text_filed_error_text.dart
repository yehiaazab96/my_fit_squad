import 'package:flutter/material.dart';

class AppTextFieldErrorText extends StatelessWidget {
  final String? errorText;
  const AppTextFieldErrorText({Key? key, this.errorText}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      // margin: EdgeInsets.symmetric(horizontal: 15.w),
      padding: EdgeInsets.all(5),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Theme.of(context).highlightColor,
          border: Border.all(
            color: Colors.transparent,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(8))),
      child: Text(
        errorText ?? "",
        style: Theme.of(context).textTheme.headline5,
      ),
    );
  }
}
