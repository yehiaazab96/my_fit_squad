import 'package:my_fit_squad/features/workouts_management/data/model/program.dart';

class CurrentProgram {
  Program? program;
  String? startDate;
  CurrentProgram({
    this.program,
    this.startDate,
  });

  CurrentProgram.fromJson(Map<String, dynamic> json) {
    startDate = json['start_date'];
    program = Program.fromJson(json['program']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['start_date'] = startDate;
    data['program'] = program?.toJson();

    return data;
  }

  copyWith({
    String? startDate,
    Program? program,
  }) {
    this.startDate = startDate ?? this.startDate;
    this.program = program ?? this.program;
  }
}
