import 'dart:math' as math;

import 'package:breakq/configs/constants.dart';
import 'package:breakq/utils/text_style.dart';
import 'package:flutter/material.dart';

SliverPersistentHeader makeHeader(BuildContext context, String headerText) {
  return SliverPersistentHeader(
    pinned: true,
    delegate: ServiceHeaderDelegate(
      minHeight: kPaddingM * 9,
      maxHeight: kPaddingM * 9,
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: kPaddingL * 2, vertical: kPaddingM),
          child: Text(
            headerText,
            style: Theme.of(context).textTheme.headline5,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    ),
  );
}

class ServiceHeaderDelegate extends SliverPersistentHeaderDelegate {
  ServiceHeaderDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => math.max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(ServiceHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
