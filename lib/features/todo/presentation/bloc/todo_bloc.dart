import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:notes/core/usecases/usecase.dart';
import 'package:notes/features/todo/data/model/todo_model.dart';
import 'package:notes/features/todo/domain/usecases/add_todo.dart';
import 'package:notes/features/todo/domain/usecases/delete_todo.dart';
import 'package:notes/features/todo/domain/usecases/get_todos.dart';
import 'package:notes/features/todo/domain/usecases/params_todo.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final AddTodo addTodo;
  final DeleteTodo deleteTodo;
  final GetTodos getTodos;

  TodoBloc({
    required this.addTodo,
    required this.deleteTodo,
    required this.getTodos,
  }) : super(Initial()) {
    on<AddEvent>(onAddTodo);
    on<DeleteTodoEvent>(onDeleteTodo);
    on<GetTodosEvent>(onGetTodos);
  }

  Future<void> onAddTodo(event, emit) async {
    emit(Loading());
    final failureOrTodo = await addTodo(Params(todo: event.todo));
    failureOrTodo.fold(
      (failure) => emit(Error()),
      (todo) => emit(Loaded()),
    );
  }

  Future<void> onDeleteTodo(event, emit) async {
    emit(Loading());
    final failureOrTodo = await deleteTodo(Params(todo: event.todo));
    failureOrTodo.fold(
      (failure) => emit(Error()),
      (todo) => emit(Loaded()),
    );
  }

  Future<void> onGetTodos(event, emit) async {
    emit(Loading());
    getTodos(NoParams()).then(
      (failureOrTodo) => failureOrTodo.fold(
        (failure) => emit(Error()),
        (todos) => emit(Loaded()),
      ),
    );
  }
}
