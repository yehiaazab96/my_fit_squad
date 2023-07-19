import 'package:easy_localization/easy_localization.dart';
import 'package:my_fit_squad/app_init.dart';
import 'package:my_fit_squad/app_route_generator.dart';
import 'package:my_fit_squad/common/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

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
        // initialRoute: RouteScreen.routeName,
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
              settings: settings,
              builder: (_) => AppRouteGenerator.generateRoute(settings));
        },
      );
    });
  }
}
