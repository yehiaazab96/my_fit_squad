import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_fit_squad/common/extensions/widget_extensions.dart';
import 'package:my_fit_squad/features/base/presentation/widgets/app_drop_down.dart';
import 'package:my_fit_squad/features/base/presentation/widgets/app_text_field.dart';
import 'package:my_fit_squad/features/base/presentation/widgets/app_text_filed_error_text.dart';
import 'package:my_fit_squad/features/coaches_clients_management/helpers/drop_down_data.dart';
import 'package:my_fit_squad/features/workouts_management/helpers/workout_type.dart';
import 'package:my_fit_squad/features/workouts_management/presentation/widgets/app_card.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ClassWorkoutDialog extends StatefulWidget {
  final Function({String? reps, String? repeat, String? restTime, String? type})
      onResult;
  const ClassWorkoutDialog({
    required this.onResult,
    super.key,
  });

  @override
  State<ClassWorkoutDialog> createState() => _ClassWorkoutDialogState();
}

class _ClassWorkoutDialogState extends State<ClassWorkoutDialog> {
  final TextEditingController _repsController = TextEditingController();
  final TextEditingController _repeatController = TextEditingController();
  final TextEditingController _restTimeController = TextEditingController();
  WorkoutType _selectedWorkoutType = WorkoutType.reps;
  bool isError = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 50.h,
        child: Column(
          children: [
            Expanded(
              child: AppCard(
                  externalPadding: EdgeInsets.zero,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: AppTextField(
                              isReadOnly: true,
                              onTap: () {
                                _showPicker(context, _repsController);
                              },
                              controller: _repsController,
                              inputType: TextInputType.text,
                              label: 'reps/seconds'.tr(),
                            ),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Expanded(
                            child: AppDropdown<String?>(
                                hint: 'type'.tr(),
                                initialValue: _selectedWorkoutType.title,
                                items: WorkoutType.values
                                    .map((type) => DropDownData<String>(
                                        label: type.title, value: type.title))
                                    .toList(),
                                onChange: (newType) {
                                  _selectedWorkoutType =
                                      WorkoutType.getWorkoutType(
                                          newType ?? ' ');
                                }),
                          ),
                        ],
                      ).paddingBottom(3.h),
                      AppTextField(
                        isReadOnly: true,
                        onTap: () {
                          _showPicker(context, _repeatController);
                        },
                        controller: _repeatController,
                        inputType: TextInputType.text,
                        label: 'repeat'.tr(),
                      ).paddingBottom(3.h),
                      AppTextField(
                        isReadOnly: true,
                        onTap: () {
                          _showPicker(context, _restTimeController);
                        },
                        controller: _restTimeController,
                        inputType: TextInputType.text,
                        label: 'rest_time'.tr(),
                      ).paddingBottom(3.h),
                      if (isError)
                        const AppTextFieldErrorText(
                          errorText: 'All fields are required',
                        ),
                      Container(
                        margin:
                            EdgeInsetsDirectional.only(top: 2.h, bottom: 5.h),
                        width: 100.w,
                        height: 7.5.h,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).colorScheme.secondary),
                          child: Text("Create".tr(),
                              style: Theme.of(context).textTheme.bodyLarge),
                          onPressed: () {
                            if (_repeatController.text.isNotEmpty &&
                                _repsController.text.isNotEmpty &&
                                _restTimeController.text.isNotEmpty) {
                              setState(() {
                                isError = false;
                              });
                              Navigator.of(context).pop();
                              widget.onResult(
                                  reps: _repsController.text,
                                  repeat: _repeatController.text,
                                  type: _selectedWorkoutType.title,
                                  restTime: _restTimeController.text);
                            } else {
                              setState(() {
                                isError = true;
                              });
                            }
                          },
                        ),
                      )
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }

  void _showPicker(BuildContext ctx, TextEditingController controller) {
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => SizedBox(
              height: 40.h,
              child: CupertinoPicker(
                itemExtent: 5.h,
                useMagnifier: true,
                magnification: 1.2,
                scrollController: FixedExtentScrollController(initialItem: 1),
                children: List<int>.generate(100, (i) => i + 1)
                    .map((e) => Text(e.toString()))
                    .toList(),
                onSelectedItemChanged: (value) {
                  setState(() {
                    controller.text = (value + 1).toString();
                  });
                },
              ),
            ));
  }
}
