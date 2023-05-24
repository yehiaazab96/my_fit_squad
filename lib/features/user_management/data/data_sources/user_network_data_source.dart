import 'package:my_fit_squad/common/api/api_methods.dart';
import 'package:my_fit_squad/features/base/data/helpers/base_api_result.dart';
import 'package:my_fit_squad/features/user_management/data/model/user_model.dart';

class UserNetworkDataSource {
  Future<BaseApiResult<User>> getUserRemoteProfile(String id) async {
    return await ApiMethods<User>().get('', hasToken: true);
  }
}
