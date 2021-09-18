import 'package:flutter/material.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/utils/text_style.dart';

/// Widget for showcasing hero unit style content.
class NoProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 100),
        Padding(
          padding: const EdgeInsets.only(top: kPaddingL),
          child: Image.asset(
            AssetImages.errors[3],
            height: 200,
            fit: BoxFit.fitHeight,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
              vertical: kPaddingL * 2, horizontal: kPaddingM),
          child: Text(
            "Sorry! Didn't find any products matching your search criteria",
            style: Theme.of(context)
                .textTheme
                .subtitle1
                .bold
                .fs18
                .copyWith(color: Theme.of(context).disabledColor),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
