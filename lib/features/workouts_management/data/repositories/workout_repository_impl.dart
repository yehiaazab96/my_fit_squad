import 'package:my_fit_squad/features/base/data/helpers/base_api_result.dart';
import 'package:my_fit_squad/features/workouts_management/data/data_sources/workout_network_data_source.dart';
import 'package:my_fit_squad/features/workouts_management/data/model/workout.dart';

class WorkoutRepositoryImpl {
  WorkoutsNetworkDataSource networkDataSource;

  WorkoutRepositoryImpl(this.networkDataSource);

  Future<BaseApiResult<List<Workout>>> getWorkouts() async {
    return await networkDataSource.getWorkouts();
  }
}
