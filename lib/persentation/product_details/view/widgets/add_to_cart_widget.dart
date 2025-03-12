import 'package:flutter/material.dart';
import 'package:mini_app/domain/models/cart_item_model.dart';
import 'package:mini_app/domain/models/product_model.dart';
import 'package:mini_app/generated/l10n.dart';
import 'package:mini_app/persentation/cart_view/view_model/cart_view_model.dart';

class AddToCartWidget extends StatelessWidget {
  const AddToCartWidget({
    super.key,
    required this.cartViewModel,
    required this.product,
  });

  final CartViewModel cartViewModel;
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        cartViewModel.addToCart(
          CartItem(
            title: product.title, 
            price: product.price, 
            image: product.image,
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${product.title} ${S.current.added_to_cart}!'),
            duration: const Duration(seconds: 2),
          ),
        );
      },
      icon: const Icon(Icons.shopping_cart),
      label: Text(S.current.add_to_cart),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.lightBlue,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}
