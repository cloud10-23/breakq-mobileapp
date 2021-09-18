import 'package:breakq/configs/constants.dart';
import 'package:breakq/configs/routes.dart';
import 'package:breakq/data/models/my_order.dart';
import 'package:breakq/widgets/bold_title.dart';
import 'package:breakq/widgets/card_template.dart';
import 'package:flutter/material.dart';
import 'package:breakq/utils/text_style.dart';

class OrderItem extends StatelessWidget {
  OrderItem({@required this.order});
  final Order order;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: kPaddingM),
      child: InkWell(
        onTap: () => Navigator.of(context)
            .pushNamed(Routes.order_detail, arguments: order),
        child: CartHeading(
          isCaps: false,
          title: 'Bill Generated On:   ${order.billDate}',
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
                        title: 'Branch - ${order.storeId}',
                        padding: EdgeInsets.symmetric(horizontal: kPaddingM),
                        color: Colors.black,
                        fw: FontWeight.w600,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: kPaddingL, bottom: kPaddingM),
                      child: Text(
                        '<Address>, Chennai - 430021',
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
                Spacer(flex: 5),
                Image(
                  image: AssetImage(AssetImages.paid_image),
                  height: 70,
                ),
                Spacer(),
              ],
            ),
            // CheckoutTypeSmall(index: 0),
            SizedBox(height: kPaddingM),
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
                    color: kBlack,
                    fw: FontWeight.w500,
                  ),
                  BoldTitle(
                    title: '${order.billNo}',
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
                    color: kBlack,
                    fw: FontWeight.w500,
                  ),
                  BoldTitle(
                    title:
                        CheckoutTypes.fromAPItypeToString(order.checkoutType),
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
                    title: 'Payment Mode: ',
                    padding: EdgeInsets.symmetric(horizontal: kPaddingS),
                    color: kBlack,
                    fw: FontWeight.w500,
                  ),
                  BoldTitle(
                    title: '${order.paymentMode}',
                    padding: EdgeInsets.symmetric(horizontal: kPaddingS),
                    color: Colors.black54,
                    fw: FontWeight.w700,
                    isNum: true,
                  ),
                ],
              ),
            ),
            SizedBox(height: kPaddingL),
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
                    title: '₹ ${order.price?.finalAmount ?? 0.00}',
                    fw: FontWeight.w800,
                    isNum: true,
                  ),
                ],
              ),
            ),
            BoldTitle(
              title:
                  'You have saved ₹ ${order.price?.savings ?? 0.00} on this bill',
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
                onPressed: () => Navigator.of(context)
                    .pushNamed(Routes.order_detail, arguments: order),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
