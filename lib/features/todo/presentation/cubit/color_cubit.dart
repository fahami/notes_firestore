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
  ColorCubit(this.getTodoColors) : super(const ColorInitial());

  List<TodoColor> colors = [];
  TodoColor selectedColor = TodoColor("1", "yellow", "#FFD633");

  void changeColor(String colorId) {
    emit(const ColorLoading());
    final color = colors.firstWhere((color) => color.id == colorId);
    selectedColor = color;
    emit(ColorChanged(HexColor(color.colorType)));
  }

  void resetColor() {
    emit(const ColorReset());
  }

  void getColors() async {
    emit(const ColorLoading());
    final failureOrColors = await getTodoColors(NoParams());
    failureOrColors.fold(
      (failure) => emit(const ColorError()),
      (colors) {
        this.colors = colors;
        emit(ColorsLoaded(colors));
      },
    );
  }
}
