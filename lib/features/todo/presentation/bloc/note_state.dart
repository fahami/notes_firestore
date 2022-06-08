part of 'note_bloc.dart';

abstract class NoteState extends Equatable {
  const NoteState();

  @override
  List<Object> get props => [];
}

class Initial extends NoteState {}

class Loading extends NoteState {}

class Loaded extends NoteState {
  final List<Todo>? todos;

  const Loaded({this.todos});
}

class Error extends NoteState {}
