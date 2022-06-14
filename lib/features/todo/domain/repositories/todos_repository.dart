import 'package:dartz/dartz.dart';
import 'package:notes/core/error/failures.dart';
import 'package:notes/features/todo/data/model/todo_model.dart';
import 'package:notes/features/todo/domain/entities/todo.dart';

abstract class TodoRepository {
  Future<Either<Failure, List<Todo>>> getTodos(String userId);
  Future<Either<Failure, Todo>> getTodoById(String id);
  Future<Either<Failure, void>> addTodo(TodoModel todo);
  Future<Either<Failure, void>> deleteTodo(TodoModel todo);
  Future<Either<Failure, void>> updateTodo(TodoModel todo);
  Future<Either<Failure, void>> deleteAllTodos();
}
