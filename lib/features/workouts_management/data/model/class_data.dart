import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_fit_squad/common/constants/constants.dart';
import 'package:my_fit_squad/common/injection/user_injection_container.dart';
import 'package:my_fit_squad/features/workouts_management/data/model/class_workout.dart';

class ClassData {
  String? title;
  String? description;
  List<ClassWorkout>? classWorkout;

  ClassData({
    this.title,
    this.description,
    this.classWorkout,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['title'] = title;
    data['description'] = description;
    data['workouts'] = classWorkout?.map((e) => e.toJson()).toList();

    var user = ProviderScope.containerOf(Constants.navigatorKey.currentContext!)
        .read(userProvider);

    if (user != null) {
      data['created_by'] = user.userId;
    }

    return data;
  }
}
