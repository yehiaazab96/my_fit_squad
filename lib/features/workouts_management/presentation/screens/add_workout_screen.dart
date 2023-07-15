import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_fit_squad/common/extensions/widget_extensions.dart';
import 'package:my_fit_squad/common/injection/injection_container.dart';
import 'package:my_fit_squad/features/base/data/helpers/base_state.dart';
import 'package:my_fit_squad/features/base/data/models/forms_errors.dart';
import 'package:my_fit_squad/features/base/presentation/widgets/app_drop_down.dart';
import 'package:my_fit_squad/features/base/presentation/widgets/app_text_field.dart';
import 'package:my_fit_squad/features/base/presentation/widgets/app_text_filed_error_text.dart';
import 'package:my_fit_squad/features/coaches_clients_management/helpers/drop_down_data.dart';
import 'package:my_fit_squad/features/workouts_management/data/model/workout_data.dart';
import 'package:my_fit_squad/features/workouts_management/helpers/extensions/workout_fields_extension.dart';
import 'package:my_fit_squad/features/workouts_management/helpers/muscle_group.dart';
import 'package:my_fit_squad/features/workouts_management/helpers/workout_category.dart';
import 'package:my_fit_squad/features/workouts_management/presentation/global_states/add_workout_state.dart';
import 'package:my_fit_squad/features/workouts_management/presentation/view_models/add_workout_view_model.dart';
import 'package:my_fit_squad/features/workouts_management/presentation/widgets/app_card.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AddWorkoutScreen extends StatefulWidget {
  static const routeName = './add_workout';
  const AddWorkoutScreen({
    super.key,
  });

  @override
  State<AddWorkoutScreen> createState() => _AddWorkoutScreenState();
}

class _AddWorkoutScreenState extends State<AddWorkoutScreen> {
  final _vieModelProvider =
      StateNotifierProvider<AddWorkoutViewModel, BaseState<AddWorkoutState>>(
          (ref) {
    return AddWorkoutViewModel(
      ref.read(workoutsRepositoryProvider),
    );
  });

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String _selectedCategory = WorkoutCategory.muscleGain.title;
  String _selectedMuscleGroup = MuscleGroup.chest.title;
  XFile? _imageFile;
  ImageProvider? _workoutImage;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          AppCard(child: Consumer(builder: (_, ref, __) {
            List<BaseFormError> errors =
                ref.watch(_vieModelProvider).data.errors;
            int errorIndex = errors.indexWhere(
                (error) => error.field == WorkoutFieldType.image.field);
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                        _workoutImage = MemoryImage(bytes);
                      });
                    }
                  },
                  child: Container(
                    height: 20.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3.h),
                        border: Border.all(
                            color: Theme.of(context).colorScheme.secondary)),
                    child: _workoutImage != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(3.h),
                            child: Image(
                              image: _workoutImage!,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_a_photo_outlined,
                                  size: 5.h,
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                const Text('Add Workout Image')
                              ],
                            ),
                          ),
                  ),
                ),
                (errorIndex != -1)
                    ? AppTextFieldErrorText(
                        errorText: errors[errorIndex].message ?? "",
                      )
                    : const SizedBox()
              ],
            );
          })),
          AppCard(
              child: Column(
            children: [
              Consumer(builder: (_, ref, __) {
                List<BaseFormError> errors =
                    ref.watch(_vieModelProvider).data.errors;
                int errorIndex = errors.indexWhere(
                    (error) => error.field == WorkoutFieldType.title.field);
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AppTextField(
                      controller: _titleController,
                      inputType: TextInputType.text,
                      label: 'title'.tr(),
                    ),
                    (errorIndex != -1)
                        ? AppTextFieldErrorText(
                            errorText: errors[errorIndex].message ?? "",
                          )
                        : const SizedBox()
                  ],
                );
              }).paddingBottom(3.h),
              Row(
                children: [
                  Expanded(
                    child: AppDropdown<String?>(
                        hint: 'category'.tr(),
                        initialValue: _selectedCategory,
                        items: WorkoutCategory.values
                            .map((category) => DropDownData<String>(
                                label: category.title, value: category.title))
                            .toList(),
                        onChange: (newType) {
                          _selectedCategory = newType ?? '';
                        }),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Expanded(
                    child: AppDropdown<String?>(
                        hint: 'muscle_group'.tr(),
                        initialValue: _selectedMuscleGroup,
                        items: MuscleGroup.values
                            .map((category) => DropDownData<String>(
                                label: category.title, value: category.title))
                            .toList(),
                        onChange: (newType) {
                          _selectedMuscleGroup = newType ?? '';
                        }),
                  ),
                ],
              ).paddingBottom(3.h),
              Consumer(builder: (_, ref, __) {
                List<BaseFormError> errors =
                    ref.watch(_vieModelProvider).data.errors;
                int errorIndex = errors.indexWhere((error) =>
                    error.field == WorkoutFieldType.description.field);
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AppTextField(
                      controller: _descriptionController,
                      inputType: TextInputType.text,
                      label: 'description'.tr(),
                    ),
                    (errorIndex != -1)
                        ? AppTextFieldErrorText(
                            errorText: errors[errorIndex].message ?? "",
                          )
                        : const SizedBox()
                  ],
                );
              }).paddingBottom(3.h),
              Container(
                margin: EdgeInsetsDirectional.only(top: 2.h, bottom: 5.h),
                width: 100.w,
                height: 7.5.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.secondary),
                  child: Text("Create".tr(),
                      style: Theme.of(context).textTheme.bodyLarge),
                  onPressed: () {
                    WorkoutData data = WorkoutData(
                        title: _titleController.text,
                        description: _descriptionController.text,
                        image: _imageFile,
                        category: WorkoutCategory.getWorkoutCategory(
                            _selectedCategory),
                        muscleGroup:
                            MuscleGroup.getMuscleGroup(_selectedMuscleGroup));

                    ProviderScope.containerOf(context)
                        .read(_vieModelProvider.notifier)
                        .addWorkout(workoutData: data);
                  },
                ),
              )
            ],
          ))
        ],
      ),
    );
  }
}
