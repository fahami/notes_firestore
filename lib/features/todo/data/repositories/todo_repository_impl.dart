import 'package:notes/core/error/exception.dart';
import 'package:notes/core/network/network_info.dart';
import 'package:notes/features/todo/data/datasources/local/todo_local_datasource.dart';
import 'package:notes/features/todo/data/datasources/remote/todo_remote_datasource.dart';
import 'package:notes/features/todo/data/model/todo_model.dart';
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
  Future<Either<Failure, void>> addTodo(TodoModel todo) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.addTodo(todo);
        localDataSource.cacheTodo(todo);
        return const Right(null);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        localDataSource.cacheTodo(todo);
        return const Right(null);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, void>> deleteAllTodos() async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.deleteAllTodos();
        localDataSource.deleteAllTodos();
        return const Right(null);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        localDataSource.deleteAllTodos();
        return const Right(null);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, void>> deleteTodo(TodoModel todo) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.deleteTodo(todo);
        localDataSource.deleteTodo(todo);
        return const Right(null);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        localDataSource.deleteTodo(todo);
        return const Right(null);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<Todo>>> getTodos() async {
    if (await networkInfo.isConnected) {
      try {
        final todos = await remoteDataSource.getTodos();
        for (var todo in todos) {
          localDataSource.cacheTodo(todo);
        }
        return Right(todos);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final todos = localDataSource.getTodos();
        return Right(todos);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, void>> updateTodo(Todo todo) {
    // TODO: implement updateTodo
    throw UnimplementedError();
  }
}
