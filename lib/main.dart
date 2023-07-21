import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:my_fit_squad/app_init.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_fit_squad/common/utils/app_locales.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app.dart';
import 'common/injection/injection_container.dart' as di;

void main() async {
  AppInit().initBeforeAppLaunching();

  runApp(ProviderScope(
    overrides: [
      di.sharedPreferencesProvider
          .overrideWithValue(await SharedPreferences.getInstance())
    ],
    child: EasyLocalization(
        supportedLocales: [...AppLocales.values.map((e) => e.locale).toList()],
        path: 'assets/translations',
        fallbackLocale: AppLocales.english.locale,
        child: MyFitSquad()),
  ));
  WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
    if (Platform.isAndroid) {
      await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
    }
  });
}
