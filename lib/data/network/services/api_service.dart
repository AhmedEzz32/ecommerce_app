import 'package:dio/dio.dart';
import 'package:mini_app/data/response/products_response.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: "https://dummyjson.com/")
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET("/products?limit=10")
  Future<ProductsResponse> getProducts();
}
