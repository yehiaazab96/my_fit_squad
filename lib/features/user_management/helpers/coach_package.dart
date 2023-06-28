enum CoachPackages {
  free,
  silver,
  gold,
  platinum;

  String get title {
    switch (this) {
      case free:
        return 'Free';
      case silver:
        return 'Silver';
      case gold:
        return 'Gold';
      case platinum:
        return 'Platinum';
      default:
        return '';
    }
  }

  double get price {
    switch (this) {
      case free:
        return 0;
      case silver:
        return 249;
      case gold:
        return 499;
      case platinum:
        return 999;
      default:
        return 0;
    }
  }

  double get clients {
    switch (this) {
      case free:
        return 1;
      case silver:
        return 5;
      case gold:
        return 15;
      case platinum:
        return 30;
      default:
        return 1;
    }
  }

  String get pricePerMonth {
    return '$price EGP \n/ Month';
  }

  String get clientDisplay {
    return '$clients Clients';
  }

  static CoachPackages fromString(String? plan) {
    switch (plan) {
      case 'Free':
        return CoachPackages.free;
      case 'Silver':
        return CoachPackages.silver;
      case 'Gold':
        return CoachPackages.gold;
      case 'Platinum':
        return CoachPackages.platinum;
      default:
        return CoachPackages.free;
    }
  }
}
