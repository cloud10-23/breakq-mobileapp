import 'package:breakq/widgets/checkout_success_dialog.dart';
import 'package:flutter/material.dart';
import 'package:breakq/generated/l10n.dart';

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
    return CheckoutSuccess(
      title: "Your order was recieved!",
      subtitle: "Thanks for shopping with BreakQ!",
      extraDetails: "Bill No: 1234566787\nTransaction No: 998776545432" +
          "\n\n\nA notification will be sent to you once your order is ready. " +
          "Pay at pickup.",
      btn1Label: "Need Help?",
      btn2Label: L10n.of(context).QSBtnClose,
      onPressed1: () {},
    );
  }
}
