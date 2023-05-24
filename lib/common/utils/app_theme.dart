import 'package:my_fit_squad/common/constants/colors.dart';
import 'package:my_fit_squad/gen/fonts.gen.dart';
import 'package:flutter/material.dart';

ThemeData appTheme(BuildContext context) {
  // ScreenUtil().setSp(50);
  ThemeData themeData = ThemeData(
      fontFamily: FontFamily.inter,
      useMaterial3: true,
      canvasColor: AppColors.black,
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.dark,
        seedColor: AppColors.primaryGrey,
        secondary: AppColors.orange,
      ),
      appBarTheme: AppBarTheme(
          color: AppColors.primaryGrey, foregroundColor: AppColors.orange));

  return themeData;
}

ButtonStyle elevatedButtonStyle(BuildContext context,
    {EdgeInsetsDirectional? padding,
    Color? textColor,
    Color? backgroundColor,
    double? borderRadius,
    Color? borderColor,
    double? fontSize,
    FontWeight? fontWeight}) {
  return ButtonStyle(
      padding: MaterialStateProperty.all<EdgeInsetsDirectional>(
          padding ?? const EdgeInsetsDirectional.all(15)),
      foregroundColor:
          MaterialStateProperty.all<Color>(textColor ?? Colors.white),
      backgroundColor: MaterialStateProperty.all<Color>(
          backgroundColor ?? const Color(0xffea6a12)),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 8),
            side: BorderSide(color: borderColor ?? const Color(0xffea6a12))),
      ),
      elevation: MaterialStateProperty.all<double>(0),
      textStyle: MaterialStateProperty.all<TextStyle>(
        TextStyle(
          fontSize: 24.0,
          fontFamily: FontFamily.inter,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ).apply(fontSizeFactor: 1),
      ));
}

ButtonStyle textButtonStyle(
    {EdgeInsetsDirectional? padding,
    Color? textColor,
    double? fontSize,
    FontWeight? fontWeight,
    String? fontFamily,
    TextDecoration? decoration}) {
  return ButtonStyle(
      padding: MaterialStateProperty.all<EdgeInsetsDirectional>(
          padding ?? const EdgeInsetsDirectional.all(10)),
      foregroundColor:
          MaterialStateProperty.all<Color>(textColor ?? Colors.black),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      minimumSize: MaterialStateProperty.all<Size>(Size.zero),
      textStyle: MaterialStateProperty.all<TextStyle>(
        TextStyle(
          fontSize: 24,
          fontFamily: FontFamily.roboto,
          color: Color.fromARGB(192, 6, 8, 89),
        ),
      ));
}

InputDecorationTheme appInputDecorationTheme(BuildContext context) {
  return InputDecorationTheme(
    labelStyle: TextStyle(
        fontSize: 16.0,
        fontFamily: FontFamily.inter,
        fontWeight: FontWeight.w400,
        color: const Color(0xff8a92a6)),
    hintStyle: TextStyle(
        fontSize: 16.0,
        fontFamily: FontFamily.inter,
        fontWeight: FontWeight.w400,
        color: const Color(0xff8a92a6)),
    border: InputBorder.none,
    contentPadding: const EdgeInsetsDirectional.only(
        top: 15, bottom: 15, start: 20, end: 20),
    enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xff3a57e8)),
        borderRadius: BorderRadius.circular(5),
        gapPadding: 7),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Color(0xffea6a12)),
      borderRadius: BorderRadius.circular(5),
      gapPadding: 7,
    ),
    prefixIconColor: const Color(0xffea6a12),
    suffixIconColor: const Color(0xffea6a12),
  );
}
