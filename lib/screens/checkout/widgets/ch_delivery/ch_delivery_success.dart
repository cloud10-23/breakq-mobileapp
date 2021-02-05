import 'package:breakq/widgets/checkout_success_dialog.dart';
import 'package:flutter/material.dart';

class DeliveryCheckoutSuccessDialog extends StatefulWidget {
  @override
  _DeliveryCheckoutSuccessDialogState createState() =>
      _DeliveryCheckoutSuccessDialogState();
}

class _DeliveryCheckoutSuccessDialogState
    extends State<DeliveryCheckoutSuccessDialog> {
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
    return CheckoutSuccess(
      title: "Your order will be delivered shortly!",
      subtitle: "Thanks for shopping with BreakQ!",
      extraDetails: "Bill No: 1234566787\nOrder No: 998776545432",
      btn1Label: "Need Help?",
      btn2Label: "Track Order",
      onPressed1: () {},
    );
  }
}
