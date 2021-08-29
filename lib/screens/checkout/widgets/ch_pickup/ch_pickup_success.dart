import 'package:breakq/configs/constants.dart';
import 'package:breakq/configs/routes.dart';
import 'package:breakq/screens/checkout/widgets/checkout_success_dialog.dart';
import 'package:flutter/material.dart';

class PickupCheckoutSuccessDialog extends StatefulWidget {
  @override
  _PickupCheckoutSuccessDialogState createState() =>
      _PickupCheckoutSuccessDialogState();
}

class _PickupCheckoutSuccessDialogState
    extends State<PickupCheckoutSuccessDialog> {
  final Duration durationBeforeClose = Duration(seconds: 2);

  @override
  void initState() {
    super.initState();
    Future.delayed(durationBeforeClose).then((_) {
      if (mounted) {
        Navigator.of(context, rootNavigator: true).popAndPushNamed(
            Routes.order_detail,
            arguments: CheckoutType.pickUp);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CheckoutSuccessPlane(
      subtitle: "Your order was recieved!",
      title: "Thanks for shopping with BreakQ!",
    );
  }
}
