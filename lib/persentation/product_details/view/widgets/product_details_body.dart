import 'package:flutter/material.dart';
import 'package:mini_app/core/di/service_locators.dart';
import 'package:mini_app/domain/models/product_model.dart';
import 'package:mini_app/generated/l10n.dart';
import 'package:mini_app/persentation/cart_view/view_model/cart_view_model.dart';
import 'add_to_cart_widget.dart';
import 'product_details_image_widget.dart';

class ProductDetailsBody extends StatelessWidget {
  final ProductModel product;
  const ProductDetailsBody({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final cartViewModel = getIt<CartViewModel>();
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductDetailsImageWidget(product: product),
            const SizedBox(height: 16),
            Text(
              product.title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              '${S.current.price}: \$${product.price.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18, color: Colors.green),
            ),
            const SizedBox(height: 16),
            Text(
              product.description,
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
            const Spacer(),
            AddToCartWidget(cartViewModel: cartViewModel, product: product),
          ],
        ),
      );
  }
}
