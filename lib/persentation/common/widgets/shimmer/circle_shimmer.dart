// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:fade_shimmer/fade_shimmer.dart';


class CircleShimmer extends StatelessWidget {

  final double size;
  final Color? baseColor;
  final Color? highlightColor;
  final int millisecondsDelay;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  const CircleShimmer({
    super.key,
    required this.size,
    this.baseColor,
    this.highlightColor,
    this.millisecondsDelay = 0,
    this.margin,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      child: FadeShimmer.round(
        size: size,
        highlightColor: highlightColor ??  const Color(0xFFF0F0F3),
        baseColor: baseColor ?? const Color(0xFFD1D3D6),
        millisecondsDelay: millisecondsDelay,
      ),
    );
  }
}
