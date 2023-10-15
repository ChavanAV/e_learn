import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MyShimmer extends StatelessWidget {
  final Widget child;
  const MyShimmer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.white,
        highlightColor: Colors.grey.shade300,
        child: child);
  }
}
