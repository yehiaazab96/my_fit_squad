import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_fit_squad/common/extensions/widget_extensions.dart';
import 'package:my_fit_squad/features/base/data/helpers/base_state.dart';
import 'package:my_fit_squad/features/user_management/helpers/coach_package.dart';
import 'package:my_fit_squad/features/user_management/presentation/global_states/login_state.dart';
import 'package:my_fit_squad/features/user_management/presentation/view_models/join_us_view_model.dart';
import 'package:my_fit_squad/features/workouts_management/presentation/widgets/app_card.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CoachPackageScreen extends StatefulWidget {
  final StateNotifierProvider<JoinUsViewModel, BaseState<SignUpState>> provider;

  const CoachPackageScreen({super.key, required this.provider});

  @override
  State<CoachPackageScreen> createState() => _CoachPackageScreenState();
}

class _CoachPackageScreenState extends State<CoachPackageScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: AppCard(
            color: Theme.of(context).colorScheme.surface.withOpacity(0.5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Choose your package',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Consumer(builder: (_, ref, __) {
                  var currentPlan =
                      (ref.watch(widget.provider).data.user!).subscribtionPlan;
                  return Wrap(
                    children: CoachPackages.values.map((e) {
                      return GestureDetector(
                        onTap: () {
                          ref
                              .watch(widget.provider.notifier)
                              .changeCoachPlan(e);
                        },
                        child: Container(
                          height: 25.h,
                          width: 30.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2.w),
                              border: Border.all(
                                  color: currentPlan == e
                                      ? Theme.of(context).colorScheme.secondary
                                      : Theme.of(context)
                                          .colorScheme
                                          .onInverseSurface)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                e.title,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              Text(
                                e.clientDisplay,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Text(
                                e.pricePerMonth,
                                style: Theme.of(context).textTheme.titleMedium,
                              )
                            ],
                          ),
                        ).paddingHorizontal(1.h).paddingVertical(2.w),
                      );
                    }).toList(),
                  );
                })
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
                  .signup();
            },
          ),
        )
      ],
    );
  }
}
