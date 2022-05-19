import 'package:notes/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:notes/core/usecases/usecase.dart';
import 'package:notes/features/todo/domain/repositories/todos_repository.dart';

import 'params_todo.dart';

class UpdateTodo extends UseCase<void, Params> {
  final TodoRepository repository;

  UpdateTodo(this.repository);

  @override
  Future<Either<Failure, void>> call(Params params) {
    return repository.updateTodo(params.todo);
  }
}
