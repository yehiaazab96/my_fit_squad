import 'package:my_fit_squad/features/workouts_management/data/model/program.dart';

class ProgramsState {
  List<Program> programs;
  ProgramsState({
    this.programs = const [],
  });

  ProgramsState copyWith({
    List<Program>? programs,
  }) {
    return ProgramsState(
      programs: programs ?? this.programs,
    );
  }
}
