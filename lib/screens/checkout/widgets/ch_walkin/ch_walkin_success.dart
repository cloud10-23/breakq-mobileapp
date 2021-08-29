import 'package:breakq/configs/routes.dart';
import 'package:breakq/screens/checkout/widgets/checkout_success_dialog.dart';
import 'package:flutter/material.dart';

class WalkinCheckoutSuccess extends StatefulWidget {
  @override
  _WalkinCheckoutSuccessState createState() => _WalkinCheckoutSuccessState();
}

class _WalkinCheckoutSuccessState extends State<WalkinCheckoutSuccess> {
  final Duration durationBeforeClose = Duration(seconds: 3);

  @override
  void initState() {
    super.initState();
    Future.delayed(durationBeforeClose).then((_) {
      if (mounted)
        Navigator.of(context, rootNavigator: true)
            .popAndPushNamed(Routes.order_invoice);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CheckoutSuccessPlane(
      title: "Payment successfull!",
      subtitle: "Thanks for shopping with BreakQ!",
    );
  }
}
