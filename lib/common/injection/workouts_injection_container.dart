import 'package:my_fit_squad/features/base/data/helpers/base_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_fit_squad/features/workouts_management/data/data_sources/workout_network_data_source.dart';
import 'package:my_fit_squad/features/workouts_management/data/repositories/workout_repository_impl.dart';
import 'package:my_fit_squad/features/workouts_management/presentation/global_states/workouts_state.dart';
import 'package:my_fit_squad/features/workouts_management/presentation/view_models/workouts_view_model.dart';

//Workouts

final workoutsNetworkDataSourceProvider =
    Provider<WorkoutsNetworkDataSource>((ref) {
  return WorkoutsNetworkDataSource();
});

final workoutsRepositoryProvider = Provider<WorkoutRepositoryImpl>((ref) {
  return WorkoutRepositoryImpl(ref.read(workoutsNetworkDataSourceProvider));
});

final workoutsViewModelProvider =
    StateNotifierProvider<WorkoutsViewModel, BaseState<WorkoutsState>>((ref) {
  return WorkoutsViewModel(
    ref.read(workoutsRepositoryProvider),
  );
});
