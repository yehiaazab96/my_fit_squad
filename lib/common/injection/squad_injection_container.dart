import 'package:my_fit_squad/features/base/data/helpers/base_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_fit_squad/features/coaches_clients_management/data/data_sources/coaches_clients_network_data_source.dart';
import 'package:my_fit_squad/features/coaches_clients_management/data/repositories/coaches_clients_repository_impl.dart';
import 'package:my_fit_squad/features/coaches_clients_management/presentation/global_states/client_state.dart';
import 'package:my_fit_squad/features/coaches_clients_management/presentation/global_states/coaches_state.dart';
import 'package:my_fit_squad/features/coaches_clients_management/presentation/view_models/clients_view_model.dart';
import 'package:my_fit_squad/features/coaches_clients_management/presentation/view_models/coaches_view_model.dart';

final squadNetworkDataSourceProvider =
    Provider<CoachesAndClientsNetworkDataSource>((ref) {
  return CoachesAndClientsNetworkDataSource();
});

final squadRepositoryProvider =
    Provider<CoachesAndClientsRepositoryImpl>((ref) {
  return CoachesAndClientsRepositoryImpl(
      ref.read(squadNetworkDataSourceProvider));
});

final coachesViewModelProvider =
    StateNotifierProvider<CoachesViewModel, BaseState<CoachesState>>((ref) {
  return CoachesViewModel(
    ref.read(squadRepositoryProvider),
  );
});

final clientsViewModelProvider =
    StateNotifierProvider<ClientsViewModl, BaseState<Clientstate>>((ref) {
  return ClientsViewModl(
    ref.read(squadRepositoryProvider),
  );
});
