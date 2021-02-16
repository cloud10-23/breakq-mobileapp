import 'package:breakq/screens/checkout/widgets/checkout_success_dialog.dart';
import 'package:flutter/material.dart';

class DeliveryCheckoutSuccessDialog extends StatefulWidget {
  @override
  _DeliveryCheckoutSuccessDialogState createState() =>
      _DeliveryCheckoutSuccessDialogState();
}

class _DeliveryCheckoutSuccessDialogState
    extends State<DeliveryCheckoutSuccessDialog> {
  final Duration durationBeforeClose = Duration(seconds: 2);

  @override
  void initState() {
    super.initState();
    Future.delayed(durationBeforeClose).then((_) {
      if (mounted) Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CheckoutSuccessPlane(
      title: "Your order will be delivered shortly!",
      subtitle: "Thanks for shopping with BreakQ!",
    );
  }
}
