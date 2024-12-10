import 'package:flutter/material.dart';
import 'widgets/cart_view_body.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
      ),
      body: const CartViewBody(),
    );
  }
}
