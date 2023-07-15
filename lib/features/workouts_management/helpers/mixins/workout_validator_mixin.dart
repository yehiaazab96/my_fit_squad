import 'package:easy_localization/easy_localization.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_fit_squad/features/base/data/models/forms_errors.dart';
import 'package:my_fit_squad/features/workouts_management/data/model/class_workout.dart';
import 'package:my_fit_squad/features/workouts_management/data/model/program_class.dart';
import 'package:my_fit_squad/features/workouts_management/helpers/extensions/workout_fields_extension.dart';

mixin WorkoutValidatorMixin {
  List<BaseFormError> validateWorkoutFields(
      {String? title,
      String? description,
      XFile? image,
      bool? validateImage = false,
      List<ClassWorkout>? classWorkouts,
      List<ProgramClass?>? programClasses}) {
    List<BaseFormError> errors = [];
    if (title != null) {
      if (title.isEmpty) {
        errors.add(BaseFormError(
            field: WorkoutFieldType.title.field, message: "emptyTitle".tr()));
      }
    }
    if (description != null) {
      if (description.isEmpty) {
        errors.add(BaseFormError(
            field: WorkoutFieldType.description.field,
            message: "emptyDescription".tr()));
      }
    }

    if (image == null && validateImage!) {
      errors.add(BaseFormError(
          field: WorkoutFieldType.image.field, message: "emptyImage".tr()));
    }
    if (classWorkouts != null) {
      print(classWorkouts.length);
      if (classWorkouts.isEmpty || classWorkouts.length < 2) {
        errors.add(BaseFormError(
            field: WorkoutFieldType.classWorkouts.field,
            message: "notEnoughtWorkouts".tr()));
      }
    }

    if (programClasses != null) {
      programClasses.remove(null);
      if (programClasses.isEmpty || programClasses.length < 2) {
        errors.add(BaseFormError(
            field: WorkoutFieldType.programClasses.field,
            message: "notEnoughtWorkouts".tr()));
      }
    }
    print(programClasses);
    errors.forEach((element) {
      print(element.field);
      print(element.message);
    });

    return errors;
  }
}
