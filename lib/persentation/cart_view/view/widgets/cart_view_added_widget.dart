import 'package:flutter/material.dart';
import 'package:mini_app/generated/l10n.dart';
import 'package:mini_app/persentation/cart_view/view_model/cart_view_model.dart';
import 'package:provider/provider.dart';

class CartViewAddedWidget extends StatelessWidget {
  const CartViewAddedWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<CartViewModel>(
      builder: (context, cartViewModel, child) {
        return Expanded(
          child: cartViewModel.cartItems.isEmpty
              ? Center(
                  child: Text('${S.current.your_cart_is_empty}!', style: const TextStyle(fontSize: 18)),
                )
              : ListView.builder(
                  itemCount: cartViewModel.cartItems.length,
                  itemBuilder: (context, index) {
                    final item = cartViewModel.cartItems[index];
                    return ListTile(
                      leading: Image.network(item.image, height: 50, width: 50),
                      title: Text(item.title),
                      subtitle: Text('\$${item.price.toStringAsFixed(2)}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.remove_circle),
                        onPressed: () {
                          cartViewModel.removeFromCart(item);
                        },
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}
