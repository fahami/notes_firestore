import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notes/features/todo/domain/entities/todo.dart';

class TodoModel extends Todo {
  TodoModel(
      {required String id,
      required String title,
      required String isi,
      required int colorId,
      required DateTime reminder,
      required String userId})
      : super(
            id: id,
            title: title,
            isi: isi,
            colorId: colorId,
            reminder: reminder,
            userId: userId);

  factory TodoModel.fromJson(Map<String, dynamic> json) => TodoModel(
        id: json['id'] ?? '',
        title: json['title'],
        isi: json['isi'],
        colorId: json['color_id'],
        reminder: (json['reminder'] as Timestamp).toDate(),
        userId: json['user_id'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'isi': isi,
        'color_id': colorId,
        'reminder': reminder.toIso8601String(),
        'user_id': userId,
      };
}
