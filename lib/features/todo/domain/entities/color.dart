import 'package:equatable/equatable.dart';

class TodoColor extends Equatable {
  final int id;
  final String colorType;

  const TodoColor(this.id, this.colorType);

  @override
  List<Object?> get props => [id, colorType];
}
