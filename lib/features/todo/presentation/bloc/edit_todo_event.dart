part of 'edit_todo_bloc.dart';

abstract class EditTodoEvent extends Equatable {
  const EditTodoEvent();

  @override
  List<Object> get props => [];
}

class EditInitial extends EditTodoEvent {}

class EditLoad extends EditTodoEvent {
  final String todoId;

  const EditLoad(this.todoId);

  @override
  List<Object> get props => [todoId];
}

class EditSave extends EditTodoEvent {
  final TodoModel todo;

  const EditSave({required this.todo});

  @override
  List<Object> get props => [todo];
}

class EditDelete extends EditTodoEvent {
  final String todoId;

  const EditDelete(this.todoId);

  @override
  List<Object> get props => [todoId];
}

class EditChangeColor extends EditTodoEvent {
  final Color color;

  const EditChangeColor({required this.color});

  @override
  List<Object> get props => [color];
}
