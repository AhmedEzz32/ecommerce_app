import 'package:flutter/material.dart';
import 'package:mini_app/domain/models/product_model.dart';
import 'package:mini_app/persentation/product_details/view/widgets/product_details_body.dart';

class ProductDetailsView extends StatelessWidget {
  final ProductModel product;
  const ProductDetailsView({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: ProductDetailsBody(product: product)
    );
  }
}
