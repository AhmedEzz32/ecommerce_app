import 'package:flutter/material.dart';
import 'package:mini_app/core/di/service_locators.dart';
import 'package:mini_app/domain/repository/repository.dart';
import 'package:mini_app/domain/usecase/products_usecase.dart';
import '../../../domain/models/product_model.dart';

class ProductViewModel extends ChangeNotifier {

  List<ProductModel>? _products;
  bool _isLoading = true;
  String? _error;

  List<ProductModel>? get products => _products;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchProducts() async {
    final ProductsUsecase usecase = ProductsUsecase(repository: getIt<Repository>());
    final result = await usecase.call(null);
    result.fold(
      (failure) {
        _error = failure.toString();
        _isLoading = false;
        notifyListeners();
      },
      (response) {
        _products = response.products;
        _isLoading = false;
        notifyListeners();
      },
    );
  }
}
