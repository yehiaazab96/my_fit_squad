import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_fit_squad/common/injection/user_injection_container.dart';
import 'package:my_fit_squad/features/base/data/models/forms_errors.dart';
import 'package:my_fit_squad/features/base/presentation/screens/screen_handler.dart';
import 'package:my_fit_squad/features/base/presentation/view_models/base_view_model.dart';
import 'package:my_fit_squad/features/base/presentation/widgets/app_text_field.dart';
import 'package:my_fit_squad/features/base/presentation/widgets/app_text_filed_error_text.dart';
import 'package:my_fit_squad/features/user_management/helpers/extensions/user_fields_extension.dart';
import 'package:my_fit_squad/gen/assets.gen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../common/extensions/widget_extensions.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with BaseViewModel {
  final TextEditingController _userNameController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  double dialogHeight = 225.h;

  final _showPasswordProvider = StateProvider<bool>((ref) {
    return false;
  });

  // final forgetPasswordViewModelProvider =
  //     StateNotifierProvider<ForgetPasswordViewModel, BaseState<SignUpState>>(
  //         (ref) {
  //   return ForgetPasswordViewModel(
  //     ref.read(di.userRepositoryProvider),
  //   );
  // });

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: hideKeyboard,
      child: Consumer(builder: (_, watch, __) {
        return Stack(
          children: [
            Scaffold(
              body: SizedBox(
                height: 100.h,
                child: Stack(
                  children: [
                    Assets.images.loginBg
                        .image(width: 100.w, height: 100.h, fit: BoxFit.cover),
                    Container(
                      width: 100.w,
                      height: 100.h,
                      color: Theme.of(context)
                          .colorScheme
                          .background
                          .withOpacity(.5),
                    ),
                    Positioned(
                        top: 20.h,
                        right: 10,
                        left: 10,
                        child: Center(
                          child: Text(
                            'myFitSquad'.tr(),
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                        )),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'log_to_account'.tr(),
                            style: Theme.of(context).textTheme.headlineMedium,
                          ).paddingBottom(20),
                          buildLoginForms(context),
                          buildActionButton(context),
                          GestureDetector(
                            // onTap: () => buildForgetPasswordDialog(context),
                            child: Text("forgot_password".tr(),
                                    style:
                                        Theme.of(context).textTheme.bodyLarge)
                                .paddingTop(15)
                                .align(Alignment.center),
                          ),
                        ],
                      )
                          .paddingAll(24)
                          .background(Theme.of(context)
                              .colorScheme
                              .inversePrimary
                              .withOpacity(0.8))
                          .cornerRadius(const BorderRadius.only(
                              topLeft: Radius.circular(32),
                              topRight: Radius.circular(32))),
                    )
                        .animate()
                        // .fadeIn(duration: 1.seconds)
                        .flip(duration: 1.seconds, begin: -1, end: 0)
                        // .fade(duration: 1.seconds)
                        // .scale(delay: 0.5.seconds)
                        .slideY(begin: 0.4, end: 0),
                  ],
                ),
              ),
            ),
            ScreenHandler(screenProvider: loginViewModelProvider),
          ],
        );
      }),
    );
  }

  buildLoginForms(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Consumer(builder: (_, ref, __) {
          List<BaseFormError> errors =
              ref.watch(loginViewModelProvider).data.errors;
          int errorIndex = errors
              .indexWhere((error) => error.field == UserFieldType.email.field);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextField(
                controller: _userNameController,
                inputType: TextInputType.emailAddress,
                label: 'email'.tr(),
                prefix: const Icon(Icons.person),
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
              ref.watch(loginViewModelProvider).data.errors;
          int errorIndex = errors.indexWhere(
              (error) => error.field == UserFieldType.password.field);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextField(
                controller: _passwordController,
                label: 'Password'.tr(),
                prefix: const Icon(Icons.key),
                suffix: !showPassword
                    ? InkWell(
                        onTap: () {
                          ref.watch(_showPasswordProvider.notifier).state =
                              true;
                        },
                        child: const Icon(Icons.remove_red_eye))
                    : InkWell(
                        onTap: () {
                          ref.watch(_showPasswordProvider.notifier).state =
                              false;
                        },
                        child: const Icon(Icons.remove_red_eye_outlined)),
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
    );
  }

  buildActionButton(BuildContext context) {
    return SizedBox(
      width: 100.w,
      child: ElevatedButton(
        child:
            Text("sign_in".tr(), style: Theme.of(context).textTheme.bodyMedium),
        onPressed: () {
          ProviderScope.containerOf(context)
              .read(loginViewModelProvider.notifier)
              .login(
                  email: _userNameController.text,
                  password: _passwordController.text);
        },
      ),
    );
  }

  // buildForgetPasswordDialog(BuildContext context) {
  //   var dialog = Dialog(
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.w)),
  //     child: GestureDetector(
  //         onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
  //         child: ForgetPasswordDialog(
  //           provider: forgetPasswordViewModelProvider,
  //         )),
  //   );

  //   showCustomDialog(dialog);
  // }
}
