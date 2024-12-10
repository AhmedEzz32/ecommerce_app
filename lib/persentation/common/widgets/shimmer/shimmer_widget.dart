// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:shimmer/shimmer.dart';


class ShimmerWidget extends StatelessWidget {
  final Widget child;
  final Color? baseColor;
  final Color? highlightColor;

  const ShimmerWidget({
    super.key,
    required this.child,
    this.baseColor,
    this.highlightColor,
  });

  @override
  Widget build(BuildContext context) {
    if(kIsWeb){
      return child;
      // return RepaintBoundary(
      //   child: AnimationShimmerWidget(
      //     child: child,
      //   ),
      // );
    }
    return RepaintBoundary(
      child: Shimmer.fromColors(
        baseColor: baseColor ?? Colors.white,
        highlightColor: highlightColor ?? const Color(0xFF65676B).withAlpha(30),
        child: child,
      ),
    );
  }
}
