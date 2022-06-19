part of 'edit_todo_bloc.dart';

abstract class EditTodoState extends Equatable {
  const EditTodoState();

  @override
  List<Object> get props => [];
}

class EditTodoInitial extends EditTodoState {
  @override
  List<Object> get props => [];
}

class EditLoading extends EditTodoState {}

class EditLoaded extends EditTodoState {
  final TodoModel todo;

  const EditLoaded(this.todo);
}

class EditError extends EditTodoState {
  final String message;

  const EditError(this.message);
}

class EditSaved extends EditTodoState {
  final TodoModel todo;

  const EditSaved(this.todo);
}

class EditDeleted extends EditTodoState {}
