import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:notes/di.dart';
import 'package:notes/features/todo/data/model/todo_model.dart';
import 'package:notes/features/todo/domain/entities/todo.dart';
import 'package:notes/features/todo/domain/usecases/add_todo.dart';
import 'package:notes/features/todo/domain/usecases/delete_todo.dart';
import 'package:notes/features/todo/domain/usecases/get_todo_by_id.dart';
import 'package:notes/features/todo/domain/usecases/params_todo.dart';
import 'package:notes/features/todo/domain/usecases/update_todo.dart';
import 'package:notes/features/todo/presentation/bloc/todo_bloc.dart';

part 'edit_todo_state.dart';

class EditTodoCubit extends Cubit<EditTodoState> {
  final AddTodo addTodo;
  final DeleteTodo deleteTodo;
  final GetTodoById getTodoById;
  final UpdateTodo updateTodo;
  EditTodoCubit(
      {required this.addTodo,
      required this.deleteTodo,
      required this.getTodoById,
      required this.updateTodo})
      : super(EditTodoInitial());
  final TodoBloc todoBloc = sl<TodoBloc>();

  late StreamSubscription _subscription;

  void createTodo(TodoModel todoCreated) async {
    // emit(EditTodoLoading());
    final failureOrTodo = await addTodo(Params(todo: todoCreated));
    failureOrTodo.fold(
      (failure) => emit(EditTodoError()),
      (todo) => emit(EditTodoLoaded(todo: todoCreated)),
    );
  }

  void removeTodo(TodoModel todoRemove) async {
    emit(EditTodoLoading());
    final failureOrTodo = await deleteTodo(Params(todo: todoRemove));
    failureOrTodo.fold(
      (failure) => emit(EditTodoError()),
      (todo) => emit(EditTodoInitial()),
    );
  }

  void getById(String id) async {
    emit(EditTodoLoading());
    final failureOrTodo = await getTodoById(id);
    failureOrTodo.fold(
      (failure) => emit(EditTodoError()),
      (todo) => emit(EditTodoLoaded(todo: todo)),
    );
  }

  void putTodo(TodoModel todo) async {
    emit(EditTodoLoading());
    final failureOrTodo = await updateTodo(Params(todo: todo));
    failureOrTodo.fold(
      (failure) => emit(EditTodoError()),
      (todo) => emit(EditTodoInitial()),
    );
  }
}
