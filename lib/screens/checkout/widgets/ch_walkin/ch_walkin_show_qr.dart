import 'dart:convert';

import 'package:breakq/blocs/checkout/ch_bloc.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/data/models/checkout_session.dart';
import 'package:breakq/generated/l10n.dart';
import 'package:breakq/screens/checkout/widgets/bottom_bar.dart';
import 'package:breakq/screens/checkout/widgets/checkout_template.dart';
import 'package:breakq/screens/checkout/widgets/helper_widgets.dart';
import 'package:breakq/screens/checkout/widgets/payment.dart';
import 'package:breakq/widgets/jumbotron.dart';
import 'package:breakq/widgets/price_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../../../blocs/checkout_provider.dart';

class ChWalkInShowQr extends StatefulWidget {
  @override
  _ChWalkInShowQrState createState() => _ChWalkInShowQrState();
}

class _ChWalkInShowQrState extends State<ChWalkInShowQr> {

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

        if (session.cartProducts?.cartItems?.keys?.isEmpty ?? true) {
          return CheckoutTemplate(
            //TODO: Handle this case
            bottomBar: ChBottomBar(session: session),
            showBackButton: false,
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

        _listItems.add(SliverToBoxAdapter(child: SizedBox(height: kPaddingS)));

        _listItems.add(SliverToBoxAdapter(child: AdsModule()));

        _listItems.add(SliverToBoxAdapter(
            child: CheckoutTypeModule(
          index: 0,
        )));

        _listItems.add(
            SliverToBoxAdapter(child: ShowQRModule(billNo: session.billNo)));

        _listItems.add(SliverToBoxAdapter(
          child: BranchModule(),
        ));

        _listItems.add(SliverToBoxAdapter(
          child: CartProductsModule(products: session.cartProducts.cartItems),
        ));

        _listItems.add(SliverToBoxAdapter(
          child: PriceDetails(price: session.cartProducts.cartValue),
        ));

        _listItems.add(SliverToBoxAdapter(child: FooterModule()));

        final controller = ScrollController();

        return CheckoutTemplate(
          slivers: _listItems,
          controller: controller,
          showBackButton: false,
          subTitle: 'Proceed To Counter & Pay',
          bottomBar: ChBottomBarWithButton(
            session: session,
            onTap: () => showPayment(
                context,
                    () => openCheckout(session?.cartProducts?.cartValue?.finalAmount.toString()
                    ),
            ),
            // onTap: () => showPayment(
            //   context,
            //   () => BlocProvider.of<CheckoutBloc>(context)
            //       .add(NextPressedChEvent()),
            //   allowCash: false,
            // ),
            buttonText: 'Pay',
            controller: controller,
          ),
        );
      },
    );
  }

  //open razorpay
  void openCheckout(String billAmount) async {
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
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("SUCCESS: ${response.paymentId}"),
      duration: const Duration(seconds: 1),
    ));
    Provider.of<CheckoutProvider>(context, listen: false).storePaymentId(response.paymentId);
    BlocProvider.of<CheckoutBloc>(context)
        .add(NextPressedChEvent());
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("rzpERROR: ${response.code} - ${response.message}");
    final jsonResponse = jsonDecode(response.message);
    // Extract the description value
    final description = jsonResponse['error']['description'];
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(description),
      duration: const Duration(seconds: 4),
    ));
    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //   content: Text("ERROR: ${response.code} - ${response.message}"),
    //   duration: const Duration(seconds: 4),
    // ));
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("rzp-external wallet");
    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //   content: Text("EXTERNAL_WALLET: ${response.walletName}"),
    //   duration: const Duration(seconds: 1),
    // ));
  }
}
