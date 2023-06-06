enum WorkoutCategory {
  muscleGain,
  fatLoss,
  rehabilitation,
  athlete;

  static WorkoutCategory getWorkoutCategory(String category) {
    switch (category) {
      case 'Muscle Gain':
        return WorkoutCategory.muscleGain;
      case 'Fat Loss':
        return WorkoutCategory.fatLoss;
      case 'Rehabilitation':
        return WorkoutCategory.rehabilitation;
      case 'Athlete':
        return WorkoutCategory.athlete;
      default:
        return WorkoutCategory.muscleGain;
    }
  }

  String get title {
    switch (this) {
      case muscleGain:
        return "Muscle Gain";
      case fatLoss:
        return "Fat Loss";
      case rehabilitation:
        return "Rehabilitation";
      case athlete:
        return "Athlete";
      default:
        return '';
    }
  }
}
