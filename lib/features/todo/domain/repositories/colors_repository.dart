import 'package:dartz/dartz.dart';
import 'package:notes/core/error/failures.dart';
import 'package:notes/features/todo/domain/entities/color.dart';

abstract class TodoColorsRepository {
  Future<Either<Failure, List<TodoColor>>> getColors();
}
