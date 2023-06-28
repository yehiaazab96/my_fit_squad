import 'package:my_fit_squad/features/base/presentation/screens/base_screen.dart';
import 'package:my_fit_squad/features/user_management/data/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_fit_squad/features/user_management/presentation/screens/login.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import './common/injection/injection_container.dart' as di;

class RouteScreen extends StatelessWidget {
  static const routeName = './route_screen';
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return Consumer(
        builder: (_, ref, __) {
          User? user = ref.watch(di.userProvider);
          return (user != null && user.accessToken != null)
              ? const BaseScreen()
              : LoginScreen();
        },
      );
    });
  }
}
