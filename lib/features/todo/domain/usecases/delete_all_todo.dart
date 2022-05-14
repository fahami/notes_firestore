import 'package:notes/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:notes/core/usecases/usecase.dart';
import 'package:notes/features/todo/domain/repositories/todos_repository.dart';

class DeleteAllTodo extends UseCase<void, NoParams> {
  final TodoRepository repository;

  DeleteAllTodo(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) {
    return repository.deleteAllTodos();
  }
}
