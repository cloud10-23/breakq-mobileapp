import 'package:breakq/configs/constants.dart';
import 'package:breakq/data/models/price_model.dart';
import 'package:breakq/widgets/bold_title.dart';
import 'package:breakq/widgets/card_template.dart';
import 'package:flutter/material.dart';

class PriceDetails extends StatelessWidget {
  PriceDetails({@required this.price});

  final Price price;
  @override
  Widget build(BuildContext context) {
    return CartHeading(
      title: 'PRICE DETAILS',
      children: cartDetails(context),
    );
  }

  List<Widget> cartDetails(BuildContext context) {
    return [
      Padding(
        padding: const EdgeInsets.all(kPaddingM),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BoldTitle(
              title: 'Price: ',
              padding: EdgeInsets.symmetric(horizontal: kPaddingM),
              color: Colors.black,
              fw: FontWeight.w600,
            ),
            BoldTitle(
              title: '₹ ' + (price?.totalAmount?.toStringAsFixed(2) ?? "00.00"),
              padding: EdgeInsets.symmetric(horizontal: kPaddingM),
              color: Colors.black87,
              fw: FontWeight.w500,
              isNum: true,
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(kPaddingM),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BoldTitle(
              title: 'Discount: ',
              padding: EdgeInsets.symmetric(horizontal: kPaddingM),
              color: kGreen,
              fw: FontWeight.w600,
            ),
            BoldTitle(
              title: '- ₹ ' + (price?.discount ?? 0)?.toStringAsFixed(2) ??
                  "00.00",
              padding: EdgeInsets.symmetric(horizontal: kPaddingM),
              color: Colors.green[800],
              isNum: true,
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(kPaddingM),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BoldTitle(
              title: 'Extra offer: ',
              padding: EdgeInsets.symmetric(horizontal: kPaddingM),
              color: kGreen,
              fw: FontWeight.w600,
            ),
            BoldTitle(
              title: '- ₹ ' + (price?.extraOffer ?? 0).toStringAsFixed(2),
              padding: EdgeInsets.symmetric(horizontal: kPaddingM),
              color: kGreen,
              isNum: true,
            ),
          ],
        ),
      ),
      if ((price?.delivery ?? 0) > 0)
        Padding(
          padding: const EdgeInsets.all(kPaddingM),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BoldTitle(
                title: 'Delivery Charges: ',
                padding: EdgeInsets.symmetric(horizontal: kPaddingM),
                color: Colors.black54,
                fw: FontWeight.w600,
              ),
              BoldTitle(
                title: '₹ ' + (price.delivery.toStringAsFixed(2)),
                padding: EdgeInsets.symmetric(horizontal: kPaddingM),
                color: Colors.black54,
                fw: FontWeight.w500,
                isNum: true,
              ),
            ],
          ),
        ),
      Container(
        height: 0.5,
        color: Colors.black12,
      ),
      Padding(
        padding: const EdgeInsets.all(kPaddingM),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BoldTitle(
              title: 'Total Amount:',
              fw: FontWeight.w800,
            ),
            CustomTitle(
              title: '₹ ' + (price?.finalAmount ?? 0).toStringAsFixed(2),
              fw: FontWeight.w700,
              isNum: true,
            ),
          ],
        ),
      ),
      Container(
        height: 0.5,
        color: Colors.black12,
      ),
      Padding(
        padding: const EdgeInsets.all(kPaddingS),
        child: BoldTitle(
          title: 'You have saved ₹ ' +
              ((price?.savings ?? 0)?.toStringAsFixed(2) ?? "00.00") +
              ' on this order',
          fw: FontWeight.w800,
          color: kGreen,
        ),
      ),
    ];
  }
}
