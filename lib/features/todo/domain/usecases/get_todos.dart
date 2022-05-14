import 'package:notes/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:notes/core/usecases/usecase.dart';
import 'package:notes/features/todo/domain/entities/todo.dart';
import 'package:notes/features/todo/domain/repositories/todos_repository.dart';

class GetTodos extends UseCase<List<Todo>, NoParams> {
  final TodoRepository repository;

  GetTodos(this.repository);

  @override
  Future<Either<Failure, List<Todo>>> call(NoParams params) async {
    return await repository.getTodos();
  }
}
