import 'package:equatable/equatable.dart';
import 'package:notes/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:notes/core/usecases/usecase.dart';
import 'package:notes/features/todo/data/model/todo_model.dart';
import 'package:notes/features/todo/domain/repositories/todos_repository.dart';

class DeleteTodo extends UseCase<void, Params> {
  final TodoRepository repository;

  DeleteTodo(this.repository);

  @override
  Future<Either<Failure, void>> call(Params params) async {
    return await repository.deleteTodo(params.todo);
  }
}

class Params extends Equatable {
  final TodoModel todo;

  const Params(this.todo);

  @override
  List<Object?> get props => [todo];
}
