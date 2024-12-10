// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:fade_shimmer/fade_shimmer.dart';

class Shimmer extends StatelessWidget {

  final double width;
  final double height;
  final double radius;
  final Color? highlightColor;
  final Color? baseColor;
  final FadeTheme? fadeTheme;
  final int millisecondsDelay;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final AlignmentGeometry? alignment;

  const Shimmer({
    super.key,
    required this.width,
    required this.height,
    this.radius = 0,
    this.highlightColor,
    this.baseColor,
    this.fadeTheme,
    this.millisecondsDelay = 0,
    this.margin,
    this.padding,
    this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      alignment: alignment,
      child: FadeShimmer(
        width: width,
        height: height,
        radius: radius,
        highlightColor: highlightColor ??const Color(0xFFF0F0F3),
        baseColor: baseColor ??const Color(0xFFD1D3D6),
        millisecondsDelay: millisecondsDelay,
        // fadeTheme: fadeTheme,
      ),
    );
  }
}
