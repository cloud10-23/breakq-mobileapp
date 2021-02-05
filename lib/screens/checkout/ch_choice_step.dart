import 'package:breakq/blocs/checkout/ch_bloc.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/data/models/checkout_session.dart';
import 'package:breakq/screens/checkout/widgets/ch_delivery/ch_delivery_address.dart';
import 'package:breakq/screens/checkout/widgets/ch_walkin/ch_walkin_show_qr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutChoiceSelector extends StatefulWidget {
  const CheckoutChoiceSelector({
    Key key,
  }) : super(key: key);

  @override
  _CheckoutChoiceSelectorState createState() => _CheckoutChoiceSelectorState();
}

class _CheckoutChoiceSelectorState extends State<CheckoutChoiceSelector> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckoutBloc, CheckoutState>(
      buildWhen: (previous, current) => current is SessionRefreshSuccessChState,
      builder: (BuildContext context, CheckoutState state) {
        if (state is SessionRefreshSuccessChState) {
          final CheckoutSession session = state.session;
          switch (session.currentStep.checkoutType) {
            case CheckoutType.walkIn:
              return ChWalkInShowQr();
              break;
            case CheckoutType.pickUp:
              break;
            case CheckoutType.delivery:
              return ChDeliverySelectAddress();
              break;
          }
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
