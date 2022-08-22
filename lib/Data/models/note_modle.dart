import 'package:hive/hive.dart';
part 'note_modle.g.dart';

@HiveType(typeId: 0)
class Note extends HiveObject {
  @HiveField(0)
  String? title;
  @HiveField(1)
  String? body;
  @HiveField(2)
  String? createdTime;

  Note({
    this.title,
    this.body,
    this.createdTime,
  });

  Note copyWith({
    String? title,
    String? body,
    String? createdTime,
  }) {
    return Note(
        title: title ?? this.title,
        body: body ?? this.body,
        createdTime: createdTime ?? this.createdTime);
  }

  factory Note.fromJson(Map<String, dynamic> json) => Note(
      title: json['title'],
      body: json['body'],
      createdTime: json['createdTime']);

  @override
  String toString() {
    return '${this.title}||${this.body}';
  }
}
