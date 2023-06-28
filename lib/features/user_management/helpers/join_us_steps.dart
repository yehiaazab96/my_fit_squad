import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_fit_squad/features/base/data/helpers/base_state.dart';
import 'package:my_fit_squad/features/user_management/presentation/global_states/login_state.dart';
import 'package:my_fit_squad/features/user_management/presentation/screens/client_coach_code.dart';
import 'package:my_fit_squad/features/user_management/presentation/screens/coach_package_sceen.dart';
import 'package:my_fit_squad/features/user_management/presentation/screens/join_us_credintials.dart';
import 'package:my_fit_squad/features/user_management/presentation/screens/join_us_info.dart';
import 'package:my_fit_squad/features/user_management/presentation/screens/uset_type_screen.dart';
import 'package:my_fit_squad/features/user_management/presentation/view_models/join_us_view_model.dart';

enum JoinUsSteps {
  userType,
  credentials,
  info,
  clientCoachCode,
  coachPackage;

  String get title {
    switch (this) {
      case userType:
        return "choosePath".tr();

      case credentials:
        return "credintials".tr();

      case info:
        return "info".tr();

      case clientCoachCode:
        return "clientCoachCode".tr();

      case coachPackage:
        return "coachPackage".tr();
      default:
        return '';
    }
  }

  Widget screen(
      {required StateNotifierProvider<JoinUsViewModel, BaseState<SignUpState>>
          provider}) {
    switch (this) {
      case userType:
        return UserTypeScreen(
          provider: provider,
        );

      case credentials:
        return JoinUsCredintials(
          provider: provider,
        );

      case info:
        return JoinUsInfo(
          provider: provider,
        );
      case clientCoachCode:
        return ClientCoachCode(
          provider: provider,
        );

      case coachPackage:
        return CoachPackageScreen(
          provider: provider,
        );

      default:
        return const Placeholder();
    }
  }
}
