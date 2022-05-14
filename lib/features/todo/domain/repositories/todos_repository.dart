import 'package:dartz/dartz.dart';
import 'package:notes/core/error/failures.dart';
import 'package:notes/features/todo/domain/entities/todo.dart';

abstract class TodoRepository {
  Future<Either<Failure, List<Todo>>> getTodos();
  Future<Either<Failure, void>> addTodo(Todo todo);
  Future<Either<Failure, void>> deleteTodo(Todo todo);
  Future<Either<Failure, void>> updateTodo(Todo todo);
  Future<Either<Failure, void>> deleteAllTodos();
}
