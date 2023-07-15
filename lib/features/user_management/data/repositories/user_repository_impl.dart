import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_fit_squad/features/base/data/helpers/base_api_result.dart';
import 'package:my_fit_squad/features/user_management/data/data_sources/user_locale_data_source.dart';
import 'package:my_fit_squad/features/user_management/data/data_sources/user_network_data_source.dart';
import 'package:my_fit_squad/features/user_management/data/model/user_model.dart';

class UserRepositoryImpl {
  UserLocaleDataSource localeDataSource;
  UserNetworkDataSource networkDataSource;

  UserRepositoryImpl(this.localeDataSource, this.networkDataSource);

  Future<BaseApiResult<User>> login(String email, String password) async {
    return await networkDataSource.login(email, password);
  }

  Future<BaseApiResult<User>> getUserProfile(String id) async {
    return await networkDataSource.getUser(id);
  }

  Future<BaseApiResult<User>> signUp(User user, {XFile? profileImage}) async {
    return await networkDataSource.signUp(user, profileImage: profileImage);
  }

  Future<void> setLocalUserProfile(User? userData) async {
    if (userData != null) {
      localeDataSource.saveUser(userData);
    }
  }

  Future<User?> getLocalUserProfile() async {
    return localeDataSource.getUser();
  }

  Future<void> removeLocalUserProfile() {
    return localeDataSource.removeUser();
  }
}
