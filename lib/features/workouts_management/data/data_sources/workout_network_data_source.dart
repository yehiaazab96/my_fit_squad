import 'package:my_fit_squad/common/api/api_methods.dart';
import 'package:my_fit_squad/common/api/api_urls.dart';
import 'package:my_fit_squad/features/base/data/helpers/base_api_result.dart';
import 'package:my_fit_squad/features/workouts_management/data/model/workout.dart';

class WorkoutsNetworkDataSource {
  Future<BaseApiResult<List<Workout>>> getWorkouts() async {
    return await ApiMethods<Workout>().getList(
      ApiUrls.workouts,
    );
  }
}
