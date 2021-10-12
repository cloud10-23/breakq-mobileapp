import 'package:breakq/configs/constants.dart';
import 'package:flutter/material.dart';
import 'package:breakq/utils/text_style.dart';

class OfferTextGreen extends StatelessWidget {
  OfferTextGreen(this.offerPercent);
  final int offerPercent;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(kPaddingS * 1.5),
      decoration: BoxDecoration(
        color: kGreen,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Text(
        "$offerPercent% OFF",
        style: Theme.of(context).textTheme.caption.fs14.white.w800,
      ),
    );
  }
}

class OfferTextGreenAlt extends StatelessWidget {
  OfferTextGreenAlt(this.offerPercent);
  final int offerPercent;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(kPaddingS),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          border: Border.all(color: Colors.green.withOpacity(0.5), width: 1.0)),
      child: Text(
        "$offerPercent% OFF",
        style: Theme.of(context).textTheme.caption.fs8.green.w800,
      ),
    );
  }
}
