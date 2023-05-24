import 'package:flutter/material.dart';

enum AppLocales {
  english,
  arabic
}

extension AppLocalesExtension on AppLocales {
  String get code {
    switch (this) {
      case AppLocales.english:
        return 'en';
      case AppLocales.arabic:
        return 'ar';
      default:
        return 'en';
    }
  }

  Locale get locale {
    return Locale(code);
  }
}