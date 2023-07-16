import 'package:my_fit_squad/features/base/data/helpers/base_api_result.dart';
import 'package:my_fit_squad/features/coaches_clients_management/data/data_sources/coaches_clients_network_data_source.dart';
import 'package:my_fit_squad/features/user_management/data/model/message.dart';
import 'package:my_fit_squad/features/user_management/data/model/user_model.dart';
import 'package:my_fit_squad/features/workouts_management/data/model/program.dart';

class CoachesAndClientsRepositoryImpl {
  CoachesAndClientsNetworkDataSource networkDataSource;

  CoachesAndClientsRepositoryImpl(this.networkDataSource);

  Future<BaseApiResult<List<User>>> getClients() async {
    return await networkDataSource.getClients();
  }

  Future<BaseApiResult<List<User>>> getCoaches() async {
    return await networkDataSource.getCoaches();
  }

  Future<BaseApiResult<ResponseMessage>> requestToJoinSquad(
      {String? coachID, bool? status}) async {
    return await networkDataSource.requestToJoinSquad(
        coachID: coachID, status: status);
  }

  Future<BaseApiResult<ResponseMessage>> respondToJoinrequest(
      {String? clientID, bool? respond}) async {
    return await networkDataSource.respondToJoinRequest(
        clientId: clientID, respond: respond);
  }

  Future<BaseApiResult<User>> updateClientWithProgram(
      Program program, String startDate, String clientID) async {
    return await networkDataSource.updateClientWithProgram(
        program, startDate, clientID);
  }
}
