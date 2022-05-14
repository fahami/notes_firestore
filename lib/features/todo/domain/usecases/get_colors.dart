import 'package:dartz/dartz.dart';
import 'package:notes/core/error/failures.dart';
import 'package:notes/features/todo/domain/entities/color.dart';
import 'package:notes/features/todo/domain/repositories/colors_repository.dart';

class GetTodoColor extends TodoColorsRepository {
  final TodoColorsRepository repository;

  GetTodoColor(this.repository);

  @override
  Future<Either<Failure, List<TodoColor>>> getColors() async {
    return await repository.getColors();
  }
}
