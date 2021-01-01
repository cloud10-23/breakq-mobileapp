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
              Flexible(
                flex: 2,
                child: Image(
                    image: AssetImage((index == 0)
                        ? AssetImages.quickShopping
                        : AssetImages.setBudget)),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  (index == 0) ? 'Quick Shopping' : 'Set Budget',
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
