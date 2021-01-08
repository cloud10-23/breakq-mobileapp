import 'package:breakq/configs/constants.dart';
import 'package:flutter/material.dart';
import 'package:breakq/utils/text_style.dart';

class QuickLinkButton extends StatelessWidget {
  QuickLinkButton({this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120 + kPaddingS,
      margin: const EdgeInsets.only(bottom: 1), // for card shadow
      padding: const EdgeInsets.only(right: kPaddingS),
      child: Card(
        color: kPrimaryColor,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kPaddingS),
          child: Row(
            children: [
              Spacer(),
              Flexible(
                flex: 4,
                child: Image(image: AssetImage(quickLinks[index]['image'])),
              ),
              Spacer(),
              Expanded(
                flex: 6,
                child: Text(
                  quickLinks[index]['name'],
                  style: Theme.of(context).textTheme.caption.bold.fs10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
