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
    this.fw,
    this.isNum = false,
  }) : super(key: key);

  final String title;
  final VoidCallback onNavigate;
  final EdgeInsetsGeometry padding;
  final int maxLines;
  final TextAlign textAlign;
  final Color color;
  final FontWeight fw;
  final bool isNum;

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
            style: Theme.of(context).textTheme.bodyText1.copyWith(
                color: color ?? Colors.black,
                fontWeight: (fw != null) ? fw : FontWeight.w800,
                fontFamily: (isNum) ? kNumberFontFamily : kFontFamily),
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
    this.fw = FontWeight.w800,
    this.maxLines = 1,
    this.color = Colors.black,
    this.isNum = false,
  }) : super(key: key);

  final String title;
  final EdgeInsetsGeometry padding;
  final int maxLines;
  final FontWeight fw;
  final TextAlign textAlign;
  final Color color;
  final bool isNum;

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
                  fontWeight: fw,
                  color: color,
                  fontFamily: (isNum) ? kNumberFontFamily : kFontFamily,
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
