import 'package:flutter/material.dart';

/// Appbar title with subtitle.
class TitleWithSubtitle extends StatelessWidget {
  const TitleWithSubtitle({
    Key key,
    @required this.title,
    @required this.subtitle,
  }) : super(key: key);

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(title),
        Text(
          subtitle,
          style: Theme.of(context).textTheme.bodyText2.copyWith(color: Colors.white70),
        ),
      ],
    );
  }
}
