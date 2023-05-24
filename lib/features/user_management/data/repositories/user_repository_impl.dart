import 'package:my_fit_squad/features/base/data/helpers/base_api_result.dart';
import 'package:my_fit_squad/features/user_management/data/data_sources/user_locale_data_source.dart';
import 'package:my_fit_squad/features/user_management/data/data_sources/user_network_data_source.dart';
import 'package:my_fit_squad/features/user_management/data/model/user_model.dart';

class UserRepositoryImpl {
  UserLocaleDataSource localeDataSource;
  UserNetworkDataSource networkDataSource;

  UserRepositoryImpl(this.localeDataSource, this.networkDataSource);

  Future<BaseApiResult<User>> getUserRemoteProfile(String id) async {
    return await networkDataSource.getUserRemoteProfile(id);
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
