import 'package:my_fit_squad/features/user_management/data/model/user_model.dart';

class ProfileState {
  User? user;
  ProfileState({
    this.user,
  });

  ProfileState copyWith({User? user}) {
    return ProfileState(
      user: user ?? this.user,
    );
  }
}
