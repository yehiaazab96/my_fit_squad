import 'package:my_fit_squad/common/api/api_methods.dart';
import 'package:my_fit_squad/common/api/api_urls.dart';
import 'package:my_fit_squad/features/base/data/helpers/base_api_result.dart';
import 'package:my_fit_squad/features/user_management/data/model/user_model.dart';

class UserNetworkDataSource {
  Future<BaseApiResult<User>> login(String email, String password) async {
    return await ApiMethods<User>().post(ApiUrls.user + ApiUrls.login,
        hasToken: false, data: {'email': email, 'password': password});
  }

  Future<BaseApiResult<User>> getUserRemoteProfile(String id) async {
    return await ApiMethods<User>().get('', hasToken: true);
  }
}
