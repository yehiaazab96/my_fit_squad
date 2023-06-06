class User {
  int? userId;
  String? firstName;
  String? lastName;
  String? email;
  String? displayName;
  String? birthDay;
  String? accessToken;
  String? refreshToken;
  User({
    this.userId,
    this.firstName,
    this.lastName,
    this.birthDay,
    this.accessToken,
    this.displayName,
    this.refreshToken,
    this.email,
  });

  User.fromJson(Map<String, dynamic> json) {
    userId = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    birthDay = json['birthday'];
    displayName = json['display_name'];
    accessToken = json['token'];
    refreshToken = json['refresh_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = userId;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['display_name'] = displayName;
    data['birthday'] = birthDay;
    data['token'] = accessToken;
    data['refresh_token'] = refreshToken;
    return data;
  }

  copyWith(
      {int? userId,
      String? firstName,
      String? lastName,
      String? email,
      String? displayName,
      String? birthDay,
      String? accessToken,
      String? refreshToken,
      int? isVendor,
      int? isStaff,
      var staffId}) {
    this.userId = userId ?? this.userId;
    this.firstName = firstName ?? this.firstName;
    this.lastName = lastName ?? this.lastName;
    this.email = email ?? this.email;
    this.displayName = displayName ?? this.displayName;
    this.birthDay = birthDay ?? this.birthDay;
    this.accessToken = accessToken ?? this.accessToken;
    this.refreshToken = refreshToken ?? this.refreshToken;
  }
}
