import 'package:my_fit_squad/features/base/data/helpers/base_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_fit_squad/features/coaches_clients_management/data/data_sources/coaches_clients_network_data_source.dart';
import 'package:my_fit_squad/features/coaches_clients_management/data/repositories/coaches_clients_repository_impl.dart';
import 'package:my_fit_squad/features/coaches_clients_management/presentation/global_states/client_state.dart';
import 'package:my_fit_squad/features/coaches_clients_management/presentation/global_states/coaches_state.dart';
import 'package:my_fit_squad/features/coaches_clients_management/presentation/view_models/clients_view_model.dart';
import 'package:my_fit_squad/features/coaches_clients_management/presentation/view_models/coaches_view_model.dart';
import 'package:my_fit_squad/features/workouts_management/data/data_sources/workout_network_data_source.dart';
import 'package:my_fit_squad/features/workouts_management/data/repositories/workout_repository_impl.dart';
import 'package:my_fit_squad/features/workouts_management/helpers/workout_screen_type.dart';
import 'package:my_fit_squad/features/workouts_management/presentation/global_states/categories_state.dart';
import 'package:my_fit_squad/features/workouts_management/presentation/global_states/classes_state.dart';
import 'package:my_fit_squad/features/workouts_management/presentation/global_states/programs_state.dart';
import 'package:my_fit_squad/features/workouts_management/presentation/global_states/workouts_state.dart';
import 'package:my_fit_squad/features/workouts_management/presentation/view_models/categories_view_model%20copy.dart';
import 'package:my_fit_squad/features/workouts_management/presentation/view_models/classes_view_model.dart';
import 'package:my_fit_squad/features/workouts_management/presentation/view_models/programs_view_model.dart';
import 'package:my_fit_squad/features/workouts_management/presentation/view_models/workouts_screens_view_model%20copy.dart';
import 'package:my_fit_squad/features/workouts_management/presentation/view_models/workouts_view_model.dart';

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
