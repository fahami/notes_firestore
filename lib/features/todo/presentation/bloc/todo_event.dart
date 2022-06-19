part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class GetTodosEvent extends TodoEvent {
  final String userId;

  const GetTodosEvent(this.userId);

  @override
  List<Object> get props => [userId];
}

class DeleteAllTodoEvent extends TodoEvent {
  final String userId;

  const DeleteAllTodoEvent(this.userId);

  @override
  List<Object> get props => [userId];
}

class DeleteTodoEvent extends TodoEvent {
  final String todoId;

  const DeleteTodoEvent(this.todoId);

  @override
  List<Object> get props => [todoId];
}
