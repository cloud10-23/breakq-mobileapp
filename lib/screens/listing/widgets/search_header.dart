import 'package:flutter/material.dart';

class SearchHeader extends SliverPersistentHeaderDelegate {
  SearchHeader({
    this.child,
    this.expandedHeight,
  });

  final double expandedHeight;
  final Widget child;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => expandedHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
