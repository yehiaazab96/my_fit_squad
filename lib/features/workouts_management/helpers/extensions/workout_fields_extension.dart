enum WorkoutFieldType {
  title,
  description,
  image,
  classWorkouts,
  programClasses,
  unknown
}

extension WorkoutFieldExtension on WorkoutFieldType {
  String get field {
    switch (this) {
      case WorkoutFieldType.title:
        return 'title';
      case WorkoutFieldType.description:
        return 'description';
      case WorkoutFieldType.image:
        return 'image';
      case WorkoutFieldType.classWorkouts:
        return 'classWorkouts';
      case WorkoutFieldType.programClasses:
        return 'programClasses';
      default:
        return '';
    }
  }

  static WorkoutFieldType getEnum(String field) {
    switch (field) {
      case 'title':
        return WorkoutFieldType.title;
      case 'description':
        return WorkoutFieldType.description;
      case 'image':
        return WorkoutFieldType.image;
      case 'classWorkouts':
        return WorkoutFieldType.classWorkouts;
      case 'programClasses':
        return WorkoutFieldType.programClasses;
      default:
        return WorkoutFieldType.unknown;
    }
  }
}
