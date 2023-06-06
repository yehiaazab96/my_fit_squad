import 'package:easy_localization/easy_localization.dart';
import 'package:my_fit_squad/common/constants/constants.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import './common/injection/injection_container.dart' as di;

class AppInit {
  static final AppInit _appInit = AppInit._internal();

  factory AppInit() {
    return _appInit;
  }

  AppInit._internal();

  Future initBeforeAppLaunching() async {
    WidgetsFlutterBinding.ensureInitialized();
    await EasyLocalization.ensureInitialized();
  }

  void initAfterAppLaunching() {
    Future.delayed(const Duration(milliseconds: 500), () {
      ProviderScope.containerOf(Constants.navigatorKey.currentContext!)
          .read(di.isConnectedProvider.notifier)
          .listenToNetworkChanges();
    });
  }
}
