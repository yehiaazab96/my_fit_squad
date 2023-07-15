import 'package:my_fit_squad/features/base/presentation/view_models/base_view_model.dart';
import 'package:my_fit_squad/features/user_management/data/model/user_model.dart';
import 'package:my_fit_squad/features/user_management/data/repositories/user_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserViewModel extends StateNotifier<User?> with BaseViewModel {
  final UserRepositoryImpl _userRepositoryImpl;

  UserViewModel(
    this._userRepositoryImpl,
  ) : super(null) {
    // signout();
    getLocalUserProfile();
  }

  Future<User?> getLocalUserProfile() async {
    User? userData = await _userRepositoryImpl.getLocalUserProfile();
    state = userData;
    print(state?.accessToken);
    return state;
  }

  Future<User?> login(String email, String password) async {
    var userData = await _userRepositoryImpl.login(email, password);
    if (userData.data != null) {
      state = userData.data;
      print(state?.accessToken);
      return state;
    }
    return null;
  }

  void setLocalUserProfile(User? user) {
    state = user;
    _userRepositoryImpl.setLocalUserProfile(user);
  }

  Future signout() async {
    resetUserState();
    setLocalUserProfile(User());
  }

  void setState(User? user) {
    setLocalUserProfile(user);
  }

  changeRequestStatus(bool? status) {
    var user = state;
    user?.requestPending = status;
    state = user;
    setLocalUserProfile(user);
  }

  void resetUserState() {
    state = User();
  }
}
