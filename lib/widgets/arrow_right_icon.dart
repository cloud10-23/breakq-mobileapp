import 'package:flutter/material.dart';

/// [Icon] used in lists.
class ArrowRightIcon extends StatelessWidget {
  const ArrowRightIcon({
    Key key,
    this.size = 15,
  }) : super(key: key);

  final double size;

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.keyboard_arrow_right,
      size: size,
    );
  }
}
