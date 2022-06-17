part of 'edit_todo_cubit.dart';

abstract class EditTodoState extends Equatable {
  const EditTodoState();

  @override
  List<Object> get props => [];
}

class EditTodoInitial extends EditTodoState {}

class EditTodoLoading extends EditTodoState {}

class EditTodoError extends EditTodoState {}

class EditTodoLoaded extends EditTodoState {
  final Todo todo;

  const EditTodoLoaded({required this.todo});

  @override
  List<Object> get props => [todo];
}

class EditTodoAutoSaved extends EditTodoState {
  final Todo todo;

  const EditTodoAutoSaved({required this.todo});

  @override
  List<Object> get props => [todo];
}

class EditTodoSaved extends EditTodoState {
  final Todo todo;

  const EditTodoSaved({required this.todo});

  @override
  List<Object> get props => [todo];
}

class EditTodoDeleted extends EditTodoState {}
