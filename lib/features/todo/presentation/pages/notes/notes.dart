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
import 'package:notes/features/todo/presentation/pages/notes/widgets/search_bar.dart';

class NotesScreen extends StatelessWidget {
  NotesScreen({Key? key}) : super(key: key);
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    context.read<ColorCubit>().getColors();

    return Scaffold(
      backgroundColor: Colors.white,
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
                  SearchBar(),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(child: BlocBuilder<TodoBloc, TodoState>(
            builder: (context, state) {
              if (state is TodosLoaded) {
                if (state.todos.isEmpty) {
                  return Center(
                    child: Text(
                      "Tidak ada catatan",
                      style: ThemeText.titleStyle
                          .copyWith(color: ThemeColor.disabled, fontSize: 18),
                    ),
                  );
                }
                return RefreshIndicator(
                  onRefresh: () async {
                    context
                        .read<TodoBloc>()
                        .add(GetTodosEvent(_auth.currentUser!.uid));
                  },
                  child: MasonryGridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    itemCount: state.todos.length,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemBuilder: (context, index) {
                      return InkWell(
                        key: Key("note_${state.todos[index].id}"),
                        onTap: () => GoRouter.of(context)
                            .push('/note/${state.todos[index].id}'),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: ThemeColor.grey),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.todos.elementAt(index).title,
                                style: ThemeText.alternativeStyle.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                state.todos.elementAt(index).isi,
                                style: ThemeText.captionStyle,
                                maxLines: 7,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                simpleDate(state.todos
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
