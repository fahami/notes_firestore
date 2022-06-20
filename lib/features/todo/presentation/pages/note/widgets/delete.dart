import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/core/theme/color_theme.dart';
import 'package:notes/core/theme/text_theme.dart';
import 'package:notes/features/todo/data/model/todo_model.dart';
import 'package:notes/features/todo/presentation/bloc/edit_todo_bloc.dart';
import 'package:notes/features/todo/presentation/bloc/todo_bloc.dart';

class DeleteButton extends StatelessWidget {
  const DeleteButton({
    Key? key,
    required this.context,
    required this.todo,
  }) : super(key: key);

  final BuildContext context;
  final TodoModel todo;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.delete,
        color: ThemeColor.typography,
      ),
      title: Text(
        "Hapus",
        style: ThemeText.bodyStyle,
      ),
      onTap: () {
        context.read<EditTodoBloc>().add(EditDelete(todo.id));
        context
            .read<TodoBloc>()
            .todos
            .removeWhere((element) => element == todo);
      },
    );
  }
}
