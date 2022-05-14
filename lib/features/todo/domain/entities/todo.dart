import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  String id;
  String title;
  String isi;
  int colorId;
  DateTime reminder;

  Todo({
    required this.id,
    required this.title,
    required this.isi,
    required this.colorId,
    required this.reminder,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        isi,
        colorId,
        reminder,
      ];
}
