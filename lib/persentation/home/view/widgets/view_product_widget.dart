import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mini_app/persentation/common/widgets/gesture_detector/custom_gesture_detector_widget.dart';
import 'package:mini_app/persentation/common/widgets/navigation/navigation_widget.dart';
import 'package:mini_app/persentation/home/view_model/product_view_model.dart';
import 'package:mini_app/persentation/product_details/view/product_details_view.dart';

class ViewProductWidget extends StatelessWidget {
  const ViewProductWidget({
    super.key,
    required this.productViewModel,
  });
  final ProductViewModel productViewModel;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: width > 600 ? 4 : 2,
        crossAxisSpacing: width * 0.02,
        mainAxisSpacing: height * 0.02,
        mainAxisExtent: width > 600 ? height * 0.36 : width > 400 ? height * 0.37 : height * 0.38,
      ),
      itemCount: productViewModel.products?.length ?? 0,
      itemBuilder: (context, index) {
        final product = productViewModel.products![index];
        return CustomGestureDetectorWidget(
          onTap: () => navigateTo(context, ProductDetailsView(product: product)),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: width * 0.008, vertical: height * 0.008),
            padding: EdgeInsets.symmetric(horizontal: width * 0.008, vertical: height * 0.008),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 2,
                  spreadRadius: 0.5,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CachedNetworkImage(
                  imageUrl: product.image,
                  height: height * 0.2,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: height * 0.02),
                Text(
                  product.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: height * 0.02),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    'Price: \$${product.price.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 12, color: Colors.green),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
