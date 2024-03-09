import 'package:json_annotation/json_annotation.dart';
part 'todo_model.g.dart';

@JsonSerializable()
class Task {
  @JsonKey(name: "id")
  String? id;

  @JsonKey(name: "title")
  String? title;

  @JsonKey(name: "description")
  String? description;

  @JsonKey(name: "category")
  String? category;

  @JsonKey(name: "date")
  String? date;

  @JsonKey(name: "time")
  String? time;

  @JsonKey(name: "isDone")
  bool? isDone;


  Task({
    this.id,
    this.title,
    this.description,
    this.category,
    this.date,
    this.time,
    this.isDone
  });

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
  Map<String, dynamic> toJson() => _$TaskToJson(this);
}
