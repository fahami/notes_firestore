import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:notes/features/todo/data/model/todo_model.dart';
import 'package:notes/features/todo/domain/usecases/add_todo.dart';
import 'package:notes/features/todo/domain/usecases/delete_todo.dart';
import 'package:notes/features/todo/domain/usecases/get_todo_by_id.dart';
import 'package:notes/features/todo/domain/usecases/params_todo.dart';
import 'package:notes/features/todo/domain/usecases/update_todo.dart';

part 'edit_todo_event.dart';
part 'edit_todo_state.dart';

class EditTodoBloc extends Bloc<EditTodoEvent, EditTodoState> {
  final AddTodo addTodo;
  final DeleteTodo deleteTodo;
  final GetTodoById getTodoById;
  final UpdateTodo updateTodo;
  EditTodoBloc({
    required this.addTodo,
    required this.deleteTodo,
    required this.getTodoById,
    required this.updateTodo,
  }) : super(EditTodoInitial()) {
    on<EditLoad>((event, emit) async {
      emit(EditLoading());
      final failureOrTodo = await getTodoById(event.todoId);
      failureOrTodo.fold(
        (failure) => emit(EditError(failure.toString())),
        (todo) => emit(EditLoaded(todo as TodoModel)),
      );
    });

    on<EditSave>((event, emit) async {
      final state = this.state as EditLoaded;
      final failureOrTodo = await addTodo(Params(todo: event.todo));
      failureOrTodo.fold(
        (failure) => emit(EditError(failure.toString())),
        (todo) => emit(EditLoaded(state.todo)),
      );
    });

    on<EditDelete>((event, emit) async {
      final state = this.state as EditLoaded;
      final failureOrTodo = await deleteTodo(Params(todo: state.todo));
      failureOrTodo.fold(
        (failure) => emit(EditError(failure.toString())),
        (todo) => emit(EditDeleted()),
      );
    });

    on<EditChangeColor>((event, emit) {
      final state = this.state as EditLoaded;
      add(EditSave(todo: state.todo));
    });
  }
}
