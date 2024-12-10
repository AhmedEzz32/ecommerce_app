import 'package:flutter/material.dart';
import 'package:mini_app/persentation/common/widgets/navigation/navigation_widget.dart';

import '../../../cart_view/view/cart_view.dart';

class HomeViewAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  const HomeViewAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple, Colors.blue],
          ),
        ),
      ),
      title: const Text('Products'),
      actions: [
        TextButton.icon(
          label: const Text('myCart'),
          style: TextButton.styleFrom(foregroundColor: Colors.white),
          icon: const Icon(Icons.shopping_cart),
          onPressed: () {
            navigateTo(context, const CartScreen());
          },
        )
      ],
    );
  }
}
