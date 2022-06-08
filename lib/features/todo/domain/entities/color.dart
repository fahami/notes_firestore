import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
part 'color.g.dart';

@HiveType(typeId: 1)
class TodoColor extends HiveObject with EquatableMixin {
  @HiveField(0)
  String id;
  @HiveField(1)
  final String colorType;

  TodoColor(this.id, this.colorType);

  @override
  List<Object?> get props => [id, colorType];
}
