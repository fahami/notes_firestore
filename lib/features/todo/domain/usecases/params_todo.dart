import 'package:equatable/equatable.dart';
import 'package:notes/features/todo/data/model/todo_model.dart';

class Params extends Equatable {
  final TodoModel todo;

  const Params({required this.todo});

  @override
  List<Object?> get props => [todo];
}
