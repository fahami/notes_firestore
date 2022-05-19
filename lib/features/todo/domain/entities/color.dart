import 'package:equatable/equatable.dart';

class TodoColor extends Equatable {
  String id;
  final String colorType;

  TodoColor(this.id, this.colorType);

  @override
  List<Object?> get props => [id, colorType];
}
