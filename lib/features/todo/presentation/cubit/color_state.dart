part of 'color_cubit.dart';

abstract class ColorState extends Equatable {
  const ColorState();

  @override
  List<Object> get props => [];
}

class ColorInitial extends ColorState {
  const ColorInitial() : super();
}

class ColorLoading extends ColorState {
  const ColorLoading() : super();
}

class ColorLoaded extends ColorState {
  final Color color;
  const ColorLoaded(this.color) : super();
}

class ColorReset extends ColorState {
  const ColorReset() : super();
}

class ColorsLoaded extends ColorState {
  final List<TodoColor> colors;
  const ColorsLoaded(this.colors) : super();
}

class ColorError extends ColorState {
  const ColorError() : super();
}
