import 'package:flutter/material.dart';
import 'package:breakq/configs/constants.dart';
import 'package:shimmer/shimmer.dart';

/// A convenient widget to create a [Shimmer] box where needed to present a
/// loading state.
class ShimmerBox extends StatelessWidget {
  const ShimmerBox({
    Key key,
    this.width,
    @required this.height,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.only(right: kPaddingS),
      child: SizedBox(
        width: width,
        height: height,
        child: Shimmer.fromColors(
          baseColor: Theme.of(context).hoverColor,
          highlightColor: Theme.of(context).dividerColor,
          enabled: true,
          child: Container(
            decoration: BoxDecoration(
              color: kWhite,
              borderRadius: BorderRadius.circular(kBoxDecorationRadius),
            ),
          ),
        ),
      ),
    );
  }
}
