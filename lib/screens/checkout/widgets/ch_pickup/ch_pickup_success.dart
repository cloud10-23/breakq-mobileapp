import 'package:breakq/screens/checkout/widgets/checkout_success_dialog.dart';
import 'package:flutter/material.dart';

class PickupCheckoutSuccessDialog extends StatefulWidget {
  @override
  _PickupCheckoutSuccessDialogState createState() =>
      _PickupCheckoutSuccessDialogState();
}

class _PickupCheckoutSuccessDialogState
    extends State<PickupCheckoutSuccessDialog> {
  final Duration durationBeforeClose = Duration(seconds: 3);

  @override
  void initState() {
    super.initState();
    // Future.delayed(durationBeforeClose).then((_) {
    //   if (mounted) Navigator.pop(context);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return CheckoutSuccessPlane(
      title: "Your order was recieved!",
      subtitle: "Thanks for shopping with BreakQ!",
    );
  }
}
