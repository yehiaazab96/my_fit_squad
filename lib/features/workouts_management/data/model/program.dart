import 'package:my_fit_squad/features/workouts_management/data/model/program_class.dart';

class Program {
  String? id;
  String? title;
  String? description;
  String? createdBy;
  int? duration;
  List<ProgramClass>? classes;
  Program(
      {this.id,
      this.title,
      this.description,
      this.duration,
      this.classes,
      this.createdBy});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['duration'] = duration;
    data['days'] = classes?.map((e) => e.toJson()).toList();
    data['created_by'] = createdBy;

    return data;
  }

  Program.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    title = json['title'];
    description = json['description'];
    duration = json['duration'];
    createdBy = json['created_by'];
    classes = (json['days'] != null)
        ? (json['days'] as List).map((e) => ProgramClass.fromJson(e)).toList()
        : null;
  }

  copyWith({
    String? id,
    String? title,
    String? description,
    int? duration,
    List<ProgramClass>? classes,
    int? day,
  }) {
    this.id = id ?? this.id;
    this.title = title ?? this.title;
    this.description = description ?? this.description;
    this.duration = duration ?? this.duration;
    this.classes = classes ?? this.classes;
  }
}
