import 'package:hive/hive.dart';
import 'package:notes/core/error/exception.dart';
import 'package:notes/features/todo/data/model/todo_model.dart';

abstract class TodoLocalDataSource {
  List<TodoModel> getTodos();
  TodoModel getTodoById(String id);
  Future<void> cacheTodo(TodoModel todoToCache);
  Future<void> updateTodo(TodoModel todo);
  Future<void> deleteTodo(TodoModel todo);
  Future<void> deleteAllTodos();
}

class TodoLocalDataSourceImpl implements TodoLocalDataSource {
  final Box<TodoModel> hiveBox;

  TodoLocalDataSourceImpl(this.hiveBox);

  @override
  Future<void> cacheTodo(TodoModel todoToCache) {
    return hiveBox.put(todoToCache.id, todoToCache);
  }

  @override
  List<TodoModel> getTodos() {
    final todos = hiveBox.values.toList();
    if (todos.isNotEmpty) {
      return todos;
    } else {
      throw CacheException('No todos found');
    }
  }

  @override
  TodoModel getTodoById(String id) {
    final todo = hiveBox.get(id);
    if (todo != null) {
      return todo;
    } else {
      throw CacheException('No todo found');
    }
  }

  @override
  Future<void> deleteAllTodos() async {
    await hiveBox.clear();
  }

  @override
  Future<void> deleteTodo(TodoModel todo) {
    return hiveBox.delete(todo.id);
  }

  @override
  Future<void> updateTodo(TodoModel todo) {
    return hiveBox.put(todo.id, todo);
  }
}
