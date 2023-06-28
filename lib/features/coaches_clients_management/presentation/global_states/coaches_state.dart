import 'package:my_fit_squad/features/user_management/data/model/user_model.dart';

class CoachesState {
  List<User> coaches;
  CoachesState({
    this.coaches = const [],
  });

  CoachesState copyWith({List<User>? coaches}) {
    return CoachesState(
      coaches: coaches ?? this.coaches,
    );
  }
}
