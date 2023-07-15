import 'package:my_fit_squad/features/workouts_management/data/model/class.dart';

class ProgramClass {
  Class? cls;
  int? day;
  ProgramClass({this.cls, this.day});

  ProgramClass.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    cls = (json['workout'] != null) ? Class.fromJson(json['workout']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['day'] = day;
    data['workout'] = cls?.toJson();

    return data;
  }

  copyWith({
    Class? cls,
    int? day,
  }) {
    this.day = day ?? this.day;
    this.cls = cls ?? this.cls;
  }
}
