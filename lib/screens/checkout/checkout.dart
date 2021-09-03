import 'package:breakq/blocs/checkout/ch_bloc.dart';
import 'package:breakq/configs/app_globals.dart';
import 'package:breakq/configs/routes.dart';
import 'package:breakq/data/models/checkout_session.dart';
import 'package:breakq/main.dart';
import 'package:breakq/screens/checkout/widgets/ch_delivery/ch_delivery_success.dart';
import 'package:breakq/screens/checkout/widgets/ch_pickup/ch_pickup_success.dart';
import 'package:breakq/screens/checkout/widgets/ch_walkin/ch_walkin_success.dart';
import 'package:breakq/utils/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/widgets/full_screen_indicator.dart';
import 'package:breakq/widgets/portrait_mode_mixin.dart';

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

  @override
  void dispose() {
    super.dispose();
    getIt.get<AppGlobals>().globalKeyCheckoutNavigator = null;
  }

  @override
  void initState() {
    super.initState();
    getIt.get<AppGlobals>().globalKeyCheckoutNavigator =
        GlobalKey(debugLabel: 'checkout_navigator');
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
      await UI.confirmationDialogBox(context,
          title: "Warning !",
          cancelButtonText: "No",
          okButtonText: "Yes",
          message: "Are you sure you want to cancel checkout?",
          onConfirmation: () {
        Navigator.pop(context);
      });
      return false;
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
              return WalkinCheckoutSuccess(order: session.order);
              break;
            case CheckoutType.pickUp:
              return PickupCheckoutSuccessDialog(order: session.order);
              break;
            case CheckoutType.delivery:
              return DeliveryCheckoutSuccessDialog(order: session.order);
              break;
          }
        }

        return Scaffold(
          body: WillPopScope(
            onWillPop: () => _onBackPressed(context),
            child: CheckoutNavigator(
              navigatorKey: getIt.get<AppGlobals>().globalKeyCheckoutNavigator,
              initialRoute: <String>(CheckoutType type) {
                switch (type) {
                  case CheckoutType.walkIn:
                    return CheckoutNavigatorRoutes.walkin_1;
                    break;
                  case CheckoutType.pickUp:
                    return CheckoutNavigatorRoutes.pickup_1;
                    break;
                  case CheckoutType.delivery:
                    return CheckoutNavigatorRoutes.delivery_1;
                    break;
                }
              }(session.currentStep.checkoutType),
            ),
          ),
        );
      },
    );
  }
}
