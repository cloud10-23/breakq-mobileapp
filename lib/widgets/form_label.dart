import 'package:flutter/material.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/utils/text_style.dart';

/// Generic form label.
class FormLabel extends StatelessWidget {
  const FormLabel({
    Key key,
    @required this.text,
    this.padding,
  }) : super(key: key);

  /// label text.
  final String text;

  /// Optional label padding.
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          padding ?? const EdgeInsets.only(bottom: kPaddingS, top: kPaddingM),
      child: Text(
        text,
        style: Theme.of(context).inputDecorationTheme.labelStyle.w600,
      ),
    );
  }
}
