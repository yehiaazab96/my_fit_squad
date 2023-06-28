enum UserType {
  coach,
  client;

  String get role {
    switch (this) {
      case coach:
        return 'admin';
      case client:
        return 'client';
      default:
        return 'client';
    }
  }
}
