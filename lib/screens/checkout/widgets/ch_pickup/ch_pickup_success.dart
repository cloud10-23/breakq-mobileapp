import 'package:breakq/configs/routes.dart';
import 'package:breakq/data/models/my_order.dart';
import 'package:breakq/screens/checkout/widgets/checkout_success_dialog.dart';
import 'package:flutter/material.dart';

class PickupCheckoutSuccessDialog extends StatefulWidget {
  PickupCheckoutSuccessDialog({@required this.order});
  final Order order;
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
        Navigator.of(context, rootNavigator: true)
            .popAndPushNamed(Routes.order_detail, arguments: widget.order);
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
