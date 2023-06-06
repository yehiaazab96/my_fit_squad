enum MuscleGroup {
  chest,
  back,
  arms,
  shoulders,
  legs;

  static MuscleGroup getMuscleGroup(String category) {
    switch (category) {
      case 'Chest':
        return MuscleGroup.chest;
      case 'Arms':
        return MuscleGroup.arms;
      case 'Back':
        return MuscleGroup.back;
      case 'Shoulders':
        return MuscleGroup.shoulders;
      case 'Legs':
        return MuscleGroup.legs;
      default:
        return MuscleGroup.chest;
    }
  }

  String get title {
    switch (this) {
      case chest:
        return "Chest";
      case back:
        return "Back";
      case arms:
        return "Arms";
      case shoulders:
        return "Shoulders";
      case legs:
        return "Legs";
      default:
        return '';
    }
  }
}
