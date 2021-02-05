import 'package:breakq/widgets/checkout_success_dialog.dart';
import 'package:flutter/material.dart';
import 'package:breakq/generated/l10n.dart';
import 'package:breakq/widgets/qs_success_dialog.dart';

class WalkinCheckoutSuccess extends StatefulWidget {
  @override
  _WalkinCheckoutSuccessState createState() => _WalkinCheckoutSuccessState();
}

class _WalkinCheckoutSuccessState extends State<WalkinCheckoutSuccess> {
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
      title: "Payment successfull!",
      subtitle: "Thanks for shopping with BreakQ!",
      extraDetails: "Bill No: 1234566787\nTransaction No: 998776545432",
      btn1Label: "Need Help?",
      btn2Label: L10n.of(context).QSBtnClose,
      onPressed1: () {},
    );
  }
}
