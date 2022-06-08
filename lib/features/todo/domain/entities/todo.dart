import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
part 'todo.g.dart';

@HiveType(typeId: 0)
class Todo extends HiveObject with EquatableMixin {
  @HiveField(0)
  String id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String isi;
  @HiveField(3)
  int colorId;
  @HiveField(4)
  String userId;
  @HiveField(5)
  DateTime reminder;

  Todo({
    required this.id,
    required this.title,
    required this.isi,
    required this.colorId,
    required this.reminder,
    required this.userId,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        isi,
        colorId,
        reminder,
        userId,
      ];
}
