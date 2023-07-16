import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_fit_squad/common/constants/constants.dart';
import 'package:my_fit_squad/common/extensions/widget_extensions.dart';
import 'package:my_fit_squad/common/injection/injection_container.dart';
import 'package:my_fit_squad/common/injection/squad_injection_container.dart';
import 'package:my_fit_squad/features/base/presentation/widgets/app_text_field.dart';
import 'package:my_fit_squad/features/user_management/data/model/user_model.dart';
import 'package:my_fit_squad/features/workouts_management/data/model/program.dart';
import 'package:my_fit_squad/features/workouts_management/helpers/entities/program_details_args.dart';
import 'package:my_fit_squad/features/workouts_management/presentation/screens/program_details_screen.dart';
import 'package:my_fit_squad/features/workouts_management/presentation/widgets/app_card.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AssignProgramScreen extends StatefulWidget {
  static const routeName = 'assign_program_screen';
  final User client;
  const AssignProgramScreen({super.key, required this.client});

  @override
  State<AssignProgramScreen> createState() => _AssignProgramScreenState();
}

class _AssignProgramScreenState extends State<AssignProgramScreen> {
  DateTime? _selectedDate;
  final TextEditingController _selectedDateController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  List<Program>? _programs;
  List<Program>? _filteredPrograms;
  Program? _selectedProgram;

  void fetchPrograms() {
    Future.delayed(0.seconds, () async {
      _programs = await ProviderScope.containerOf(
              Constants.navigatorKey.currentContext!)
          .read(programsViewModelProvider.notifier)
          .getPrograms();
      setState(() {
        _filteredPrograms = _programs;
      });
    });
  }

  @override
  void initState() {
    fetchPrograms();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          if (_selectedProgram != null && _selectedDate != null)
            TextButton(
                onPressed: () {
                  ProviderScope.containerOf(context)
                      .read(assignProgramViewModelProvider.notifier)
                      .updateClientProgram(
                          _selectedProgram!,
                          '${_selectedDate?.day ?? 0}/${_selectedDate?.month ?? 0}/${_selectedDate?.year ?? 0}',
                          widget.client.userId ?? '');
                },
                child: Text(
                  'Assign',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.secondary),
                ))
        ],
      ),
      body: SafeArea(
          minimum: EdgeInsets.symmetric(vertical: 3.h, horizontal: 5.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                AppTextField(
                  isReadOnly: true,
                  onTap: () {
                    _showDatePicker(context);
                  },
                  controller: _selectedDateController,
                  inputType: TextInputType.text,
                  label: 'Start Date'.tr(),
                ).paddingBottom(1.h),
                if (_selectedDate != null)
                  SizedBox(
                    height: 25.h,
                    child: AppCard(
                      externalPadding: EdgeInsets.zero,
                      child: Column(
                        children: [
                          AppTextField(
                            prefix: const Icon(Icons.search_sharp),
                            controller: _searchController,
                            inputType: TextInputType.text,
                            onChanged: (txt) {
                              setState(() {
                                _filteredPrograms = _programs
                                    ?.where((element) => element.title!
                                        .toLowerCase()
                                        .contains(txt.toLowerCase()))
                                    .toList();
                              });
                            },
                            label: 'search'.tr(),
                          ).paddingBottom(1.h),
                          Expanded(
                            child: GridView(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 2,
                                      crossAxisSpacing: 1.h,
                                      mainAxisSpacing: 1.h),
                              children: [
                                if (_filteredPrograms != null)
                                  ..._filteredPrograms!.map((e) {
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _selectedProgram = e;
                                        });
                                      },
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(1.h),
                                          child: Container(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary
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
                                          )),
                                    );
                                  }).toList()
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                if (_selectedProgram != null && _selectedDate != null)
                  ProgramDetailsScreen(
                    programArgs: ProgramDetailsArgs(
                        program: _selectedProgram, startDate: _selectedDate),
                  )
              ],
            ),
          )),
    );
  }

  void _showDurationPicker(BuildContext ctx) {
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
                    _durationController.text = (value + 1).toString();
                  });
                },
              ),
            ));
  }

  void _showDatePicker(BuildContext ctx) {
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => SizedBox(
            height: 40.h,
            child: CupertinoDatePicker(
              showDayOfWeek: true,
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (value) {
                setState(() {
                  _selectedDate = value;
                  _selectedDateController.text = value.toString();
                });
              },
              minimumDate: DateTime.now(),
            )));
  }
}
