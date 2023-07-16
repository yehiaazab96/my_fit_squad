import 'package:my_fit_squad/features/workouts_management/data/model/program.dart';

class ProgramDetailsArgs {
  Program? program;
  String? startDateString;
  DateTime? startDate;

  ProgramDetailsArgs({this.program, this.startDateString, this.startDate});
}
