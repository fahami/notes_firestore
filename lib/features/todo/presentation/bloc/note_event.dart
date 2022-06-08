part of 'note_bloc.dart';

abstract class NoteEvent extends Equatable {
  const NoteEvent();

  @override
  List<Object> get props => [];
}

class AddEvent extends NoteEvent {
  final TodoModel todo;

  const AddEvent(this.todo);

  @override
  List<Object> get props => [todo];
}

class GetTodosEvent extends NoteEvent {
  final String userId;

  const GetTodosEvent(this.userId);

  @override
  List<Object> get props => [userId];
}

class GetTodoByIdEvent extends NoteEvent {
  final String userId;
  final String todoId;

  const GetTodoByIdEvent(this.userId, this.todoId);

  @override
  List<Object> get props => [userId, todoId];
}

class UpdateTodoEvent extends NoteEvent {
  final String userId;
  final TodoModel todo;

  const UpdateTodoEvent(this.userId, this.todo);

  @override
  List<Object> get props => [userId, todo];
}

class DeleteTodoEvent extends NoteEvent {
  final String userId;
  final TodoModel todo;

  const DeleteTodoEvent(this.userId, this.todo);

  @override
  List<Object> get props => [userId, todo];
}

class DeleteAllTodoEvent extends NoteEvent {
  final String userId;

  const DeleteAllTodoEvent(this.userId);

  @override
  List<Object> get props => [userId];
}
