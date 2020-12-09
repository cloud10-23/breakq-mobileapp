import 'package:flutter/material.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/utils/text_style.dart';

class UppercaseTitle extends StatelessWidget {
  const UppercaseTitle({
    Key key,
    this.title,
    this.padding,
  }) : super(key: key);

  final String title;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.only(top: kPaddingL),
      child: Text(
        (title ?? '').toUpperCase(),
        style: Theme.of(context).textTheme.bodyText2.w800,
      ),
    );
  }
}
