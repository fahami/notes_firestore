import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notes/core/error/exception.dart';
import 'package:notes/features/todo/data/model/todo_model.dart';

abstract class TodoRemoteDataSource {
  Future<List<TodoModel>> getTodos();
  Future<TodoModel> getTodoById(String id);
  Future<void> addTodo(TodoModel todo);
  Future<void> deleteTodo(TodoModel todo);
  Future<void> updateTodo(TodoModel todo);
  Future<void> deleteAllTodos();
}

class TodoRemoteDataSourceImpl implements TodoRemoteDataSource {
  final FirebaseFirestore client;

  TodoRemoteDataSourceImpl(this.client);

  @override
  Future<List<TodoModel>> getTodos() async {
    final db = client.collection('todos');
    final todos = await db.get().then((snapshot) => snapshot.docs.map((doc) {
          final todo = TodoModel.fromJson(doc.data());
          todo.id = doc.id;
          return todo;
        }).toList());
    if (todos.isNotEmpty) {
      return todos;
    } else {
      throw ServerException('No todos found');
    }
  }

  @override
  Future<TodoModel> getTodoById(String id) async {
    final db = client.collection('todos');
    final todoById = await db.doc(id).get();
    if (todoById.exists) {
      return TodoModel.fromJson(todoById.data()!);
    } else {
      throw ServerException('No todo found');
    }
  }

  @override
  Future<void> addTodo(TodoModel todo) {
    final db = client.collection('todos');
    return db.doc(todo.id).set(todo.toJson());
  }

  @override
  Future<void> deleteAllTodos() {
    final db = client.collection('todos');
    return db.get().then(
        (snapshot) => snapshot.docs.forEach((doc) => doc.reference.delete()));
  }

  @override
  Future<void> deleteTodo(TodoModel todo) {
    final db = client.collection('todos');
    return db.doc(todo.id).delete();
  }

  @override
  Future<void> updateTodo(TodoModel todo) {
    final db = client.collection('todos');
    return db.doc(todo.id).update(todo.toJson());
  }
}
