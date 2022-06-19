import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:notes/core/usecases/usecase.dart';
import 'package:notes/features/todo/domain/entities/todo.dart';
import 'package:notes/features/todo/domain/usecases/delete_all_todo.dart';
import 'package:notes/features/todo/domain/usecases/get_todos.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final GetTodos getTodos;
  final DeleteAllTodo deleteAllTodo;

  List<Todo> todos = [];

  TodoBloc({
    required this.getTodos,
    required this.deleteAllTodo,
  }) : super(TodosInitial()) {
    on<GetTodosEvent>((event, emit) async {
      emit(TodosLoading());
      final failureOrTodos = await getTodos(ParamsUser(userId: event.userId));
      failureOrTodos.fold(
        (failure) => emit(const TodosError()),
        (todos) {
          this.todos = todos;
          emit(TodosLoaded(todos: todos));
        },
      );
    });
    on<DeleteAllTodoEvent>((event, emit) async {
      emit(TodosLoading());
      final failureOrTodo = await deleteAllTodo(NoParams());
      failureOrTodo.fold(
        (failure) => emit(const TodosError()),
        (todo) => emit(const TodosLoaded()),
      );
    });
    on<DeleteTodoEvent>((event, emit) {
      todos.removeWhere((todo) => todo.id == event.todoId);
      emit(TodosLoaded(todos: todos));
    });
  }
}
