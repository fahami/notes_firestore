part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class AddEvent extends TodoEvent {
  final TodoModel todo;

  const AddEvent(this.todo);

  @override
  List<Object> get props => [todo];
}

class GetTodosEvent extends TodoEvent {
  final String userId;

  const GetTodosEvent(this.userId);

  @override
  List<Object> get props => [userId];
}

class GetTodoByIdEvent extends TodoEvent {
  final String userId;
  final String todoId;

  const GetTodoByIdEvent(this.userId, this.todoId);

  @override
  List<Object> get props => [userId, todoId];
}

class UpdateTodoEvent extends TodoEvent {
  final String userId;
  final TodoModel todo;

  const UpdateTodoEvent(this.userId, this.todo);

  @override
  List<Object> get props => [userId, todo];
}

class DeleteTodoEvent extends TodoEvent {
  final String userId;
  final TodoModel todo;

  const DeleteTodoEvent(this.userId, this.todo);

  @override
  List<Object> get props => [userId, todo];
}

class DeleteTodosEvent extends TodoEvent {
  final String userId;

  const DeleteTodosEvent(this.userId);

  @override
  List<Object> get props => [userId];
}
