import 'package:equatable/equatable.dart';
import 'package:notes/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:notes/core/usecases/usecase.dart';
import 'package:notes/features/todo/domain/entities/todo.dart';
import 'package:notes/features/todo/domain/repositories/todos_repository.dart';

class GetTodos extends UseCase<List<Todo>, ParamsUser> {
  final TodoRepository repository;

  GetTodos(this.repository);

  @override
  Future<Either<Failure, List<Todo>>> call(ParamsUser params) async {
    return repository.getTodos(params.userId);
  }
}

class ParamsUser extends Equatable {
  final String userId;

  const ParamsUser({required this.userId});

  @override
  List<Object?> get props => [userId];
}
