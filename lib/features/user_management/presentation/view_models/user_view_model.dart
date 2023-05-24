import 'package:my_fit_squad/features/base/presentation/view_models/base_view_model.dart';
import 'package:my_fit_squad/features/user_management/data/model/user_model.dart';
import 'package:my_fit_squad/features/user_management/data/repositories/user_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserViewModel extends StateNotifier<User?> with BaseViewModel {
  final UserRepositoryImpl _userRepositoryImpl;

  UserViewModel(
    this._userRepositoryImpl,
  ) : super(null);

  Future<User?> getLocalUserProfile() async {
    User? userData = await _userRepositoryImpl.getLocalUserProfile();
    state = userData;

    print(state?.accessToken);
    return state;
  }

  void setLocalUserProfile(User? user) {
    _userRepositoryImpl.setLocalUserProfile(user);

    state = user;
  }

  Future signout() async {
    resetUserState();
    setLocalUserProfile(User());

    // navigateToScreen((context) => LoginScreen(), removeTop: true);
  }

  void setState(User? user) {
    // state = user;
    setLocalUserProfile(user);
  }

  void resetUserState() {
    state = User();
    // Constants.navigatorKey.currentContext!
    //     .read(di.selectedNavigationItemTypeProvider)
    //     .state = BottomNavigationItemType.bookings;
  }
}
