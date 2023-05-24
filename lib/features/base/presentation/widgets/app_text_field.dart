import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? hint;
  final String? label;
  final Widget? prefix;
  final Widget? suffix;
  final bool isSecured;
  final bool isReadOnly;
  final TextInputType? inputType;
  final EdgeInsetsDirectional margin;
  final EdgeInsetsDirectional? contentPadding;
  final Function? onTap;
  final String? errorText;

  const AppTextField({
    Key? key,
    required this.controller,
    this.hint,
    this.label,
    this.prefix,
    this.suffix,
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
            decoration: InputDecoration(
              labelText: label,
              hintText: hint,
              prefixIcon: prefix,
              suffixIcon: suffix,
              contentPadding: contentPadding ??
                  const EdgeInsetsDirectional.only(
                      top: 15, bottom: 15, start: 30, end: 30),
              labelStyle: Theme.of(context).textTheme.subtitle2,
              hintStyle: Theme.of(context).textTheme.subtitle2?.copyWith( color: Theme.of(context).hintColor,),
              border: InputBorder.none,
              enabledBorder: OutlineInputBorder(
                  borderSide:  BorderSide(color: Theme.of(context).focusColor),
                  borderRadius: BorderRadius.circular(0),
                  gapPadding: 7),
              focusedBorder: OutlineInputBorder(
                borderSide:  BorderSide(color: Theme.of(context).focusColor),
                borderRadius: BorderRadius.circular(0),
                gapPadding: 7,
              ),
              errorBorder: OutlineInputBorder(
                borderSide:  BorderSide(color:Theme.of(context).errorColor),
                borderRadius: BorderRadius.circular(0),
                gapPadding: 7,
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide:  BorderSide(color:Theme.of(context).errorColor),
                borderRadius: BorderRadius.circular(0),
                gapPadding: 7,
              ),
              errorText:errorText ,
              errorStyle: const TextStyle(fontSize: 0, letterSpacing: 0),
              prefixIconColor: Theme.of(context).primaryColor,
              suffixIconColor: Theme.of(context).primaryColor,
            ),
            obscureText: isSecured,
          cursorColor: Theme.of(context).primaryColor,
          ),
        ],
      ),
      margin: margin,
    );
  }
}
