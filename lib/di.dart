import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:notes/features/todo/data/datasources/color_local_datasource.dart';
import 'package:notes/features/todo/data/datasources/color_remote_datasource.dart';
import 'package:notes/features/todo/data/datasources/todo_local_datasource.dart';
import 'package:notes/features/todo/data/datasources/todo_remote_datasource.dart';
import 'package:notes/features/todo/data/model/todo_model.dart';
import 'package:notes/features/todo/data/repositories/color_repository_impl.dart';
import 'package:notes/features/todo/data/repositories/todo_repository_impl.dart';
import 'package:notes/features/todo/domain/repositories/colors_repository.dart';
import 'package:notes/features/todo/domain/repositories/todos_repository.dart';
import 'package:notes/features/todo/domain/usecases/add_todo.dart';
import 'package:notes/features/todo/domain/usecases/delete_all_todo.dart';
import 'package:notes/features/todo/domain/usecases/delete_todo.dart';
import 'package:notes/features/todo/domain/usecases/get_colors.dart';
import 'package:notes/features/todo/domain/usecases/get_todos.dart';
import 'package:notes/features/todo/domain/usecases/update_todo.dart';
import 'package:notes/features/todo/presentation/bloc/todo_bloc.dart';

import 'features/todo/data/model/color_model.dart';

final sl = GetIt.instance;

class DependencyInjector {
  Future<void> init() async {
    // bloc
    sl.registerFactory(
      () => TodoBloc(
        addTodo: sl(),
        deleteTodo: sl(),
        getTodos: sl(),
      ),
    );

    // usecases
    sl.registerLazySingleton(() => GetTodos(sl()));
    sl.registerLazySingleton(() => DeleteTodo(sl()));
    sl.registerLazySingleton(() => DeleteAllTodo(sl()));
    sl.registerLazySingleton(() => GetTodoColor(sl()));
    sl.registerLazySingleton(() => AddTodo(sl()));
    sl.registerLazySingleton(() => UpdateTodo(sl()));

    // repository
    sl.registerLazySingleton<TodoRepository>(
      () => TodoRepositoryImpl(
        localDataSource: sl(),
        remoteDataSource: sl(),
        networkInfo: sl(),
      ),
    );
    sl.registerLazySingleton<TodoColorsRepository>(
      () => TodoColorRepositoryImpl(
        localDataSource: sl(),
        remoteDataSource: sl(),
        networkInfo: sl(),
      ),
    );

    // data sources
    sl.registerLazySingleton<TodoLocalDataSource>(
        () => TodoLocalDataSourceImpl(sl()));
    sl.registerLazySingleton<TodoRemoteDataSource>(
        () => TodoRemoteDataSourceImpl(sl()));
    sl.registerLazySingleton<ColorRemoteDataSource>(
        () => ColorRemoteDataSourceImpl(sl()));
    sl.registerLazySingleton<ColorLocalDataSource>(
        () => ColorLocalDataSourceImpl(sl()));

    // other
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final Box<TodoModel> todoBox = Hive.box<TodoModel>('todos');
    final Box<ColorModel> colorBox = Hive.box<ColorModel>('colors');
    sl.registerLazySingleton(() => InternetConnectionChecker());
    sl.registerLazySingleton(() => firestore);
    sl.registerLazySingleton(() => todoBox);
    sl.registerLazySingleton(() => colorBox);
  }
}
