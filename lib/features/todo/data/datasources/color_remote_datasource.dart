import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notes/core/error/exception.dart';
import 'package:notes/features/todo/data/model/color_model.dart';

abstract class ColorRemoteDataSource {
  Future<List<ColorModel>> getColors();
}

class ColorRemoteDataSourceImpl implements ColorRemoteDataSource {
  final FirebaseFirestore fireStore;

  ColorRemoteDataSourceImpl(this.fireStore);

  @override
  Future<List<ColorModel>> getColors() async {
    final db = fireStore.collection('colors');
    final colors = await db.get().then((snapshot) => snapshot.docs.map((doc) {
          final color = ColorModel.fromJson(doc.data());
          color.id = doc.id;
          return color;
        }).toList());
    if (colors.isNotEmpty) {
      return colors;
    } else {
      throw ServerException('No todos found');
    }
  }
}
