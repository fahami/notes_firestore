import 'package:dartz/dartz.dart';
import 'package:notes/core/error/exception.dart';
import 'package:notes/core/error/failures.dart';
import 'package:notes/core/network/network_info.dart';
import 'package:notes/features/todo/data/datasources/color_local_datasource.dart';
import 'package:notes/features/todo/data/datasources/color_remote_datasource.dart';
import 'package:notes/features/todo/domain/entities/color.dart';
import 'package:notes/features/todo/domain/repositories/colors_repository.dart';

class TodoColorRepositoryImpl extends TodoColorsRepository {
  final ColorRemoteDataSource remoteDataSource;
  final ColorLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  TodoColorRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<TodoColor>>> getColors() async {
    if (await networkInfo.isConnected) {
      try {
        final colors = await remoteDataSource.getColors();
        colors.map((e) => localDataSource.cacheColor(e));
        return Right(colors);
      } on ServerException {
        return const Left(ServerFailure());
      }
    } else {
      try {
        final colors = await localDataSource.getColors();
        return Right(colors);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
