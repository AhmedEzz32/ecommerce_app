import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mini_app/core/errors/failures.dart';
import 'package:mini_app/data/data_source/remote_data_source.dart';
import 'package:mini_app/data/response/products_response.dart';
import 'package:mini_app/domain/repository/repository.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource remoteDataSource;

  RepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, ProductsResponse>> getProducts() async {
    try {
      return Right(await remoteDataSource.getProducts());
    } catch (e) {
      if(e is DioException){ {
        return Left(ServerFailure.fromDioError(e));
      }
      } else {
        return Left(ServerFailure(e.toString()));
      }
    }
  }
}
