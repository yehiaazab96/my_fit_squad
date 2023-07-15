import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_fit_squad/common/api/api_urls.dart';
import 'package:my_fit_squad/common/extensions/widget_extensions.dart';
import 'package:my_fit_squad/common/injection/injection_container.dart';
import 'package:my_fit_squad/features/base/data/helpers/base_state.dart';
import 'package:my_fit_squad/features/base/data/models/forms_errors.dart';
import 'package:my_fit_squad/features/base/presentation/widgets/app_network_image.dart';
import 'package:my_fit_squad/features/base/presentation/widgets/app_text_field.dart';
import 'package:my_fit_squad/features/base/presentation/widgets/app_text_filed_error_text.dart';
import 'package:my_fit_squad/features/workouts_management/data/model/class_data.dart';
import 'package:my_fit_squad/features/workouts_management/data/model/class_workout.dart';
import 'package:my_fit_squad/features/workouts_management/data/model/workout.dart';
import 'package:my_fit_squad/features/workouts_management/helpers/extensions/workout_fields_extension.dart';
import 'package:my_fit_squad/features/workouts_management/helpers/workout_type.dart';
import 'package:my_fit_squad/features/workouts_management/presentation/global_states/add_class_state.dart';
import 'package:my_fit_squad/features/workouts_management/presentation/view_models/add_class_view_model.dart';
import 'package:my_fit_squad/features/workouts_management/presentation/widgets/app_card.dart';
import 'package:my_fit_squad/features/workouts_management/presentation/widgets/class_workout_dialog.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AddClassScreen extends StatefulWidget {
  static const routeName = './add_class';
  const AddClassScreen({
    super.key,
  });

  @override
  State<AddClassScreen> createState() => _AddClassScreenState();
}

class _AddClassScreenState extends State<AddClassScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      setState(() {
        _workouts = ProviderScope.containerOf(context)
            .read(workoutsViewModelProvider)
            .data
            .workouts;
        _filterdWorkouts = _workouts;
      });
    });
    super.initState();
  }

  final _vieModelProvider =
      StateNotifierProvider<AddClassViewModel, BaseState<AddClassState>>((ref) {
    return AddClassViewModel(
      ref.read(workoutsRepositoryProvider),
    );
  });

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  List<Workout>? _workouts;
  List<Workout>? _filterdWorkouts;
  List<ClassWorkout> _selectedWorkouts = [];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 25.h,
            child: AppCard(child: Consumer(builder: (_, ref, __) {
              List<BaseFormError> errors =
                  ref.watch(_vieModelProvider).data.errors;

              int errorIndex = errors.indexWhere((error) =>
                  error.field == WorkoutFieldType.classWorkouts.field);
              return Column(
                children: [
                  AppTextField(
                    prefix: const Icon(Icons.search_sharp),
                    controller: _searchController,
                    inputType: TextInputType.text,
                    onChanged: (txt) {
                      setState(() {
                        _filterdWorkouts = _workouts
                            ?.where((element) => element.title!
                                .toLowerCase()
                                .contains(txt.toLowerCase()))
                            .toList();
                      });
                    },
                    label: 'search'.tr(),
                  ).paddingBottom(1.5.h),
                  Expanded(
                    child: GridView(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5,
                          crossAxisSpacing: 1.h,
                          mainAxisSpacing: 1.h),
                      children: [
                        if (_filterdWorkouts != null)
                          ..._filterdWorkouts!.map((e) {
                            return GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: ((context) {
                                      return ClassWorkoutDialog(
                                        onResult: (
                                            {repeat, reps, restTime, type}) {
                                          setState(() {
                                            _selectedWorkouts.add(ClassWorkout(
                                                workout: e,
                                                reps: int.parse(reps!),
                                                repeat: int.parse(repeat!),
                                                type:
                                                    WorkoutType.getWorkoutType(
                                                        type ?? ''),
                                                restTime:
                                                    int.parse(restTime!)));
                                          });
                                        },
                                      );
                                    }));
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(1.h),
                                child: Stack(
                                  children: [
                                    Positioned.fill(
                                      child: AppNetworkImage(
                                        url:
                                            '${ApiUrls.baseImageUrl}${ApiUrls.workouts}/${e.image ?? ''}',
                                      ),
                                    ),
                                    Positioned(
                                        bottom: 0,
                                        left: 0,
                                        right: 0,
                                        child: Container(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .inverseSurface
                                              .withOpacity(0.5),
                                          height: 7.h,
                                          child: Center(
                                            child: Text(
                                              e.title ?? '',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall
                                                  ?.copyWith(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .scrim),
                                            ),
                                          ),
                                        ))
                                  ],
                                ),
                              ),
                            );
                          }).toList()
                      ],
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
          ),
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
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _selectedWorkouts.map((e) {
                    return Column(
                      children: [
                        Text(
                          (_selectedWorkouts.indexOf(e) + 1).toString(),
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Container(
                          width: 30.w,
                          height: 10.h,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(1.h),
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  child: AppNetworkImage(
                                    url:
                                        '${ApiUrls.baseImageUrl}${ApiUrls.workouts}/${e.workout?.image ?? ''}',
                                  ),
                                ),
                                Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .inverseSurface
                                          .withOpacity(0.5),
                                      height: 5.h,
                                      child: Center(
                                        child: Column(
                                          children: [
                                            Text(
                                              e.workout?.title ?? '',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall
                                                  ?.copyWith(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .scrim),
                                            ),
                                            Text(
                                              '${e.reps ?? 0} x ${e.repeat ?? 0}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall
                                                  ?.copyWith(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .scrim),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ))
                              ],
                            ),
                          ),
                        ).paddingHorizontal(2.w),
                      ],
                    );
                  }).toList(),
                ),
              ).paddingBottom(1.h),
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
                    ClassData data = ClassData(
                      title: _titleController.text,
                      description: _descriptionController.text,
                      classWorkout: _selectedWorkouts,
                    );

                    ProviderScope.containerOf(context)
                        .read(_vieModelProvider.notifier)
                        .addClass(classData: data);
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
