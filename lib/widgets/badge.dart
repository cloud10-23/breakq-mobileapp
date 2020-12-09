import 'package:flutter/material.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/utils/text_style.dart';

/// Generic purpose badge style label.
class Badge extends StatelessWidget {
  const Badge({
    Key key,
    @required this.text,
    this.color = Colors.black87,
    this.backgroundColor,
    this.showLoading = false,
  }) : super(key: key);

  final String text;
  final Color color;
  final Color backgroundColor;
  final bool showLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          vertical: kPaddingS / 2, horizontal: kPaddingS),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: backgroundColor ?? Theme.of(context).highlightColor,
        borderRadius: const BorderRadius.all(Radius.circular(kBadgeRadius)),
      ),
      child: Text(
        showLoading ? '?' : text,
        style:
            Theme.of(context).textTheme.bodyText2.w500.copyWith(color: color),
      ),
    );
  }
}
