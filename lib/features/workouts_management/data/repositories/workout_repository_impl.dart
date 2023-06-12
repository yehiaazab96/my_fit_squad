import 'package:my_fit_squad/features/base/data/helpers/base_api_result.dart';
import 'package:my_fit_squad/features/workouts_management/data/data_sources/workout_network_data_source.dart';
import 'package:my_fit_squad/features/workouts_management/data/model/program.dart';
import 'package:my_fit_squad/features/workouts_management/data/model/class.dart';
import 'package:my_fit_squad/features/workouts_management/data/model/workout.dart';
import 'package:my_fit_squad/features/workouts_management/helpers/workout_category.dart';

class WorkoutRepositoryImpl {
  WorkoutsNetworkDataSource networkDataSource;

  WorkoutRepositoryImpl(this.networkDataSource);

  Future<BaseApiResult<List<WorkoutCategory>>> getCategories() async {
    return await networkDataSource.getCategories();
  }

  Future<BaseApiResult<List<Workout>>> getWorkouts(
      {WorkoutCategory? category}) async {
    return await networkDataSource.getWorkouts(category: category);
  }

  Future<BaseApiResult<List<Class>>> getClasses() async {
    return await networkDataSource.getClasses();
  }

  Future<BaseApiResult<List<Program>>> getPrograms() async {
    return await networkDataSource.getPrograms();
  }
}
