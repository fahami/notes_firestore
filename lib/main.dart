import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/core/router/router.dart';
import 'package:notes/di.dart' as di;
import 'package:notes/di.dart';
import 'package:notes/features/todo/presentation/bloc/todo_bloc.dart';
import 'package:notes/features/todo/presentation/cubit/color_cubit.dart';
import 'package:notes/features/todo/presentation/cubit/edit_todo_cubit.dart';
import 'package:notes/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              sl<TodoBloc>()..add(GetTodosEvent(_auth.currentUser!.uid)),
        ),
        BlocProvider(
          create: (context) => sl<ColorCubit>()..getColors(),
        ),
        BlocProvider(
          create: (context) => sl<EditTodoCubit>(),
        ),
      ],
      child: MaterialApp.router(
        title: 'NotApp',
        routeInformationParser: AppRouter.router.routeInformationParser,
        routerDelegate: AppRouter.router.routerDelegate,
      ),
    );
  }
}
