import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/core/theme/color_theme.dart';
import 'package:notes/core/util/debouncer.dart';
import 'package:notes/features/todo/presentation/bloc/todo_bloc.dart';

class SearchBar extends StatelessWidget {
  SearchBar({Key? key}) : super(key: key);

  final TextEditingController _searchController = TextEditingController();
  final Debouncer _debouncer = Debouncer(milliseconds: 500);
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: TextField(
        controller: _searchController,
        enableSuggestions: true,
        decoration: InputDecoration(
          hintText: "Cari catatanmu...",
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(200),
            borderSide: BorderSide(color: ThemeColor.disabled),
          ),
        ),
        onChanged: (query) {
          if (query.length > 3) {
            _debouncer.run(
              () => context.read<TodoBloc>().add(SearchTodoEvent(query)),
            );
          } else {
            _debouncer.run(
              () => context
                  .read<TodoBloc>()
                  .add(GetTodosEvent(_auth.currentUser!.uid)),
            );
          }
        },
      ),
    );
  }
}
