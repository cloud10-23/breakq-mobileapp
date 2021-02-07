import 'package:flutter/material.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/utils/text_style.dart';

/// Bold title.
///
/// Used on [HomeScreen].
class BoldTitle extends StatelessWidget {
  const BoldTitle({
    Key key,
    @required this.title,
    this.onNavigate,
    this.padding,
    this.textAlign,
    this.maxLines = 1,
    this.color,
  }) : super(key: key);

  final String title;
  final VoidCallback onNavigate;
  final EdgeInsetsGeometry padding;
  final int maxLines;
  final TextAlign textAlign;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ??
          const EdgeInsets.only(
              left: kPaddingM,
              right: kPaddingS,
              top: kPaddingM,
              bottom: kPaddingM),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .w800
                .copyWith(color: color ?? Colors.black),
            maxLines: maxLines,
            overflow: TextOverflow.ellipsis,
            textAlign: textAlign ?? TextAlign.left,
          ),
          if (onNavigate != null)
            InkWell(
              child: const Icon(
                Icons.navigate_next,
                size: 32,
              ),
              onTap: onNavigate,
            ),
        ],
      ),
    );
  }
}

class CustomTitle extends StatelessWidget {
  const CustomTitle({
    Key key,
    @required this.title,
    this.padding,
    this.textAlign,
    this.fw,
    this.maxLines = 1,
    this.color,
  }) : super(key: key);

  final String title;
  final EdgeInsetsGeometry padding;
  final int maxLines;
  final FontWeight fw;
  final TextAlign textAlign;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ??
          const EdgeInsets.only(
              left: kPaddingM,
              right: kPaddingS,
              top: kPaddingM,
              bottom: kPaddingM),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            title,
            style: Theme.of(context).textTheme.headline6.copyWith(
                  fontWeight: (fw != null) ? fw : FontWeight.w800,
                  color: (color != null) ? color : Colors.black,
                ),
            maxLines: maxLines,
            overflow: TextOverflow.ellipsis,
            textAlign: textAlign ?? TextAlign.left,
          ),
        ],
      ),
    );
  }
}
