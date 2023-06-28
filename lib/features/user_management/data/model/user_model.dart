import 'package:my_fit_squad/features/user_management/helpers/coach_package.dart';

class User {
  int? userId;
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? displayName;
  String? age;
  String? accessToken;
  String? refreshToken;
  String? role;
  String? coachCode;
  String? code;
  CoachPackages? subscribtionPlan;
  int? experinceYears;
  String? profileImage;

  User({
    this.userId,
    this.firstName,
    this.lastName,
    this.age,
    this.accessToken,
    this.password,
    this.displayName,
    this.refreshToken,
    this.email,
    this.role,
    this.coachCode,
    this.profileImage,
    this.code,
    this.experinceYears,
    this.subscribtionPlan,
  });

  User.fromJson(Map<String, dynamic> json) {
    userId = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    age = json['age'];
    displayName = json['display_name'];
    accessToken = json['token'];
    refreshToken = json['refresh_token'];
    role = json['role'];
    coachCode = json['code'];
    code = json['code'];
    profileImage = json['profile_img'];
    subscribtionPlan =
        CoachPackages.fromString(json['coach_subscription_plan']);
    experinceYears = json['experince_years'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = userId;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['password'] = password;
    data['display_name'] = displayName;
    data['age'] = age;
    data['token'] = accessToken;
    data['refresh_token'] = refreshToken;
    data['role'] = role;
    data['code'] = code;
    data['coach_subscription_plan'] = subscribtionPlan?.title;
    data['experince_years'] = experinceYears;
    data['coach_code'] = coachCode;
    data['profile_img'] = profileImage;

    return data;
  }

  copyWith({
    int? userId,
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    String? displayName,
    String? age,
    String? accessToken,
    String? refreshToken,
    String? role,
    String? coachCode,
    String? code,
    CoachPackages? subscribtionPlan,
    int? experinceYears,
    String? profileImage,
  }) {
    this.userId = userId ?? this.userId;
    this.firstName = firstName ?? this.firstName;
    this.lastName = lastName ?? this.lastName;
    this.email = email ?? this.email;
    this.password = password ?? this.password;
    this.displayName = displayName ?? this.displayName;
    this.age = age ?? this.age;
    this.accessToken = accessToken ?? this.accessToken;
    this.refreshToken = refreshToken ?? this.refreshToken;
    this.role = role ?? this.role;
    this.coachCode = coachCode ?? this.coachCode;
    this.code = code ?? this.code;
    this.subscribtionPlan = subscribtionPlan ?? this.subscribtionPlan;
    this.experinceYears = experinceYears ?? this.experinceYears;
    this.profileImage = profileImage ?? this.profileImage;
  }
}
