import 'package:flutter/material.dart';
import 'package:mini_app/persentation/cart_view/view/widgets/total_cart_widget.dart';
import 'cart_view_added_widget.dart';

class CartViewBody extends StatelessWidget {
  const CartViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          CartViewAddedWidget(),
          Divider(),
          TotalCartViewWidget(),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
