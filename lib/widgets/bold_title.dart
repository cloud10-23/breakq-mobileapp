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
  }) : super(key: key);

  final String title;
  final VoidCallback onNavigate;
  final EdgeInsetsGeometry padding;
  final int maxLines;
  final TextAlign textAlign;

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
        children: <Widget>[
          Expanded(
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodyText1.w800,
              maxLines: maxLines,
              overflow: TextOverflow.ellipsis,
              textAlign: textAlign ?? TextAlign.left,
            ),
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
