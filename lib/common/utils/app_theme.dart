import 'package:google_fonts/google_fonts.dart';
import 'package:my_fit_squad/common/constants/colors.dart';
import 'package:my_fit_squad/gen/fonts.gen.dart';
import 'package:flutter/material.dart';

ThemeData appTheme(BuildContext context) {
  // ScreenUtil().setSp(50);
  ThemeData themeData = ThemeData(
      // fontFamily: FontFamily.roboto,
      useMaterial3: true,
      canvasColor: AppColors.black,
      colorScheme: colorScheme,
      // primaryTextTheme: ,
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
          color: AppColors.primaryGrey, foregroundColor: AppColors.orange));

  return themeData;
}

ColorScheme colorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: AppColors.primaryGrey,
  secondary: AppColors.orange,
);

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

InputDecorationTheme appInputDecorationTheme(BuildContext context) {
  return InputDecorationTheme(
    // border: InputBorder.none,
    contentPadding: const EdgeInsetsDirectional.only(
        top: 15, bottom: 15, start: 20, end: 20),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5), gapPadding: 7),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.orange),
      borderRadius: BorderRadius.circular(5),
      gapPadding: 7,
    ),
    prefixIconColor: AppColors.orange,
    suffixIconColor: AppColors.orange,
  );
}

final textTheme = TextTheme(
  displayLarge: GoogleFonts.roboto(
    fontWeight: FontWeight.w400,
    fontSize: 57,
    height: 64 / 57,
    letterSpacing: -0.25,
  ),
  displayMedium: GoogleFonts.roboto(
    fontWeight: FontWeight.w400,
    fontSize: 45,
    height: 52 / 45,
  ),
  displaySmall: GoogleFonts.roboto(
    fontWeight: FontWeight.w400,
    fontSize: 36,
    height: 44 / 36,
  ),
  headlineLarge: GoogleFonts.roboto(
    fontWeight: FontWeight.w400,
    fontSize: 32,
    height: 40 / 32,
  ),
  headlineMedium: GoogleFonts.roboto(
    fontWeight: FontWeight.w400,
    fontSize: 28,
    height: 36 / 28,
  ),
  headlineSmall: GoogleFonts.roboto(
    fontWeight: FontWeight.w400,
    fontSize: 24,
    height: 32 / 24,
  ),
  titleLarge: GoogleFonts.roboto(
    fontWeight: FontWeight.w700,
    fontSize: 22,
    height: 28 / 22,
  ),
  titleMedium: GoogleFonts.roboto(
    fontWeight: FontWeight.w600,
    fontSize: 16,
    height: 24 / 16,
    letterSpacing: 0.1,
  ),
  titleSmall: GoogleFonts.roboto(
    fontWeight: FontWeight.w600,
    fontSize: 14,
    height: 20 / 14,
    letterSpacing: 0.1,
  ),
  labelLarge: GoogleFonts.inter(
    fontWeight: FontWeight.w700,
    fontSize: 14,
    height: 20 / 14,
  ),
  labelMedium: GoogleFonts.inter(
    fontWeight: FontWeight.w700,
    fontSize: 12,
    height: 16 / 12,
  ),
  labelSmall: GoogleFonts.inter(
    fontWeight: FontWeight.w700,
    fontSize: 11,
    height: 16 / 11,
  ),
  bodyLarge: GoogleFonts.inter(
    fontWeight: FontWeight.w400,
    fontSize: 16,
    height: 24 / 16,
  ),
  bodyMedium: GoogleFonts.inter(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    height: 20 / 14,
  ),
  bodySmall: GoogleFonts.inter(
    fontWeight: FontWeight.w400,
    fontSize: 12,
    height: 16 / 12,
  ),
);
