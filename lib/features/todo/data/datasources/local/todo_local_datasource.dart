import 'package:hive/hive.dart';
import 'package:notes/core/error/exception.dart';
import 'package:notes/features/todo/domain/entities/todo.dart';

abstract class TodoLocalDataSource {
  List<Todo> getTodos();
  Todo getTodoById(String id);
  Future<void> cacheTodo(Todo todoToCache);
}

class TodoLocalDataSourceImpl implements TodoLocalDataSource {
  final Box<Todo> hiveBox;

  TodoLocalDataSourceImpl(this.hiveBox);

  @override
  Future<void> cacheTodo(Todo todoToCache) {
    return hiveBox.put(todoToCache.id, todoToCache);
  }

  @override
  List<Todo> getTodos() {
    final todos = hiveBox.values.toList();
    if (todos.isNotEmpty) {
      return todos;
    } else {
      throw CacheException('No todos found');
    }
  }

  @override
  Todo getTodoById(String id) {
    final todo = hiveBox.get(id);
    if (todo != null) {
      return todo;
    } else {
      throw CacheException('No todo found');
    }
  }
}
