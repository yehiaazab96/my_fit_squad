import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_fit_squad/common/constants/constants.dart';
import 'package:my_fit_squad/common/extensions/widget_extensions.dart';
import 'package:my_fit_squad/common/injection/injection_container.dart';
import 'package:my_fit_squad/common/utils/app_theme.dart';
import 'package:my_fit_squad/features/base/data/helpers/base_state.dart';
import 'package:my_fit_squad/features/base/data/models/forms_errors.dart';
import 'package:my_fit_squad/features/base/presentation/widgets/app_network_image.dart';
import 'package:my_fit_squad/features/base/presentation/widgets/app_text_field.dart';
import 'package:my_fit_squad/features/base/presentation/widgets/app_text_filed_error_text.dart';
import 'package:my_fit_squad/features/workouts_management/data/model/class.dart';
import 'package:my_fit_squad/features/workouts_management/data/model/program_class.dart';
import 'package:my_fit_squad/features/workouts_management/data/model/program_data.dart';
import 'package:my_fit_squad/features/workouts_management/helpers/extensions/workout_fields_extension.dart';
import 'package:my_fit_squad/features/workouts_management/presentation/global_states/add_program_state.dart';
import 'package:my_fit_squad/features/workouts_management/presentation/view_models/add_program_view_model.dart';
import 'package:my_fit_squad/features/workouts_management/presentation/widgets/app_card.dart';
import 'package:my_fit_squad/features/workouts_management/presentation/widgets/class_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AddProgramScreen extends StatefulWidget {
  static const routeName = './add_program';
  const AddProgramScreen({
    super.key,
  });

  @override
  State<AddProgramScreen> createState() => _AddProgramScreenState();
}

class _AddProgramScreenState extends State<AddProgramScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      setState(() {
        _classes = ProviderScope.containerOf(context)
            .read(classesViewModelProvider)
            .data
            .classes;
        _filteredClasses = _classes;
      });
    });
    super.initState();
  }

  void fetchClasses() {
    Future.delayed(0.seconds, () {
      ProviderScope.containerOf(context)
          .read(classesViewModelProvider.notifier)
          .getClasses()
          .then((value) {
        setState(() {
          _classes = value;
          _filteredClasses = _classes;
        });
      });
    });
  }

  final _vieModelProvider =
      StateNotifierProvider<AddProgramViewModel, BaseState<AddProgramState>>(
          (ref) {
    return AddProgramViewModel(
      ref.read(workoutsRepositoryProvider),
    );
  });

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _duartionController = TextEditingController();
  int _selectedDay = 1;
  Color _borderColor = Theme.of(Constants.navigatorKey.currentContext!)
      .colorScheme
      .surfaceVariant;

  List<Class>? _classes;
  List<Class>? _filteredClasses;
  List<ProgramClass?>? _selectedClasses = [];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 50.h,
            child: AppCard(child: Consumer(builder: (_, ref, __) {
              List<BaseFormError> errors =
                  ref.watch(_vieModelProvider).data.errors;

              int errorIndex = errors.indexWhere((error) =>
                  error.field == WorkoutFieldType.programClasses.field);
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Consumer(builder: (_, ref, __) {
                      List<BaseFormError> errors =
                          ref.watch(_vieModelProvider).data.errors;
                      int errorIndex = errors.indexWhere((error) =>
                          error.field == WorkoutFieldType.title.field);
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
                    AppTextField(
                      isReadOnly: true,
                      onTap: () {
                        _showPicker(context, _duartionController);
                      },
                      controller: _duartionController,
                      inputType: TextInputType.text,
                      label: 'duration'.tr(),
                    ).paddingBottom(3.h),
                    AppTextField(
                      prefix: const Icon(Icons.search_sharp),
                      controller: _searchController,
                      inputType: TextInputType.text,
                      onChanged: (txt) {
                        setState(() {
                          _filteredClasses = _classes
                              ?.where((element) => element.title!
                                  .toLowerCase()
                                  .contains(txt.toLowerCase()))
                              .toList();
                        });
                      },
                      label: 'search'.tr(),
                    ).paddingBottom(1.5.h),
                    Container(
                      height: 15.h,
                      child: (_classes == null || _classes!.isEmpty)
                          ? Center(
                              child: GestureDetector(
                                child: Icon(
                                  Icons.refresh,
                                  size: 5.h,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                                onTap: () {
                                  fetchClasses();
                                },
                              ),
                            )
                          : GridView(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 5,
                                      crossAxisSpacing: 1.h,
                                      mainAxisSpacing: 1.h),
                              children: [
                                if (_filteredClasses != null)
                                  ..._filteredClasses!.map((e) {
                                    return Draggable<Class>(
                                      data: e,
                                      feedback: Container(
                                          height: 10.h,
                                          width: 10.h,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .inverseSurface
                                              .withOpacity(0.5),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(1.h),
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
                                          )),
                                      onDragStarted: () {
                                        print('drag started');
                                      },
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(1.h),
                                        child: Stack(
                                          children: [
                                            Positioned.fill(
                                              child: AppNetworkImage(
                                                hasToken: true,
                                                url: e.classWorkouts?.first
                                                        .workout?.image ??
                                                    '',
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
                                                              color: Theme.of(
                                                                      context)
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
                ),
              );
            })),
          ),
          AppCard(
              child: Column(
            children: [
              if (_duartionController.text.isNotEmpty)
                SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                          int.parse(_duartionController.text),
                          (index) => GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedDay = index + 1;
                                  });
                                },
                                child: Container(
                                  height: 8.h,
                                  width: 14.w,
                                  decoration: BoxDecoration(
                                      color: _selectedDay == index + 1
                                          ? Theme.of(context)
                                              .colorScheme
                                              .secondary
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(1.h)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          CircleAvatar(
                                            radius: 0.3.h,
                                            backgroundColor:
                                                _selectedDay == index + 1
                                                    ? Theme.of(context)
                                                        .colorScheme
                                                        .surface
                                                    : Colors.transparent,
                                          ),
                                          CircleAvatar(
                                            radius: 0.3.h,
                                            backgroundColor:
                                                _selectedDay == index + 1
                                                    ? Theme.of(context)
                                                        .colorScheme
                                                        .surface
                                                    : Colors.transparent,
                                          ),
                                        ],
                                      ).paddingBottom(0.4.h),
                                      Text(
                                        (index + 1).toString(),
                                        style: textTheme.headlineLarge
                                            ?.copyWith(
                                                fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ).paddingHorizontal(2.w),
                              )),
                    )).paddingBottom(3.h),
              if (_duartionController.text.isNotEmpty)
                DragTarget<Class>(
                  onAccept: (data) {
                    setState(() {
                      _borderColor =
                          Theme.of(context).colorScheme.surfaceVariant;
                      _selectedClasses![_selectedDay - 1] =
                          ProgramClass(cls: data, day: _selectedDay);
                    });
                    print(_selectedClasses);
                  },
                  onWillAccept: (data) {
                    setState(() {
                      _borderColor = Theme.of(context).colorScheme.secondary;
                    });
                    return true;
                  },
                  onLeave: (data) {
                    setState(() {
                      _borderColor =
                          Theme.of(context).colorScheme.surfaceVariant;
                    });
                  },
                  builder: (context, candidateData, rejectedData) {
                    print(candidateData);
                    print(candidateData.length);
                    if (_selectedClasses!.isNotEmpty &&
                        _selectedClasses![_selectedDay - 1] != null) {
                      return ClassWidget(
                        cls: _selectedClasses![_selectedDay - 1]!.cls,
                      );
                    } else {
                      return Container(
                        height: 20.h,
                        width: 20.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(1.h),
                            border: Border.all(
                                color: Theme.of(context)
                                    .colorScheme
                                    .inverseSurface),
                            color: _borderColor),
                        child: Center(
                          child: Text(
                            'Drag here',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ),
                      );
                    }
                  },
                ),
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
                    ProgramData data = ProgramData(
                        title: _titleController.text,
                        description: _descriptionController.text,
                        duration: _duartionController.text,
                        programClasses: _selectedClasses);

                    ProviderScope.containerOf(context)
                        .read(_vieModelProvider.notifier)
                        .addProgram(programData: data);
                  },
                ),
              )
            ],
          ))
        ],
      ),
    );
  }

  void _showPicker(BuildContext ctx, TextEditingController controller) {
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) {
          return SizedBox(
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
                  _selectedClasses = List.generate(value + 1, (index) => null);
                });
              },
            ),
          );
        });
  }
}
