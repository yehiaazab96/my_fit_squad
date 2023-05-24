import 'package:easy_localization/easy_localization.dart';
import 'package:my_fit_squad/app_init.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
        supportedLocales: const [Locale('en'), Locale('ar')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        child: MyFitSquad()),
  ));
}
