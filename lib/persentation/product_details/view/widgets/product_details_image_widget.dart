import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mini_app/domain/models/product_model.dart';

class ProductDetailsImageWidget extends StatelessWidget {
  const ProductDetailsImageWidget({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CachedNetworkImage(
        imageUrl: product.image,
        height: 200,
        fit: BoxFit.contain,
      ),
    );
  }
}
