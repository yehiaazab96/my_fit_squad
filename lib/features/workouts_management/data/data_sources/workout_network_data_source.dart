import 'dart:io';

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_fit_squad/common/api/api_methods.dart';
import 'package:my_fit_squad/common/api/api_urls.dart';
import 'package:my_fit_squad/features/base/data/helpers/base_api_result.dart';
import 'package:my_fit_squad/features/user_management/data/model/message.dart';
import 'package:my_fit_squad/features/workouts_management/data/model/class_data.dart';
import 'package:my_fit_squad/features/workouts_management/data/model/program.dart';
import 'package:my_fit_squad/features/workouts_management/data/model/class.dart';
import 'package:my_fit_squad/features/workouts_management/data/model/program_data.dart';
import 'package:my_fit_squad/features/workouts_management/data/model/workout.dart';
import 'package:my_fit_squad/features/workouts_management/data/model/workout_data.dart';
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

  Future<BaseApiResult<Workout>> addWorkout({required WorkoutData data}) async {
    FormData formData = await data.toFormData();
    return await ApiMethods<Workout>()
        .postWithFormData(ApiUrls.workouts, data: formData);
  }

  Future<BaseApiResult<ResponseMessage>> updateWorkoutWithMedia(
      {required String id, required List<XFile> files}) async {
    var image = files.first;
    File file = File(image.path);
    String fileName = file.path.split('/').last;

    var data = await MultipartFile.fromFile(
      file.path,
      filename: fileName,
    );

    var map = {
      'files': [data]
    };

    FormData formData = FormData.fromMap(map);
    return await ApiMethods<ResponseMessage>()
        .patchWithFormData(ApiUrls.media + id, data: formData);
  }

  Future<BaseApiResult<List<Class>>> getClasses() async {
    return await ApiMethods<Class>().getList(ApiUrls.classes);
  }

  Future<BaseApiResult<Class>> addClass({required ClassData data}) async {
    return await ApiMethods<Class>().post(ApiUrls.classes, data: data.toJson());
  }

  Future<BaseApiResult<List<Program>>> getPrograms() async {
    return await ApiMethods<Program>().getList(ApiUrls.programs);
  }

  Future<BaseApiResult<Program>> addProgram({required ProgramData data}) async {
    return await ApiMethods<Program>()
        .post(ApiUrls.programs, data: data.toJson());
  }
}
