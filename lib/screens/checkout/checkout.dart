import 'package:breakq/blocs/cart/cart_bloc.dart';
import 'package:breakq/blocs/checkout/ch_bloc.dart';
import 'package:breakq/configs/app_globals.dart';
import 'package:breakq/configs/routes.dart';
import 'package:breakq/data/models/checkout_session.dart';
import 'package:breakq/main.dart';
import 'package:breakq/screens/checkout/widgets/ch_delivery/ch_delivery_success.dart';
import 'package:breakq/screens/checkout/widgets/ch_pickup/ch_pickup_success.dart';
import 'package:breakq/screens/checkout/widgets/ch_walkin/ch_walkin_success.dart';
import 'package:breakq/widgets/bold_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/generated/l10n.dart';
import 'package:breakq/widgets/full_screen_indicator.dart';
import 'package:breakq/widgets/portrait_mode_mixin.dart';
import 'package:breakq/utils/text_style.dart';
import 'package:breakq/widgets/theme_button.dart';

class CheckoutScreen extends StatefulWidget {
  static const id = 'Checkout';
  const CheckoutScreen({
    Key key,
  }) : super(key: key);

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen>
    with PortraitStatefulModeMixin<CheckoutScreen> {
  // ChCurrentStep _currentStep;

  CheckoutSession session;

  String _title = 'Checkout';

  @override
  void dispose() {
    super.dispose();
    getIt.get<AppGlobals>().globalKeyCheckoutNavigator = null;
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CheckoutBloc>(context).add(LoadCartChEvent());
    getIt.get<AppGlobals>().globalKeyCheckoutNavigator =
        GlobalKey(debugLabel: 'checkout_navigator');
  }

  void _nextStep() {
    BlocProvider.of<CheckoutBloc>(context).add(NextPressedChEvent());
  }

  void _previousStep() {
    BlocProvider.of<CheckoutBloc>(context).add(BackPressedChEvent());
    // if (_currentStep.step >= 1) {
    //   setState(() {
    //     _subtitle = 'Choose a checkout type';
    //     _currentStep.step--;
    //   });
    // }
  }

  Future<bool> _onBackPressed(BuildContext context) async {
    if (session.currentStep.step <= 0) {
      Navigator.pop(context);
      return true;
    }
    _previousStep();
    return false;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocBuilder<CheckoutBloc, CheckoutState>(
      builder: (BuildContext context, CheckoutState state) {
        if (state is! SessionRefreshSuccessChState) {
          /// Show the full screen indicator until we return here.
          return FullScreenIndicator(
            color: Theme.of(context).cardColor,
            backgroundColor: Theme.of(context).cardColor,
          );
        }

        session = (state as SessionRefreshSuccessChState).session;

        if (session.isCompleted) {
          switch (session.currentStep.checkoutType) {
            case CheckoutType.walkIn:
              return WalkinCheckoutSuccess();
              break;
            case CheckoutType.pickUp:
              return PickupCheckoutSuccessDialog();
              break;
            case CheckoutType.delivery:
              return DeliveryCheckoutSuccessDialog();
              break;
          }
        }

        return WillPopScope(
          onWillPop: () => _onBackPressed(context),
          child: CheckoutNavigator(
            navigatorKey: getIt.get<AppGlobals>().globalKeyCheckoutNavigator,
          ),
        );
      },
    );
  }
}
