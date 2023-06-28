import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_fit_squad/common/constants/colors.dart';
import 'package:my_fit_squad/common/extensions/widget_extensions.dart';
import 'package:my_fit_squad/features/base/data/helpers/base_state.dart';
import 'package:my_fit_squad/features/base/data/models/forms_errors.dart';
import 'package:my_fit_squad/features/base/presentation/widgets/app_text_field.dart';
import 'package:my_fit_squad/features/base/presentation/widgets/app_text_filed_error_text.dart';
import 'package:my_fit_squad/features/user_management/helpers/extensions/user_fields_extension.dart';
import 'package:my_fit_squad/features/user_management/presentation/global_states/login_state.dart';
import 'package:my_fit_squad/features/user_management/presentation/view_models/join_us_view_model.dart';
import 'package:my_fit_squad/features/workouts_management/presentation/widgets/app_card.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ClientCoachCode extends StatefulWidget {
  final StateNotifierProvider<JoinUsViewModel, BaseState<SignUpState>> provider;
  const ClientCoachCode({super.key, required this.provider});

  @override
  State<ClientCoachCode> createState() => _ClientCoachCodeState();
}

class _ClientCoachCodeState extends State<ClientCoachCode>
    with SingleTickerProviderStateMixin {
  final TextEditingController _coachCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: AppCard(
            color: Theme.of(context).colorScheme.surface.withOpacity(0.5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Have a Coach Code ....',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Consumer(builder: (_, ref, __) {
                  List<BaseFormError> errors =
                      ref.watch(widget.provider).data.errors;
                  int errorIndex = errors.indexWhere(
                      (error) => error.field == UserFieldType.email.field);
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTextField(
                        controller: _coachCodeController,
                        inputType: TextInputType.emailAddress,
                        label: 'Code'.tr(),
                        prefix: Icon(
                          Icons.code,
                          color: AppColors.white,
                        ),
                        errorText: (errorIndex != -1) ? "" : null,
                      ).paddingBottom(0),
                      (errorIndex != -1)
                          ? AppTextFieldErrorText(
                              errorText: errors[errorIndex].message ?? "",
                            )
                          : const SizedBox()
                    ],
                  ).paddingBottom(10);
                }),
              ],
            ),
          ),
        ),
        Column(
          children: [
            Container(
              margin: EdgeInsetsDirectional.only(top: 2.h),
              width: 100.w,
              height: 7.5.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.secondary),
                child: Text("Join Coach Squad".tr(),
                    style: Theme.of(context).textTheme.bodyLarge),
                onPressed: () {},
              ),
            ),
            Container(
              margin: EdgeInsetsDirectional.only(top: 2.h, bottom: 5.h),
              width: 100.w,
              height: 7.5.h,
              child: ElevatedButton(
                // style: ElevatedButton.styleFrom(
                //     backgroundColor: Theme.of(context).colorScheme.secondary),
                child: Text("Skip".tr(),
                    style: Theme.of(context).textTheme.bodyLarge),
                onPressed: () {
                  ProviderScope.containerOf(context)
                      .read(widget.provider.notifier)
                      .signup(code: _coachCodeController.text);
                },
              ),
            ),
          ],
        )
      ],
    );
  }
}
