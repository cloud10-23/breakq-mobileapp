import 'package:breakq/configs/constants.dart';
import 'package:breakq/configs/routes.dart';
import 'package:breakq/utils/ui.dart';
import 'package:breakq/widgets/card_template.dart';
import 'package:flutter/material.dart';
import 'package:breakq/utils/text_style.dart';
import 'package:flutter_icons/flutter_icons.dart';

void showPayment(BuildContext context, VoidCallback onTap, {allowCash = true}) {
  showModalBottomSheet(
    context: context,
    useRootNavigator: true,
    isScrollControlled: true,
    backgroundColor: kWhite,
    builder: (context) => Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CartHeading(
          title: 'Select a payment method',
          children: [
            SizedBox(height: kPaddingL * 2),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.only(bottom: kPaddingL),
                child: Row(
                  children: List.generate(
                    4,
                    (index) => PaymentModeCard(index, () {
                      if (!allowCash && index == 0) {
                        /// Cash mode, just say to go to the counter
                        Navigator.pop(context);
                        UI.showMessage(context,
                            title: "Cash Payment",
                            buttonText: "OK",
                            message: "Please pay cash at the counter");
                      } else {
                        onTap();
                        Navigator.pop(context);
                      }
                    }),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
    ),
    clipBehavior: Clip.antiAlias,
  );
}

class PaymentModeCard extends StatelessWidget {
  PaymentModeCard(this.index, this.onTap);
  final int index;
  final VoidCallback onTap;
  final Map<int, Map<String, dynamic>> mode = {
    0: {
      "title": "Cash",
      "icon": FontAwesome5Solid.money_bill,
      // "onTap": (amnt) => CashPaymentWidget(totalAmnt: amnt),
    },
    1: {
      "title": "Card",
      "icon": Ionicons.ios_card,
      // "onTap": (amnt) => CardPaymentWidget(totalAmnt: amnt),
    },
    2: {
      "title": "UPI",
      "icon": Ionicons.ios_fastforward,
      // "onTap": (amnt) => UPIPaymentWidget(totalAmnt: amnt),
    },
    3: {
      "title": "Coupon",
      "icon": MaterialCommunityIcons.ticket_percent,
      // "onTap": (amnt) => CouponPaymentWidget(totalAmnt: amnt),
    },
  };
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 80,
          width: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                mode[index]['icon'],
                size: 24.0,
              ),
              Text(
                mode[index]['title'],
                style: Theme.of(context).textTheme.bodyText1.w800.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
