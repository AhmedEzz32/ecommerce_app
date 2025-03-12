import 'package:flutter/material.dart';
import 'package:mini_app/persentation/common/widgets/navigation/navigation_widget.dart';
import 'package:mini_app/persentation/home/view/widgets/product_search.dart';
import '../../../cart_view/view/cart_view.dart';
import 'package:mini_app/persentation/home/view_model/product_view_model.dart';

class HomeViewAppBar extends StatelessWidget implements PreferredSizeWidget {
  final ProductViewModel productViewModel;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  const HomeViewAppBar({super.key, required this.productViewModel});

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
        IconButton(
          icon: const Icon(
            Icons.search,
            color: Colors.white70,
          ),
          onPressed: () {
            showSearch(context: context, delegate: ProductSearchDelegate(productViewModel));
          },
        ),
        TextButton.icon(
          label: const Text('myCart'),
          style: TextButton.styleFrom(foregroundColor: Colors.white),
          icon: const Icon(Icons.shopping_cart),
          onPressed: () {
            navigateTo(context, const CartScreen());
          },
        ),
      ],
    );
  }
}
