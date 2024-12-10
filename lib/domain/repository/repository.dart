import 'package:dartz/dartz.dart';
import 'package:mini_app/core/errors/failures.dart';
import 'package:mini_app/data/response/products_response.dart';

abstract class Repository {
  Future<Either<Failure, ProductsResponse>> getProducts();
}
