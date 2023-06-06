import 'package:easy_localization/easy_localization.dart';
import 'package:my_fit_squad/app_init.dart';
import 'package:my_fit_squad/common/constants/constants.dart';
import 'package:my_fit_squad/common/utils/app_locales.dart';
import 'package:my_fit_squad/features/base/presentation/screens/base_screen.dart';
import 'package:my_fit_squad/features/user_management/data/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_fit_squad/features/user_management/presentation/screens/login.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import './common/injection/injection_container.dart' as di;

import 'common/utils/app_theme.dart';

// ignore_for_file: use_key_in_widget_constructors
class MyFitSquad extends StatefulWidget {
  @override
  _MyFitSquadAppState createState() {
    return _MyFitSquadAppState();
  }
}

class _MyFitSquadAppState extends State<MyFitSquad> {
  // final _userDataProvider = StreamProvider.autoDispose<User?>((ref) {
  //   return Stream.fromFuture(
  //       ref.read(di.userProvider.notifier).getLocalUserProfile());
  // });

  @override
  void initState() {
    super.initState();
    AppInit().initAfterAppLaunching();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return MaterialApp(
          locale: context.locale,
          supportedLocales: context.supportedLocales,
          localizationsDelegates: context.localizationDelegates,
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.dark,
          theme: appTheme(context),
          navigatorKey: Constants.navigatorKey,
          home: Consumer(
            builder: (_, ref, __) {
              User? user = ref.watch(di.userProvider);
              return (user != null && user.accessToken != null)
                  ? const BaseScreen()
                  : LoginScreen();
            },
          ));
    });
  }
}
