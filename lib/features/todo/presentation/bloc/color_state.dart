part of 'color_bloc.dart';

@freezed
class ColorState with _$ColorState {
  const factory ColorState.initial() = Initial;
  const factory ColorState.loading() = Loading;
  const factory ColorState.loaded({required List<TodoColor> colors}) = Loaded;
  const factory ColorState.error() = Error;
}
