import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:notes/core/usecases/usecase.dart';
import 'package:notes/features/todo/domain/entities/color.dart';
import 'package:notes/features/todo/domain/usecases/get_colors.dart';

part 'color_state.dart';

class ColorCubit extends Cubit<ColorState> {
  final GetTodoColor getTodoColors;
  ColorCubit(this.getTodoColors) : super(const ColorLoaded(Colors.white));

  List<TodoColor> colors = [];
  final defaultTodoColor = TodoColor("6", "white", "#ffffff");
  TodoColor selectedColor = TodoColor("6", "white", "#ffffff");

  void changeColor(String colorId) {
    emit(const ColorLoading());
    final color = colors.firstWhere((color) => color.id == colorId);
    selectedColor = color;
    emit(ColorLoaded(HexColor(color.colorType)));
  }

  void resetColor() {
    emit(const ColorReset());
  }

  void getColors() async {
    selectedColor = defaultTodoColor;
    final failureOrColors = await getTodoColors(NoParams());
    failureOrColors.fold(
      (failure) => emit(const ColorError()),
      (colors) => this.colors = colors,
    );
  }
}
