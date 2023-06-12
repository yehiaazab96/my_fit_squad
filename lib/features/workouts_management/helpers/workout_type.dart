enum WorkoutType {
  reps,
  seconds,
  ;

  static WorkoutType getWorkoutType(String type) {
    switch (type) {
      case 'reps':
        return WorkoutType.reps;
      case 'seconds':
        return WorkoutType.seconds;
      default:
        return WorkoutType.reps;
    }
  }

  String get title {
    switch (this) {
      case reps:
        return "Reps";
      case seconds:
        return "Seconds";
      default:
        return '';
    }
  }
}
