import 'package:breakq/configs/constants.dart';
import 'package:breakq/configs/routes.dart';
import 'package:breakq/widgets/bold_title.dart';
import 'package:breakq/widgets/card_template.dart';
import 'package:flutter/material.dart';
import 'package:breakq/utils/text_style.dart';

class OrderItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: kPaddingM),
      child: InkWell(
        onTap: () => Navigator.of(context).pushNamed(Routes.order_detail),
        child: CartHeading(
          isCaps: false,
          title: 'Bill Generated On:   20 Feb, 2021',
          children: [
            Row(
              children: [
                Image(
                  image: AssetImage(AssetImages.shop),
                  height: 70,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(kPaddingM),
                      child: BoldTitle(
                        title: 'Vishal Super Mart,  RT-Nagar Branch',
                        padding: EdgeInsets.symmetric(horizontal: kPaddingM),
                        color: Colors.black,
                        fw: FontWeight.w600,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: kPaddingL, bottom: kPaddingM),
                      child: Text(
                        'RT-Nagar, Church Street, Chennai - 430021',
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            .bold
                            .fs10
                            .copyWith(color: Theme.of(context).disabledColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            // CheckoutTypeSmall(index: 0),
            SizedBox(height: 5),
            // Container(
            //   height: 0.5,
            //   color: Colors.black12,
            // ),
            Padding(
              padding: const EdgeInsets.all(kPaddingS),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BoldTitle(
                    title: 'Bill No: ',
                    padding: EdgeInsets.symmetric(horizontal: kPaddingS),
                    color: Colors.black45,
                    fw: FontWeight.w800,
                  ),
                  BoldTitle(
                    title: '1234567890',
                    padding: EdgeInsets.symmetric(horizontal: kPaddingS),
                    color: Colors.black54,
                    fw: FontWeight.w500,
                    isNum: true,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(kPaddingS),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BoldTitle(
                    title: 'Checkout Type: ',
                    padding: EdgeInsets.symmetric(horizontal: kPaddingS),
                    color: Colors.black45,
                    fw: FontWeight.w800,
                  ),
                  BoldTitle(
                    title: 'Walkin',
                    padding: EdgeInsets.symmetric(horizontal: kPaddingS),
                    color: Colors.black54,
                    fw: FontWeight.w500,
                    isNum: true,
                  ),
                ],
              ),
            ),
            Container(
              height: 0.8,
              color: Colors.black12,
            ),
            Padding(
              padding: const EdgeInsets.all(kPaddingS),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BoldTitle(
                    title: 'Amount Paid:',
                    fw: FontWeight.w800,
                  ),
                  BoldTitle(
                    title: '₹ 100.00',
                    fw: FontWeight.w800,
                    isNum: true,
                  ),
                ],
              ),
            ),
            BoldTitle(
              title: 'You have saved ₹ ' + "10.00" + ' on this bill',
              fw: FontWeight.w800,
              color: kGreen,
            ),
            SizedBox(height: 5),
            Container(
              constraints: BoxConstraints.tight(Size.fromHeight(35)),
              child: RaisedButton(
                elevation: 0.0,
                padding: EdgeInsets.zero,
                child: Text('View Details'),
                onPressed: () =>
                    Navigator.of(context).pushNamed(Routes.order_detail),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
