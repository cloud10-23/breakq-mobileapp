import 'package:breakq/blocs/checkout/ch_bloc.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/data/models/checkout_session.dart';
import 'package:breakq/generated/l10n.dart';
import 'package:breakq/screens/checkout/widgets/payment.dart';
import 'package:breakq/widgets/full_screen_indicator.dart';
import 'package:breakq/widgets/price_details.dart';
import 'package:breakq/screens/checkout/widgets/bottom_bar.dart';
import 'package:breakq/screens/checkout/widgets/ch_pickup/time_slot_picker.dart';
import 'package:breakq/screens/checkout/widgets/checkout_template.dart';
import 'package:breakq/screens/checkout/widgets/helper_widgets.dart';
import 'package:breakq/widgets/jumbotron.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:breakq/utils/text_style.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class ChPickupConfirm extends StatefulWidget {
  @override
  _ChPickupConfirmState createState() => _ChPickupConfirmState();
}

class _ChPickupConfirmState extends State<ChPickupConfirm> {

  final _razorpay = Razorpay();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _razorpay.clear(); // Removes all listeners
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckoutBloc, CheckoutState>(
      builder: (BuildContext context, CheckoutState state) {
        final CheckoutSession session =
            (state as SessionRefreshSuccessChState).session;

        if (session.isPaying) {
          return FullScreenIndicator();
        } else if (session.cartProducts?.cartItems?.keys?.isEmpty ?? true) {
          return CheckoutTemplate(
            checkoutType: CheckoutType.pickUp,
            //TODO: Handle this case
            bottomBar: ChBottomBar(session: session),
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  alignment: AlignmentDirectional.center,
                  child: Jumbotron(
                    title: L10n.of(context).QSWarningProducts,
                    icon: Icons.report,
                  ),
                ),
              ),
            ],
          );
        }

        final List<Widget> _listItems = <Widget>[];

        _listItems.add(SliverToBoxAdapter(child: AdsModule()));

        _listItems.add(SliverToBoxAdapter(
            child: StepShowModule(
          currentStep: 2,
          steps: [
            Step(
                isActive: true,
                title: Text("Checkout type",
                    style: Theme.of(context).textTheme.caption.fs8.w700),
                content: Container(),
                state: StepState.complete),
            Step(
              isActive: true,
              title: Text("Time slot",
                  style: Theme.of(context).textTheme.caption.fs8.w700),
              content: Container(),
              state: StepState.complete,
            ),
            Step(
                isActive: true,
                title: Text("Confirm",
                    style: Theme.of(context).textTheme.caption.fs8.w700),
                content: Container()),
          ],
        )));

        _listItems.add(SliverToBoxAdapter(
            child: CheckoutTypeModule(
          index: 1,
          isReadOnly: true,
        )));

        _listItems.add(SliverToBoxAdapter(
          child: BranchModule(),
        ));

        final date = session.timetables[session.selectedDateIndex];
        _listItems.add(SliverToBoxAdapter(
            child: DisplaySelectedTimeSlot(
          time: date.timeSchedules[session.selectedTimeIndex].time,
          date: date.scheduleDate,
        )));

        _listItems.add(SliverToBoxAdapter(
          child: CartProductsModule(products: session.cartProducts.cartItems),
        ));

        _listItems.add(SliverToBoxAdapter(
          child: PriceDetails(price: session.cartProducts.cartValue),
        ));

        _listItems.add(SliverToBoxAdapter(child: FooterModule()));

        ScrollController controller = ScrollController();

        return CheckoutTemplate(
          checkoutType: CheckoutType.pickUp,
          controller: controller,
          slivers: _listItems,
          subTitle: 'Confirm & Pay',
          bottomBar: ChBottomBarWithButton(
            controller: controller,
            session: session,
            buttonText: 'Pay',
            onTap: () => showPayment(
                context,
                    () => openCheckout(session?.cartProducts?.cartValue?.finalAmount.toString())),
            // onTap: () => showPayment(
            //     context,
            //     () => BlocProvider.of<CheckoutBloc>(context)
            //         .add(NextPressedChEvent())),
          ),
        );
      },
    );
  }

  //open razorpay
  void openCheckout(String billAmount) async {
    // int num1 = int.parse((int.parse(billAmount.toString())).toStringAsFixed(0));
    // print("rounded price: $num1");
    var options = {
      'key': 'rzp_test_TqCucpSjoIG3bg',
      'amount': num.parse(billAmount.toString()) * 100,
      'name': 'BreakQ',
      'description': 'Placing new order',
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print("rzpSUCCESS: ${response.orderId}-${response.paymentId}-${response.signature}");
    BlocProvider.of<CheckoutBloc>(context)
        .add(NextPressedChEvent());
    // showPayment(
    //     context,
    //         () => BlocProvider.of<CheckoutBloc>(context)
    //         .add(NextPressedChEvent()));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("SUCCESS: ${response.paymentId}"),
      duration: const Duration(seconds: 1),
    ));
    // makePayment(response.paymentId.toString(), widget.id, rate.toString())
    //     .then((value) {
    //   if (value.status == true) {
    //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    //       content: Text("Razorpay payment successfully done"),
    //       duration: Duration(seconds: 1),
    //     ));
    //     Navigator.pop(context);
    //   }
    // });
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("rzpERROR: ${response.code} - ${response.message}");
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("ERROR: ${response.code} - ${response.message}"),
      duration: const Duration(seconds: 4),
    ));
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("rzpEXTERNALWALLET: ${response.walletName}");
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("EXTERNAL_WALLET: ${response.walletName}"),
      duration: const Duration(seconds: 1),
    ));
  }

}
