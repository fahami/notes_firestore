import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:notes/core/theme/color_theme.dart';
import 'package:notes/core/theme/text_theme.dart';
import 'package:notes/core/util/utils.dart';
import 'package:notes/features/todo/presentation/bloc/todo_bloc.dart';
import 'package:notes/features/todo/presentation/cubit/color_cubit.dart';

class NotesScreen extends StatelessWidget {
  NotesScreen({Key? key}) : super(key: key);
  final TextEditingController _searchController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    context.read<ColorCubit>().getColors();

    return Scaffold(
      body: Column(
        children: [
          SafeArea(
            bottom: false,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "NotApp",
                          style: ThemeText.heroStyle.copyWith(
                              fontWeight: FontWeight.bold, fontSize: 36),
                        ),
                      ),
                      GestureDetector(
                        child: CircleAvatar(
                          backgroundColor: ThemeColor.disabled,
                          child: Icon(
                            Icons.person,
                            color: ThemeColor.typography,
                          ),
                        ),
                        onTap: () {
                          GoRouter.of(context).push('/user');
                        },
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 48,
                    child: TextField(
                      controller: _searchController,
                      enableSuggestions: true,
                      decoration: InputDecoration(
                        hintText: "Cari catatanmu...",
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 16),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(200),
                            borderSide: BorderSide(color: ThemeColor.disabled)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(child: BlocBuilder<TodoBloc, TodoState>(
            builder: (context, state) {
              if (state is TodosLoaded) {
                return RefreshIndicator(
                  onRefresh: () async {
                    context
                        .read<TodoBloc>()
                        .add(GetTodosEvent(_auth.currentUser!.uid));
                  },
                  child: MasonryGridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                    itemCount: context.read<TodoBloc>().todos.length,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () => GoRouter.of(context).push(
                            '/note/${context.read<TodoBloc>().todos[index].id}'),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: ThemeColor.disabled),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                context
                                    .read<TodoBloc>()
                                    .todos
                                    .elementAt(index)
                                    .title,
                                style: ThemeText.alternativeStyle.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                context
                                    .read<TodoBloc>()
                                    .todos
                                    .elementAt(index)
                                    .isi,
                                style: ThemeText.captionStyle,
                                maxLines: index + 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                simpleDate(context
                                    .read<TodoBloc>()
                                    .todos
                                    .elementAt(index)
                                    .reminder
                                    .toIso8601String()),
                                style: ThemeText.captionStyle.copyWith(
                                  color: ThemeColor.caption,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else if (state is TodosError) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.error,
                        size: 48,
                        color: ThemeColor.disabled,
                      ),
                      const SizedBox(height: 16),
                      Text(state.message ?? 'Error'),
                    ],
                  ),
                );
              } else if (state is TodosLoading) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return const Text("Initial");
              }
            },
          ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => GoRouter.of(context).push('/note/new'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
