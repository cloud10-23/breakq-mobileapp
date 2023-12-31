import 'package:flutter/material.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/utils/text_style.dart';

/// Listing title.
///
/// Used alongside [ListItem].
class ListTitle extends StatelessWidget {
  const ListTitle({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: kPaddingM * 2, bottom: kPaddingS),
      child: Row(
        children: <Widget>[
          Text(
            title.toUpperCase(),
            style: Theme.of(context)
                .textTheme
                .caption
                .w700
                .copyWith(color: Theme.of(context).hintColor),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
