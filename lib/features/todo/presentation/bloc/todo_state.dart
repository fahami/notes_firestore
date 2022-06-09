part of 'todo_bloc.dart';

abstract class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object> get props => [];
}

class Initial extends TodoState {}

class Loading extends TodoState {}

class Loaded extends TodoState {
  final List<Todo>? todos;

  const Loaded({this.todos});
}

class Error extends TodoState {}
