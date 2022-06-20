import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:notes/core/theme/color_theme.dart';
import 'package:notes/features/todo/presentation/cubit/color_cubit.dart';

class BuildSwatch extends StatelessWidget {
  const BuildSwatch({
    Key? key,
    required this.selectColor,
    required this.context,
  }) : super(key: key);
  final ValueChanged<int> selectColor;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: BlocBuilder<ColorCubit, ColorState>(
        builder: (context, state) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: context.read<ColorCubit>().colors.length,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(right: 16),
                child: InkWell(
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: HexColor(
                          context.read<ColorCubit>().colors[index].colorType),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: HexColor(context
                                        .read<ColorCubit>()
                                        .colors[index]
                                        .colorType)
                                    .computeLuminance() >
                                0.5
                            ? ThemeColor.disabled
                            : Colors.white,
                        width: 2,
                      ),
                    ),
                  ),
                  onTap: () {
                    selectColor(
                        int.parse(context.read<ColorCubit>().colors[index].id));
                    context.read<ColorCubit>().changeColor(
                        context.read<ColorCubit>().colors[index].id);

                    // context.read<EditTodoBloc>().add(SaveTodo(todo: todo));
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
