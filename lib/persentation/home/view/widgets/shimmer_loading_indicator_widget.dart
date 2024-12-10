import 'package:flutter/material.dart';
import 'package:mini_app/persentation/common/widgets/shimmer/shimmer_helper.dart';
import 'package:mini_app/persentation/common/widgets/shimmer/shimmer_widget.dart';

class ShimmerLoadingIndicatorWidget extends StatelessWidget {
  const ShimmerLoadingIndicatorWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ShimmerWidget(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ShimmerHelper.circleContainer(size: 60),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShimmerHelper.rectangleContainer(width: 120, height: 10),
                      const SizedBox(height: 4.0,),
                      ShimmerHelper.rectangleContainer(width: 80, height: 8),
                    ],
                  ),
                  const Spacer(),
                  ShimmerHelper.rectangleContainer(width: 30, height: 10),
                ],
              ),
              const SizedBox(height: 12.0,),
              ShimmerHelper.rectangleContainer(width: 300, height: 10),
              const SizedBox(height: 8.0,),
              ShimmerHelper.rectangleContainer(width: 290, height: 10),
              const SizedBox(height: 8.0,),
              ShimmerHelper.rectangleContainer(width: 100, height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
