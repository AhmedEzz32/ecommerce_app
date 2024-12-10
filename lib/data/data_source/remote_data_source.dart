import 'package:mini_app/data/network/services/api_service.dart';
import 'package:mini_app/data/response/products_response.dart';

abstract class RemoteDataSource {
  Future<ProductsResponse> getProducts();
}
class RemoteDataSourceImpl implements RemoteDataSource {
  final ApiService apiService;

  RemoteDataSourceImpl({required this.apiService});
  @override
  Future<ProductsResponse> getProducts() async{
    return await apiService.getProducts();
  }
}