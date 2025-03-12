import 'package:flutter/material.dart';
import 'package:mini_app/generated/l10n.dart';
import 'widgets/cart_view_body.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.total),
      ),
      body: const CartViewBody(),
    );
  }
}
