import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:notes/core/error/failures.dart';
import 'package:notes/features/todo/data/model/todo_model.dart';
import 'package:notes/features/todo/domain/entities/todo.dart';

abstract class TodoRemoteDataSource {
  Future<Either<Failure, List<TodoModel>>> getTodos();
  Future<Either<Failure, TodoModel>> getTodoById(String id);
  Future<Either<Failure, void>> addTodo(Todo todo);
  Future<Either<Failure, void>> deleteTodo(Todo todo);
  Future<Either<Failure, void>> updateTodo(Todo todo);
  Future<Either<Failure, void>> deleteAllTodos();
}

class TodoRemoteDataSourceImpl implements TodoRemoteDataSource {
  final FirebaseFirestore client;

  TodoRemoteDataSourceImpl(this.client);

  @override
  Future<Either<Failure, List<TodoModel>>> getTodos() async {
    final db = client.collection('todos');
    final todos = await db.get().then((snapshot) => snapshot.docs.map((doc) {
          final todo = TodoModel.fromJson(doc.data());
          todo.id = doc.id;
          return todo;
        }).toList());
    if (todos.isNotEmpty) {
      return Right(todos);
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, TodoModel>> getTodoById(String id) async {
    final db = client.collection('todos');
    final todoById = await db.doc(id).get();
    if (todoById.exists) {
      return Right(TodoModel.fromJson(todoById.data()!));
    } else {
      return Left(ServerFailure());
    }
  }
}
