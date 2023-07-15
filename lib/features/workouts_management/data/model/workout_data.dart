import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_fit_squad/common/constants/constants.dart';
import 'package:my_fit_squad/common/injection/injection_container.dart';
import 'package:my_fit_squad/features/workouts_management/helpers/muscle_group.dart';
import 'package:my_fit_squad/features/workouts_management/helpers/workout_category.dart';

class WorkoutData {
  String? title;
  String? description;
  XFile? image;
  WorkoutCategory? category;
  MuscleGroup? muscleGroup;
  String? createdBy;

  WorkoutData(
      {this.title,
      this.image,
      this.category,
      this.description,
      this.muscleGroup,
      this.createdBy});

  Future<FormData> toFormData() async {
    final Map<String, dynamic> data = {};
    data['title'] = title;
    data['description'] = description;
    data['category'] = category?.title;
    data['muscle_group'] = muscleGroup?.title;

    if (image != null) {
      File file = File(image!.path);
      String fileName = file.path.split('/').last;

      data['image'] = await MultipartFile.fromFile(
        file.path,
        filename: fileName,
      );
    }
    var user = ProviderScope.containerOf(Constants.navigatorKey.currentContext!)
        .read(userProvider);
    if (user?.role == 'super-admin') {
      data['under_review'] = false;
    } else {
      data['under_review'] = true;
    }
    if (user != null) {
      data['added_by'] = ('${user.firstName ?? ''} ${user.lastName ?? ''}');
    }
    FormData formdata = FormData.fromMap(data);

    return formdata;
  }
}
