import 'package:notes/features/todo/domain/entities/color.dart';

class ColorModel extends TodoColor {
  ColorModel({
    required String id,
    required String colorName,
    required String colorType,
  }) : super(id, colorName, colorType);

  factory ColorModel.fromJson(Map<String, dynamic> json) => ColorModel(
        id: json['id'] ?? '',
        colorName: json['color_name'],
        colorType: json['color_type'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'color_name': colorName,
        'color_type': colorType,
      };
}
