enum UserFieldType {
  email,
  password,
  confirmPassword,
  firstName,
  lastName,
  age,
  unknown
}

extension UserFieldsExtension on UserFieldType {
  String get field {
    switch (this) {
      case UserFieldType.email:
        return 'email';
      case UserFieldType.password:
        return 'password';
      case UserFieldType.confirmPassword:
        return 'confrim_password';
      case UserFieldType.firstName:
        return 'first_name';
      case UserFieldType.lastName:
        return 'last_name';
      case UserFieldType.age:
        return 'age';
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
        return UserFieldType.confirmPassword;
      case 'first_name':
        return UserFieldType.firstName;
      case 'last_name':
        return UserFieldType.lastName;
      case 'age':
        return UserFieldType.age;
      default:
        return UserFieldType.unknown;
    }
  }
}
