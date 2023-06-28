import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_fit_squad/common/extensions/widget_extensions.dart';
import 'package:my_fit_squad/features/base/data/helpers/base_state.dart';
import 'package:my_fit_squad/features/user_management/helpers/join_us_steps.dart';
import 'package:my_fit_squad/features/user_management/helpers/user_type.dart';
import 'package:my_fit_squad/features/user_management/presentation/global_states/login_state.dart';
import 'package:my_fit_squad/features/user_management/presentation/view_models/join_us_view_model.dart';
import 'package:my_fit_squad/features/workouts_management/presentation/widgets/app_card.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class UserTypeScreen extends StatefulWidget {
  final StateNotifierProvider<JoinUsViewModel, BaseState<SignUpState>> provider;

  const UserTypeScreen({super.key, required this.provider});

  @override
  State<UserTypeScreen> createState() => _UserTypeScreenState();
}

class _UserTypeScreenState extends State<UserTypeScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, ref, __) {
      var type = ref.watch(widget.provider).data.type;
      return Column(
        children: [
          Expanded(
            child: AppCard(
              color: Theme.of(context).colorScheme.surface.withOpacity(0.5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Join the squad as a ....',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 100.w,
                        height: 7.5.h,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: type == UserType.coach
                                  ? Theme.of(context).colorScheme.secondary
                                  : Theme.of(context)
                                      .colorScheme
                                      .onInverseSurface),
                          child: Text("Coach".tr(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                      color: type == UserType.coach
                                          ? Theme.of(context)
                                              .colorScheme
                                              .onSecondary
                                          : Theme.of(context)
                                              .colorScheme
                                              .onSurface)),
                          onPressed: () {
                            ref
                                .watch(widget.provider.notifier)
                                .changeUserType(UserType.coach);
                          },
                        ),
                      ).paddingBottom(2.h),
                      SizedBox(
                        width: 100.w,
                        height: 7.5.h,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: type == UserType.client
                                  ? Theme.of(context).colorScheme.secondary
                                  : Theme.of(context)
                                      .colorScheme
                                      .onInverseSurface),
                          child: Text("Client".tr(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                      color: type == UserType.client
                                          ? Theme.of(context)
                                              .colorScheme
                                              .onSecondary
                                          : Theme.of(context)
                                              .colorScheme
                                              .onSurface)),
                          onPressed: () {
                            ref
                                .watch(widget.provider.notifier)
                                .changeUserType(UserType.client);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsetsDirectional.only(top: 2.h, bottom: 5.h),
            width: 100.w,
            height: 7.5.h,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.secondary),
              child: Text("Proceed".tr(),
                  style: Theme.of(context).textTheme.bodyLarge),
              onPressed: () {
                ProviderScope.containerOf(context)
                    .read(widget.provider.notifier)
                    .validateInputsAndchangeStep(step: JoinUsSteps.credentials);
              },
            ),
          )
        ],
      );
    });
  }
}
