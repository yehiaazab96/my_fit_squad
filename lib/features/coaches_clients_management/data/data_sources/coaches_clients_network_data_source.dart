import 'package:my_fit_squad/common/api/api_methods.dart';
import 'package:my_fit_squad/common/api/api_urls.dart';
import 'package:my_fit_squad/features/base/data/helpers/base_api_result.dart';
import 'package:my_fit_squad/features/user_management/data/model/user_model.dart';

class CoachesAndClientsNetworkDataSource {
  Future<BaseApiResult<List<User>>> getCoaches() async {
    return await ApiMethods<User>()
        .getList(ApiUrls.user + ApiUrls.coaches, hasToken: true);
  }

  Future<BaseApiResult<List<User>>> getClients() async {
    return await ApiMethods<User>()
        .getList(ApiUrls.user + ApiUrls.clients, hasToken: true);
  }
}
