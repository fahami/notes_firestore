import 'package:notes/features/todo/domain/entities/todo.dart';

class TodoModel extends Todo {
  TodoModel(
      {required String id,
      required String title,
      required String isi,
      required int colorId,
      required DateTime reminder})
      : super(
            id: id,
            title: title,
            isi: isi,
            colorId: colorId,
            reminder: reminder);

  factory TodoModel.fromJson(Map<String, dynamic> json) => TodoModel(
        id: json['id'],
        title: json['title'],
        isi: json['isi'],
        colorId: json['colorId'],
        reminder: DateTime.parse(json['reminder']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'isi': isi,
        'colorId': colorId,
        'reminder': reminder.toIso8601String(),
      };
}
