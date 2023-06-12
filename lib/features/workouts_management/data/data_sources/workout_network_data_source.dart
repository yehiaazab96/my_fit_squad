import 'package:my_fit_squad/common/api/api_methods.dart';
import 'package:my_fit_squad/common/api/api_urls.dart';
import 'package:my_fit_squad/features/base/data/helpers/base_api_result.dart';
import 'package:my_fit_squad/features/workouts_management/data/model/program.dart';
import 'package:my_fit_squad/features/workouts_management/data/model/class.dart';
import 'package:my_fit_squad/features/workouts_management/data/model/workout.dart';
import 'package:my_fit_squad/features/workouts_management/helpers/workout_category.dart';

class WorkoutsNetworkDataSource {
  Future<BaseApiResult<List<WorkoutCategory>>> getCategories() async {
    return await ApiMethods<WorkoutCategory>().getList(
      ApiUrls.categories,
    );
  }

  Future<BaseApiResult<List<Workout>>> getWorkouts(
      {WorkoutCategory? category}) async {
    return await ApiMethods<Workout>().getList(
      ApiUrls.workouts +
          (category?.title != null ? '/${category?.title ?? ''}' : ''),
    );
  }

  Future<BaseApiResult<List<Class>>> getClasses() async {
    return await ApiMethods<Class>().getList(ApiUrls.classes);
  }

  Future<BaseApiResult<List<Program>>> getPrograms() async {
    return await ApiMethods<Program>().getList(ApiUrls.programs);
  }
}
