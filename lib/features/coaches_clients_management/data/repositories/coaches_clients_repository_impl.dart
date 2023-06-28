import 'package:my_fit_squad/features/base/data/helpers/base_api_result.dart';
import 'package:my_fit_squad/features/coaches_clients_management/data/data_sources/coaches_clients_network_data_source.dart';
import 'package:my_fit_squad/features/user_management/data/model/user_model.dart';

class CoachesAndClientsRepositoryImpl {
  CoachesAndClientsNetworkDataSource networkDataSource;

  CoachesAndClientsRepositoryImpl(this.networkDataSource);

  Future<BaseApiResult<List<User>>> getClients() async {
    return await networkDataSource.getClients();
  }

  Future<BaseApiResult<List<User>>> getCoaches() async {
    return await networkDataSource.getCoaches();
  }
}
