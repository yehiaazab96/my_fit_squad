import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_fit_squad/common/injection/user_injection_container.dart';
import 'package:my_fit_squad/features/base/data/helpers/base_state.dart';
import 'package:my_fit_squad/features/base/presentation/screens/screen_handler.dart';
import 'package:my_fit_squad/features/user_management/presentation/global_states/login_state.dart';
import 'package:my_fit_squad/features/user_management/presentation/view_models/join_us_view_model.dart';
import 'package:my_fit_squad/gen/assets.gen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class JoinUs extends StatefulWidget {
  const JoinUs({super.key});
  static const routeName = 'join_us_screen';

  @override
  State<JoinUs> createState() => _JoinUsState();
}

class _JoinUsState extends State<JoinUs> with SingleTickerProviderStateMixin {
  final _joinUsVieModelProvider =
      StateNotifierProvider<JoinUsViewModel, BaseState<SignUpState>>((ref) {
    return JoinUsViewModel(
      ref.read(userRepositoryProvider),
    );
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Assets.images.loginBg
              .image(width: 100.w, height: 100.h, fit: BoxFit.cover),
          Container(
            width: 100.w,
            height: 100.h,
            color: Theme.of(context).colorScheme.background.withOpacity(.5),
          ),
          SafeArea(
            minimum: EdgeInsets.symmetric(horizontal: 2.w),
            child: Consumer(
              builder: (_, ref, __) {
                var currentStep =
                    ref.watch(_joinUsVieModelProvider).data.currentStep;
                return currentStep.screen(provider: _joinUsVieModelProvider);
              },
            ),
          ),
          ScreenHandler(screenProvider: _joinUsVieModelProvider),
        ],
      ),
    );
  }
}
