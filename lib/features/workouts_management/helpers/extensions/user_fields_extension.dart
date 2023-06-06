enum UserFieldType { email, password, unknown }

extension UserFieldsExtension on UserFieldType {
  String get field {
    switch (this) {
      case UserFieldType.email:
        return 'email';
      case UserFieldType.password:
        return 'password';
      default:
        return '';
    }
  }

  static UserFieldType getEnum(String field) {
    switch (field) {
      case 'email':
        return UserFieldType.email;
      case 'password':
        return UserFieldType.password;
      case 'confirm_password':
      default:
        return UserFieldType.unknown;
    }
  }
}
