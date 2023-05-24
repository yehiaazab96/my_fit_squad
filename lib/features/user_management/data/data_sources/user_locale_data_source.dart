import 'dart:convert';

import 'package:my_fit_squad/features/user_management/data/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _CACHED_USER = 'user';

const _firebaseToken = 'firebaseToken';

class UserLocaleDataSource {
  SharedPreferences preferences;

  UserLocaleDataSource(this.preferences);

  void saveUser(User userData) async {
    String userJson = jsonEncode(User.fromJson(userData.toJson()));
    preferences.setString(_CACHED_USER, userJson);
  }

  User? getUser() {
    var userData = preferences.getString(_CACHED_USER);
    if (userData != null) {
      Map userMap = jsonDecode(userData);
      User user = User.fromJson(userMap as Map<String, dynamic>);
      return user;
    }
    return null;
  }

  Future<void> removeUser() async {
    preferences.remove(_CACHED_USER);
  }
}
