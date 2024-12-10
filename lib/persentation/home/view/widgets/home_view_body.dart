import 'package:flutter/material.dart';
import 'package:mini_app/persentation/home/view_model/product_view_model.dart';
import 'package:mini_app/persentation/home/view/widgets/shimmer_loading_indicator_widget.dart';
import 'package:mini_app/persentation/home/view/widgets/view_product_widget.dart';

class HomeViewBody extends StatelessWidget {
  final ProductViewModel productViewModel;
  const HomeViewBody({super.key, required this.productViewModel});

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<void>(
      future: productViewModel.fetchProducts(),
      builder: (context, snapshot) {
        if (productViewModel.isLoading) {
          return const ShimmerLoadingIndicatorWidget();
        } else if (productViewModel.error != null) {
          return Center(child: Text('Error: ${productViewModel.error}'));
        } else {
          return ViewProductWidget(
            productViewModel: productViewModel,
          );
        }
      },
    );
  }
}
