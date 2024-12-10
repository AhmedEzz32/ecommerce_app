import 'package:dartz/dartz.dart';
import 'package:mini_app/core/errors/failures.dart';
import 'package:mini_app/data/response/products_response.dart';
import 'package:mini_app/domain/repository/repository.dart';
import 'package:mini_app/domain/usecase/base_usecase.dart';

class ProductsUsecase implements BaseUsecase<void, ProductsResponse> {
  final Repository repository;

  ProductsUsecase({required this.repository});

  @override
  Future<Either<Failure, ProductsResponse>> call(void params) async {
    return await repository.getProducts();
  }
}
