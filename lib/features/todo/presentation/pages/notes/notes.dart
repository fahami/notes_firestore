import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:notes/core/theme/color_theme.dart';
import 'package:notes/core/theme/text_theme.dart';
import 'package:notes/core/usecases/usecase.dart';
import 'package:notes/core/util/utils.dart';
import 'package:notes/di.dart';
import 'package:notes/features/todo/presentation/bloc/note_bloc.dart';

class NotesScreen extends StatelessWidget {
  NotesScreen({Key? key}) : super(key: key);
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) =>
            sl<NoteBloc>()..add(GetTodosEvent("GrFpmSJo9cUAQb537DE4")),
        child: Column(
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
                        CircleAvatar(
                          backgroundColor: ThemeColor.disabled,
                          child: Icon(
                            Icons.person,
                            color: ThemeColor.typography,
                          ),
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
                              borderSide:
                                  BorderSide(color: ThemeColor.disabled)),
                        ),
                      ),
                    ),
                    BlocBuilder<NoteBloc, NoteState>(
                      builder: (context, state) {
                        if (state is Loaded) {
                          return Text(state.todos.toString());
                        } else if (state is Error) {
                          return const Text("Error");
                        } else if (state is Loading) {
                          return const Text("Loading");
                        } else {
                          return const Text("Initial");
                        }
                      },
                    ),
                    Builder(builder: (context) {
                      return TextButton(
                          onPressed: () {
                            BlocProvider.of<NoteBloc>(context)
                                .add(GetTodosEvent("GrFpmSJo9cUAQb537DE4"));
                          },
                          child: Text("Load data"));
                    }),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
                child: MasonryGridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              itemCount: 20,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => GoRouter.of(context).push('/note/$index'),
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
                          "Dear Diary",
                          style: ThemeText.alternativeStyle.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                          style: ThemeText.captionStyle,
                          maxLines: index + 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          simpleDate(DateTime.now()
                              .add(Duration(days: index))
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
            ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => GoRouter.of(context).push('/note/new'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
