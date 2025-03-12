import 'package:flutter/material.dart';
import 'package:mini_app/persentation/cart_view/view/widgets/stripe_widget.dart';
import 'package:mini_app/persentation/cart_view/view_model/cart_view_model.dart';
import 'package:provider/provider.dart';

class TotalCartViewWidget extends StatelessWidget {
  const TotalCartViewWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<CartViewModel>(
      builder: (context, cartViewModel, child) {
        return Column(
          children: [
            Text(
              'Total: \$${cartViewModel.totalPrice.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            if (cartViewModel.cartItems.isNotEmpty)
              StripeWidget(
                amount: cartViewModel.totalPrice,
              ),
          ],
        );
      },
    );
  }
}
