import 'package:my_fit_squad/features/base/data/helpers/base_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

//Workouts

final workoutsNetworkDataSourceProvider =
    Provider<WorkoutsNetworkDataSource>((ref) {
  return WorkoutsNetworkDataSource();
});

final workoutsRepositoryProvider = Provider<WorkoutRepositoryImpl>((ref) {
  return WorkoutRepositoryImpl(ref.read(workoutsNetworkDataSourceProvider));
});

final workoutScreenViewModelProvider =
    StateNotifierProvider<WorkoutsScreensViewModel, WorkoutScreenType>((ref) {
  return WorkoutsScreensViewModel();
});

final workoutsViewModelProvider =
    StateNotifierProvider<WorkoutsViewModel, BaseState<WorkoutsState>>((ref) {
  return WorkoutsViewModel(
    ref.read(workoutsRepositoryProvider),
  );
});

final classesViewModelProvider =
    StateNotifierProvider<ClassesViewModel, BaseState<ClassesState>>((ref) {
  return ClassesViewModel(
    ref.read(workoutsRepositoryProvider),
  );
});

final programsViewModelProvider =
    StateNotifierProvider<ProgramsViewModel, BaseState<ProgramsState>>((ref) {
  return ProgramsViewModel(
    ref.read(workoutsRepositoryProvider),
  );
});

final categoriesViewModelProvider =
    StateNotifierProvider<CategoriesViewModel, BaseState<CategoriesState>>(
        (ref) {
  return CategoriesViewModel(
    ref.read(workoutsRepositoryProvider),
  );
});
