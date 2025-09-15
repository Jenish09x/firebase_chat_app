import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerSkeleton extends StatelessWidget {
  final double? height;
  final double? width;
  final BorderRadiusGeometry? radius;
  final Widget? child;
  const ShimmerSkeleton({super.key, this.height, this.width, this.radius, this.child});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Builder(
        builder: (context) {
          if(child != null) return child!;
          return Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: radius
            ),
          );
        },
      ),
    );
  }
}
