import 'package:notes/features/todo/domain/entities/color.dart';

class ColorModel extends TodoColor {
  const ColorModel({
    required int id,
    required String colorType,
  }) : super(id, colorType);

  factory ColorModel.fromJson(Map<String, dynamic> json) => ColorModel(
        id: json['id'],
        colorType: json['colorType'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'colorType': colorType,
      };
}
