import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:notes/core/theme/color_theme.dart';
import 'package:notes/core/theme/text_theme.dart';
import 'package:notes/core/util/debouncer.dart';
import 'package:notes/core/util/utils.dart';
import 'package:notes/features/todo/data/model/todo_model.dart';
import 'package:notes/features/todo/presentation/bloc/edit_todo_bloc.dart';
import 'package:notes/features/todo/presentation/bloc/todo_bloc.dart';
import 'package:notes/features/todo/presentation/cubit/color_cubit.dart';
import 'package:notes/features/todo/presentation/pages/note/widgets/delete.dart';
import 'package:notes/features/todo/presentation/pages/note/widgets/save.dart';
import 'package:notes/features/todo/presentation/pages/note/widgets/swatch.dart';
import 'package:share_plus/share_plus.dart';
import 'package:uuid/uuid.dart';

class NoteDetailScreen extends StatefulWidget {
  const NoteDetailScreen({Key? key, this.id, this.isNew = false})
      : super(key: key);
  final String? id;
  final bool isNew;

  @override
  State<NoteDetailScreen> createState() => _NoteDetailScreenState();
}

class _NoteDetailScreenState extends State<NoteDetailScreen> {
  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _contentController = TextEditingController();
  bool isAction = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final debouncer = Debouncer(milliseconds: 1000);

  var todo = TodoModel(
      id: '',
      title: '',
      isi: '',
      colorId: 1,
      reminder: DateTime.now(),
      userId: "");

  @override
  void initState() {
    todo.id = const Uuid().v1();
    todo.userId = _auth.currentUser!.uid;
    if (!widget.isNew) context.read<EditTodoBloc>().add(EditLoad(widget.id!));
    if (widget.isNew) {
      context.read<EditTodoBloc>()
        ..emit(EditLoaded(todo))
        ..add(EditSave(todo: todo));
    }
    super.initState();
  }

  List<Widget> _buildAction(BuildContext context, TodoModel todo) {
    return isAction
        ? [
            BuildSwatch(
              selectColor: (int value) {
                setState(() {
                  todo.colorId = value;
                });
              },
              context: context,
            ),
            DeleteButton(
              context: context,
              todo: todo,
            ),
            SaveButton(
              context: context,
              todo: todo,
            ),
          ]
        : [Container()];
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ColorCubit, ColorState>(
      listener: (context, state) {
        if (state is ColorLoaded) {
          setState(() {
            todo.colorId =
                int.parse(context.read<ColorCubit>().selectedColor.id);
          });
          context.read<EditTodoBloc>().add(EditSave(todo: todo));
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor:
              HexColor(context.read<ColorCubit>().selectedColor.colorType),
          appBar: AppBar(
            iconTheme: IconThemeData(color: ThemeColor.typography),
            backgroundColor: Colors.transparent,
            elevation: 0,
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            actions: [
              IconButton(
                icon: Icon(
                  Icons.share,
                  color: ThemeColor.typography,
                ),
                onPressed: () => Share.share(_contentController.text),
              ),
            ],
          ),
          body: BlocConsumer<EditTodoBloc, EditTodoState>(
            listener: (context, editState) {
              if (editState is EditLoaded) {
                if (!widget.isNew) {
                  _titleController.text = editState.todo.title;
                  _contentController.text = editState.todo.isi;
                  todo = editState.todo;
                  context
                      .read<ColorCubit>()
                      .changeColor(editState.todo.colorId.toString());
                }
              }
              if (editState is EditSaved) {
                Navigator.pop(context);
              }
              if (editState is EditDeleted) {
                Navigator.pop(context);
                context.read<TodoBloc>().add(DeleteTodoEvent(todo.id));
              }
            },
            builder: (context, editTodoState) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: BlocBuilder<EditTodoBloc, EditTodoState>(
                  builder: (context, todoState) {
                    if (todoState is EditLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (todoState is TodosError) {
                      return const Text("Error");
                    } else if (todoState is EditLoaded) {
                      final state =
                          context.read<ColorCubit>().state as ColorLoaded;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            controller: _titleController,
                            decoration: InputDecoration(
                                hintText: "Judul",
                                border: InputBorder.none,
                                hintStyle: ThemeText.alternativeStyle.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 36,
                                    color: state.color.computeLuminance() > 0.5
                                        ? ThemeColor.typography
                                        : Colors.white)),
                            style: ThemeText.alternativeStyle.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 36,
                                color: state.color.computeLuminance() > 0.5
                                    ? ThemeColor.typography
                                    : Colors.white),
                            onChanged: (v) {
                              todo.title = v;
                              print(todo.title);
                            },
                          ),
                          Text(
                            widget.isNew
                                ? "${simpleDate(DateTime.now().toIso8601String())} • ${_contentController.text.length} Karakter"
                                : "${simpleDate(todo.reminder.toIso8601String())} • ${_contentController.text.length} Karakter",
                            style: ThemeText.captionStyle.copyWith(
                                color: state.color.computeLuminance() > 0.5
                                    ? ThemeColor.disabled
                                    : Colors.white),
                          ),
                          const SizedBox(height: 8),
                          Expanded(
                            child: ListView(
                              children: [
                                TextFormField(
                                  controller: _contentController,
                                  style: ThemeText.captionStyle.copyWith(
                                      color:
                                          state.color.computeLuminance() > 0.5
                                              ? ThemeColor.typography
                                              : Colors.white),
                                  maxLines: null,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Tulis sesuatu...",
                                    hintStyle: ThemeText.captionStyle.copyWith(
                                        color:
                                            state.color.computeLuminance() > 0.5
                                                ? ThemeColor.typography
                                                : Colors.white),
                                  ),
                                  onChanged: (v) {
                                    setState(() {
                                      todo.isi = v;
                                      todo.reminder = DateTime.now();
                                    });

                                    debouncer.run(() {
                                      context
                                          .read<EditTodoBloc>()
                                          .add(EditSave(todo: todo));
                                    });
                                  },
                                )
                              ],
                            ),
                          )
                        ],
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              );
            },
          ),
          bottomNavigationBar: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  spreadRadius: 8,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedSwitcher(
                    switchInCurve: Curves.bounceIn,
                    switchOutCurve: Curves.easeOutCirc,
                    duration: const Duration(seconds: 2),
                    child: Column(
                      children: _buildAction(context, todo),
                    )),
                ListTile(
                  leading: context.read<EditTodoBloc>().state is EditSaved
                      ? Icon(Icons.check,
                          color: ThemeColor.greenish,
                          key: const Key("auto-save"))
                      : const SizedBox(),
                  title: Text(
                    widget.isNew
                        ? "${simpleDate(DateTime.now().toIso8601String())} • ${_contentController.text.length} Karakter"
                        : "${simpleDate(todo.reminder.toIso8601String())} • ${_contentController.text.length} Karakter",
                    style: ThemeText.captionStyle
                        .copyWith(color: ThemeColor.caption),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      setState(() {
                        isAction = !isAction;
                      });
                    },
                    icon: Icon(
                      Icons.more_vert,
                      color: ThemeColor.typography,
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
