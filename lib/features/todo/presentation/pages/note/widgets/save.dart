import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/core/theme/color_theme.dart';
import 'package:notes/core/theme/text_theme.dart';
import 'package:notes/features/todo/data/model/todo_model.dart';
import 'package:notes/features/todo/presentation/bloc/edit_todo_bloc.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({
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
        Icons.save,
        color: ThemeColor.typography,
      ),
      title: Text(
        "Simpan",
        style: ThemeText.bodyStyle,
      ),
      onTap: () {
        todo.reminder = DateTime.now();
        context.read<EditTodoBloc>().add(EditSave(todo: todo));
      },
    );
  }
}
