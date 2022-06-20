part of 'todo_bloc.dart';

abstract class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object> get props => [];
}

class TodosInitial extends TodoState {}

class TodosLoading extends TodoState {}

class TodosLoaded extends TodoState {
  final List<Todo> todos;

  const TodosLoaded({required this.todos});
}

class TodosError extends TodoState {
  final String? message;

  const TodosError({this.message});
}
