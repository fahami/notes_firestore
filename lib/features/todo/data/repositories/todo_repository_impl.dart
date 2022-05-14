import 'package:notes/core/network/network_info.dart';
import 'package:notes/features/todo/data/datasources/local/todo_local_datasource.dart';
import 'package:notes/features/todo/data/datasources/remote/todo_remote_datasource.dart';
import 'package:notes/features/todo/domain/entities/todo.dart';
import 'package:notes/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:notes/features/todo/domain/repositories/todos_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoLocalDataSource localDataSource;
  final TodoRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  TodoRepositoryImpl(
    this.localDataSource,
    this.remoteDataSource,
    this.networkInfo,
  );

  @override
  Future<Either<Failure, void>> addTodo(Todo todo) async {
    if (await networkInfo.isConnected) {
    await remoteDataSource.    
    }
  }

  @override
  Future<Either<Failure, void>> deleteAllTodos() {
    // TODO: implement deleteAllTodos
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> deleteTodo(Todo todo) {
    // TODO: implement deleteTodo
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Todo>>> getTodos() {
    // TODO: implement getTodos
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> updateTodo(Todo todo) {
    // TODO: implement updateTodo
    throw UnimplementedError();
  }
}
