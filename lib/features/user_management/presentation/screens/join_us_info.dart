import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_fit_squad/common/extensions/widget_extensions.dart';
import 'package:my_fit_squad/features/base/data/helpers/base_state.dart';
import 'package:my_fit_squad/features/base/data/models/forms_errors.dart';
import 'package:my_fit_squad/features/base/presentation/widgets/app_text_field.dart';
import 'package:my_fit_squad/features/base/presentation/widgets/app_text_filed_error_text.dart';
import 'package:my_fit_squad/features/user_management/helpers/extensions/user_fields_extension.dart';
import 'package:my_fit_squad/features/user_management/helpers/join_us_steps.dart';
import 'package:my_fit_squad/features/user_management/helpers/user_type.dart';
import 'package:my_fit_squad/features/user_management/presentation/global_states/login_state.dart';
import 'package:my_fit_squad/features/user_management/presentation/view_models/join_us_view_model.dart';
import 'package:my_fit_squad/features/workouts_management/presentation/widgets/app_card.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class JoinUsInfo extends StatefulWidget {
  final StateNotifierProvider<JoinUsViewModel, BaseState<SignUpState>> provider;
  const JoinUsInfo({super.key, required this.provider});

  @override
  State<JoinUsInfo> createState() => _JoinUsInfoState();
}

class _JoinUsInfoState extends State<JoinUsInfo>
    with SingleTickerProviderStateMixin {
  final TextEditingController _firstNameController = TextEditingController();

  final TextEditingController _lastNameController = TextEditingController();

  final TextEditingController _ageController = TextEditingController();
  XFile? _imageFile;
  ImageProvider? _profileImage;
  double dialogHeight = 225.h;

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
                'Fill your personal data \n to Proceed',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: () async {
                      final ImagePicker picker = ImagePicker();
                      final XFile? image =
                          await picker.pickImage(source: ImageSource.gallery);
                      final bytes = await image?.readAsBytes();
                      if (bytes != null) {
                        setState(() {
                          _imageFile = image;
                          _profileImage = MemoryImage(bytes);
                        });
                      }
                    },
                    child: CircleAvatar(
                      minRadius: 15.w,
                      maxRadius: 15.w,
                      backgroundColor:
                          Theme.of(context).colorScheme.onSecondary,
                      backgroundImage: _profileImage,
                      child: _profileImage == null
                          ? Icon(
                              Icons.add_a_photo_outlined,
                              size: 4.h,
                            )
                          : null,
                    ).paddingBottom(4.h),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Consumer(builder: (_, ref, __) {
                          List<BaseFormError> errors =
                              ref.watch(widget.provider).data.errors;
                          int errorIndex = errors.indexWhere((error) =>
                              error.field == UserFieldType.firstName.field);
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppTextField(
                                controller: _firstNameController,
                                inputType: TextInputType.text,
                                label: 'first_name'.tr(),
                                errorText: (errorIndex != -1) ? "" : null,
                              ).paddingBottom(0),
                              (errorIndex != -1)
                                  ? AppTextFieldErrorText(
                                      errorText:
                                          errors[errorIndex].message ?? "",
                                    )
                                  : const SizedBox()
                            ],
                          );
                        }),
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      Expanded(
                        child: Consumer(builder: (_, ref, __) {
                          List<BaseFormError> errors =
                              ref.watch(widget.provider).data.errors;
                          int errorIndex = errors.indexWhere((error) =>
                              error.field == UserFieldType.lastName.field);
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppTextField(
                                controller: _lastNameController,
                                inputType: TextInputType.text,
                                label: 'last_name'.tr(),
                                errorText: (errorIndex != -1) ? "" : null,
                              ).paddingBottom(0),
                              (errorIndex != -1)
                                  ? AppTextFieldErrorText(
                                      errorText:
                                          errors[errorIndex].message ?? "",
                                    )
                                  : const SizedBox()
                            ],
                          );
                        }),
                      ),
                    ],
                  ).paddingBottom(10),
                  Consumer(builder: (_, ref, __) {
                    List<BaseFormError> errors =
                        ref.watch(widget.provider).data.errors;
                    int errorIndex = errors.indexWhere(
                        (error) => error.field == UserFieldType.age.field);
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppTextField(
                          controller: _ageController,
                          inputType: TextInputType.number,
                          label: 'age'.tr(),
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
              )
            ],
          ),
        )),
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
              var userType = ProviderScope.containerOf(context)
                  .read(widget.provider)
                  .data
                  .type;
              ProviderScope.containerOf(context)
                  .read(widget.provider.notifier)
                  .validateInputsAndchangeStep(
                      step: userType == UserType.client
                          ? JoinUsSteps.clientCoachCode
                          : JoinUsSteps.coachPackage,
                      firstName: _firstNameController.text,
                      lastName: _lastNameController.text,
                      profileImage: _imageFile,
                      age: _ageController.text);
            },
          ),
        )
      ],
    );
  }
}
