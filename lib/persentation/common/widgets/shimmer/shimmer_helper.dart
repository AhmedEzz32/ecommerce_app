// Flutter imports:
import 'package:flutter/material.dart';
import 'package:mini_app/persentation/common/widgets/shimmer/shimmer_widget.dart';

class ShimmerHelper{

  static Widget circleContainer({
    required double size,
    EdgeInsetsGeometry? margin,
    BorderRadius? radius,
  }){
    return ShimmerWidget(
      child: Padding(
        padding: margin?? const EdgeInsets.only(top: 8),
        child: SizedBox(
          height: size,
          width: size,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: RadialGradient(
                center: Alignment.center,
                stops: const [
                  0.4,
                  1,
                ],
                colors: [
                  const Color(0xFF65676B).withOpacity(0.8),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Widget rectangleContainer({
    required double width,
    required double height,
    EdgeInsetsGeometry? margin,
    BorderRadius? radius,
  }){
    return ShimmerWidget(
      child: Padding(
      padding: margin ?? const EdgeInsets.only(top: 4),
      child: SizedBox(
        height: height,
        width: width,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: radius ?? BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                blurRadius: 6,
                color: const Color(0xFF65676B).withOpacity(0.8),
              ),
            ],
          ),
        ),
      ),
        ),
    );
  }
}
