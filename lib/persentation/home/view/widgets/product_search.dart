import 'package:flutter/material.dart';
import 'package:mini_app/persentation/home/view_model/product_view_model.dart';
import 'package:mini_app/persentation/product_details/view/product_details_view.dart';

class ProductSearchDelegate extends SearchDelegate<String> {
  final ProductViewModel productViewModel;

  ProductSearchDelegate(this.productViewModel);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';  // Clear search input
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, ''); // Close search
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildProductList();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildProductList();
  }

  Widget _buildProductList() {
    final filteredProducts = productViewModel.products?.where((product) {
      return product.title.toLowerCase().contains(query.toLowerCase());
    }).toList() ?? [];

    if (filteredProducts.isEmpty) {
      return const Center(child: Text("No products found"));
    }

    return ListView.builder(
      itemCount: filteredProducts.length,
      itemBuilder: (context, index) {
        final product = filteredProducts[index];
        return ListTile(
          leading: Image.network(product.image, width: 50, height: 50, fit: BoxFit.cover),
          title: Text(product.title),
          subtitle: Text("\$${product.price.toStringAsFixed(2)}"),
          onTap: () {
            close(context, product.title); // Close search
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ProductDetailsView(product: product)),
            );
          },
        );
      },
    );
  }
}
