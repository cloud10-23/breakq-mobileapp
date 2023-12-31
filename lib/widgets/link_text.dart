import 'package:flutter/material.dart';
import 'package:breakq/utils/text_style.dart';

/// Text text. Similar to [LinkButton].
class LinkText extends StatelessWidget {
  const LinkText({Key key, this.text, this.onTap}) : super(key: key);

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Text(
        text,
        style: Theme.of(context).textTheme.subtitle1.primaryColor,
      ),
      onTap: onTap,
    );
  }
}
