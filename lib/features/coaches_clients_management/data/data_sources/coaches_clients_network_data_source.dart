import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_fit_squad/common/api/api_methods.dart';
import 'package:my_fit_squad/common/api/api_urls.dart';
import 'package:my_fit_squad/common/constants/constants.dart';
import 'package:my_fit_squad/common/injection/injection_container.dart';
import 'package:my_fit_squad/features/base/data/helpers/base_api_result.dart';
import 'package:my_fit_squad/features/user_management/data/model/message.dart';
import 'package:my_fit_squad/features/user_management/data/model/user_model.dart';
import 'package:my_fit_squad/features/workouts_management/data/model/program.dart';

class CoachesAndClientsNetworkDataSource {
  Future<BaseApiResult<List<User>>> getCoaches() async {
    return await ApiMethods<User>()
        .getList(ApiUrls.user + ApiUrls.coaches, hasToken: true);
  }

  Future<BaseApiResult<List<User>>> getClients() async {
    return await ApiMethods<User>()
        .getList(ApiUrls.user + ApiUrls.clients, hasToken: true);
  }

  Future<BaseApiResult<User>> updateClientWithProgram(
      Program program, String startDate, String clientID) async {
    return await ApiMethods<User>().post(
      '${ApiUrls.user}${ApiUrls.clients}/$clientID',
      hasToken: true,
      data: {'program': program.toJson(), 'start_date': startDate},
    );
  }

  Future<BaseApiResult<ResponseMessage>> requestToJoinSquad(
      {String? coachID, bool? status}) async {
    var user = ProviderScope.containerOf(Constants.navigatorKey.currentContext!)
        .read(userProvider);
    print(user?.userId);
    return await ApiMethods<ResponseMessage>().post(
        '${ApiUrls.user}${ApiUrls.clients}${ApiUrls.requestPending}/${user?.userId ?? ''}',
        data: {'request_pending': status, 'coach_id': coachID},
        hasToken: true);
  }

  Future<BaseApiResult<ResponseMessage>> respondToJoinRequest(
      {String? clientId, bool? respond}) async {
    var user = ProviderScope.containerOf(Constants.navigatorKey.currentContext!)
        .read(userProvider);
    return await ApiMethods<ResponseMessage>().post(
        '${ApiUrls.user}${ApiUrls.coaches}${ApiUrls.joinRequestRespond}/${user?.userId ?? ''}',
        data: {'request_response': respond, 'client_id': clientId},
        hasToken: true);
  }
}
