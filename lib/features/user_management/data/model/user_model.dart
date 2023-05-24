class User {
  int? userId;
  String? firstName;
  String? lastName;
  String? email;
  String? displayName;
  String? birthDay;
  String? accessToken;
  String? refreshToken;
  var staffId;
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
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
    staffId = json['staff_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.userId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['display_name'] = this.displayName;
    data['birthday'] = this.birthDay;
    data['access_token'] = this.accessToken;
    data['refresh_token'] = this.refreshToken;
    data['staff_id'] = this.staffId;
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
    this.staffId = staffId ?? this.staffId;
  }
}
