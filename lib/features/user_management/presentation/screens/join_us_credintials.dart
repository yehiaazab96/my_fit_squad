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
import 'package:my_fit_squad/features/user_management/helpers/join_us_steps.dart';
import 'package:my_fit_squad/features/user_management/presentation/global_states/login_state.dart';
import 'package:my_fit_squad/features/user_management/presentation/view_models/join_us_view_model.dart';
import 'package:my_fit_squad/features/workouts_management/presentation/widgets/app_card.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class JoinUsCredintials extends StatefulWidget {
  final StateNotifierProvider<JoinUsViewModel, BaseState<SignUpState>> provider;
  const JoinUsCredintials({super.key, required this.provider});

  @override
  State<JoinUsCredintials> createState() => _JoinUsCredintialsState();
}

class _JoinUsCredintialsState extends State<JoinUsCredintials>
    with SingleTickerProviderStateMixin {
  final TextEditingController _userNameController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _confirmPasswordController =
      TextEditingController();

  double dialogHeight = 225.h;

  final _showPasswordProvider = StateProvider<bool>((ref) {
    return false;
  });

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
                  'Enter Email and Password \n to Proceed',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Consumer(builder: (_, ref, __) {
                      List<BaseFormError> errors =
                          ref.watch(widget.provider).data.errors;
                      int errorIndex = errors.indexWhere(
                          (error) => error.field == UserFieldType.email.field);
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppTextField(
                            controller: _userNameController,
                            inputType: TextInputType.emailAddress,
                            label: 'email'.tr(),
                            prefix: Icon(
                              Icons.person,
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
                    Consumer(builder: (_, ref, __) {
                      bool showPassword = ref.watch(_showPasswordProvider);
                      List<BaseFormError> errors =
                          ref.watch(widget.provider).data.errors;
                      int errorIndex = errors.indexWhere((error) =>
                          error.field == UserFieldType.password.field);
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppTextField(
                            controller: _passwordController,
                            label: 'Password'.tr(),
                            prefix: Icon(
                              Icons.key,
                              color: AppColors.white,
                            ),
                            suffix: !showPassword
                                ? InkWell(
                                    onTap: () {
                                      ref
                                          .watch(_showPasswordProvider.notifier)
                                          .state = true;
                                    },
                                    child: Icon(
                                      Icons.remove_red_eye,
                                      color: AppColors.white,
                                    ))
                                : InkWell(
                                    onTap: () {
                                      ref
                                          .watch(_showPasswordProvider.notifier)
                                          .state = false;
                                    },
                                    child: Icon(
                                      Icons.remove_red_eye_outlined,
                                      color: AppColors.white,
                                    )),
                            isSecured: !showPassword,
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
                    Consumer(builder: (_, ref, __) {
                      bool showPassword = ref.watch(_showPasswordProvider);
                      List<BaseFormError> errors =
                          ref.watch(widget.provider).data.errors;
                      int errorIndex = errors.indexWhere((error) =>
                          error.field == UserFieldType.confirmPassword.field);
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppTextField(
                            controller: _confirmPasswordController,
                            label: 'confirm_password'.tr(),
                            prefix: Icon(
                              Icons.key,
                              color: AppColors.white,
                            ),
                            suffix: !showPassword
                                ? InkWell(
                                    onTap: () {
                                      ref
                                          .watch(_showPasswordProvider.notifier)
                                          .state = true;
                                    },
                                    child: Icon(
                                      Icons.remove_red_eye,
                                      color: AppColors.white,
                                    ))
                                : InkWell(
                                    onTap: () {
                                      ref
                                          .watch(_showPasswordProvider.notifier)
                                          .state = false;
                                    },
                                    child: Icon(
                                      Icons.remove_red_eye_outlined,
                                      color: AppColors.white,
                                    )),
                            isSecured: !showPassword,
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
                  .validateInputsAndchangeStep(
                      step: JoinUsSteps.info,
                      email: _userNameController.text,
                      password: _passwordController.text,
                      confirmPassword: _confirmPasswordController.text);
            },
          ),
        )
      ],
    );
  }
}
