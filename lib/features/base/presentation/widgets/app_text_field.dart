import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? hint;
  final String? label;
  final Widget? prefix;
  final Widget? suffix;
  final bool isSecured;
  final int? maxLines;
  final bool isReadOnly;
  final TextInputType? inputType;
  final EdgeInsetsDirectional margin;
  final EdgeInsetsDirectional? contentPadding;
  final Function? onTap;
  final String? errorText;
  final Function(String)? onChanged;

  const AppTextField({
    Key? key,
    required this.controller,
    this.hint,
    this.label,
    this.prefix,
    this.maxLines,
    this.suffix,
    this.onChanged,
    this.isSecured = false,
    this.isReadOnly = false,
    this.inputType = TextInputType.text,
    this.margin = EdgeInsetsDirectional.zero,
    this.contentPadding,
    this.onTap,
    this.errorText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            // enableInteractiveSelection: false,
            onTap: () {
              if (onTap != null) {
                onTap!();
              }
            },
            controller: controller,
            keyboardType: inputType,
            readOnly: isReadOnly,
            onChanged: onChanged,
            maxLines: maxLines ?? 1,
            decoration: InputDecoration(
              labelText: label,
              hintText: hint,
              prefixIcon: prefix,
              suffixIcon: suffix,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              contentPadding: contentPadding ??
                  const EdgeInsetsDirectional.only(
                      top: 15, bottom: 15, start: 30, end: 30),
              labelStyle: Theme.of(context).textTheme.labelLarge,
              hintStyle: Theme.of(context).textTheme.labelLarge,
              border: InputBorder.none,
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.outlineVariant),
                  borderRadius: BorderRadius.circular(2.w),
                  gapPadding: 7),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).colorScheme.secondary),
                borderRadius: BorderRadius.circular(2.w),
                gapPadding: 7,
              ),
              errorBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).colorScheme.error),
                borderRadius: BorderRadius.circular(2.w),
                gapPadding: 7,
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).colorScheme.error),
                borderRadius: BorderRadius.circular(2.w),
                gapPadding: 7,
              ),
              errorText: errorText,
              errorStyle: const TextStyle(fontSize: 0, letterSpacing: 0),
              prefixIconColor: Theme.of(context).colorScheme.secondary,
              suffixIconColor: Theme.of(context).colorScheme.secondary,
            ),
            obscureText: isSecured,
            cursorColor: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }
}
