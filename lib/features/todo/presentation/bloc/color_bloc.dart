import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:notes/core/usecases/usecase.dart';
import 'package:notes/features/todo/domain/entities/color.dart';
import 'package:notes/features/todo/domain/usecases/get_colors.dart';

part 'color_event.dart';
part 'color_state.dart';
part 'color_bloc.freezed.dart';

class ColorBloc extends Bloc<ColorEvent, ColorState> {
  final GetTodoColor getColors;
  ColorBloc({
    required this.getColors,
  }) : super(const Initial()) {
    on<GetColors>((event, emit) async {
      emit(const Loading());
      final failureOrColors = await getColors(NoParams());
      failureOrColors.fold(
        (failure) => emit(const Error()),
        (colors) => emit(Loaded(colors: colors)),
      );
    });
  }
}
