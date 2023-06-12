import 'package:my_fit_squad/features/workouts_management/data/model/class.dart';

class Program {
  String? id;
  String? title;
  String? description;
  int? duration;
  List<Class>? classes;
  int? day;
  Program(
      {this.id,
      this.title,
      this.description,
      this.duration,
      this.classes,
      this.day});

  Program.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    title = json['title'];
    description = json['description'];
    duration = json['duration'];
    day = json['day'];
    classes = (json['days'] != null)
        ? (json['days'] as List).map((e) => Class.fromJson(e)).toList()
        : null;
  }

  copyWith({
    String? id,
    String? title,
    String? description,
    int? duration,
    List<Class>? classes,
    int? day,
  }) {
    this.id = id ?? this.id;
    this.title = title ?? this.title;
    this.description = description ?? this.description;
    this.duration = duration ?? this.duration;
    this.day = day ?? this.day;
    this.classes = classes ?? this.classes;
  }
}
