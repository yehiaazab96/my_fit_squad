import 'package:my_fit_squad/features/user_management/helpers/coach_package.dart';
import 'package:my_fit_squad/features/workouts_management/data/model/current_program.dart';
import 'package:my_fit_squad/features/workouts_management/data/model/program.dart';

class User {
  String? userId;
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
  bool? requestPending;
  List<String>? joinRequests;
  CurrentProgram? currentProgram;
  List<Program>? programsHistory;
  List<String>? clients;

  User(
      {this.userId,
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
      this.currentProgram,
      this.joinRequests,
      this.programsHistory,
      this.clients,
      this.requestPending});

  User.fromJson(Map<String, dynamic> json) {
    userId = json['_id'];
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
    if (json['coach_subscription_plan'] != null &&
        (json['coach_subscription_plan'] as Map<dynamic, dynamic>).isNotEmpty) {
      subscribtionPlan = CoachPackages.fromString(
          (json['coach_subscription_plan']
              as Map<dynamic, dynamic>)['package']);
    }
    experinceYears = json['experince_years'];
    requestPending = json['request_pending'];
    if (json['join_requests'] != null && json['join_requests'] is List) {
      joinRequests =
          (json['join_requests'] as List).map((e) => e.toString()).toList();
    }
    if (json['clients'] != null && json['clients'] is List) {
      clients = (json['clients'] as List).map((e) => e.toString()).toList();
    }
    if (json['current_program'] != null) {
      currentProgram = CurrentProgram.fromJson(json['current_program']);
    }
    programsHistory = (json['programs_history'] is List)
        ? (json['programs_history'] as List)
            .map((e) => Program.fromJson(e))
            .toList()
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = userId;
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
    data['coach_subscription_plan'] = subscribtionPlan?.toJson;
    data['experince_years'] = experinceYears;
    data['coach_code'] = coachCode;
    data['profile_img'] = profileImage;
    data['request_pending'] = requestPending ?? true;
    data['join_requests'] = joinRequests;
    data['clients'] = clients;
    data['current_program'] = currentProgram?.toJson();
    data['programs_history'] = programsHistory?.map((e) => e.toJson()).toList();

    return data;
  }

  copyWith(
      {String? userId,
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
      bool? requestPending,
      List<String>? joinRequests,
      List<String>? clients,
      CurrentProgram? currentProgram,
      List<Program>? programsHistory}) {
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
    this.requestPending = requestPending ?? this.requestPending;
    this.joinRequests = joinRequests ?? this.joinRequests;
    this.currentProgram = currentProgram ?? this.currentProgram;
    this.programsHistory = programsHistory ?? this.programsHistory;
    this.clients = clients ?? this.clients;
  }
}
