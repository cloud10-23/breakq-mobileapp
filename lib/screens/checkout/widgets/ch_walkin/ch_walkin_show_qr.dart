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

class ChWalkInShowQr extends StatefulWidget {
  @override
  _ChWalkInShowQrState createState() => _ChWalkInShowQrState();
}

class _ChWalkInShowQrState extends State<ChWalkInShowQr> {
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
              () => BlocProvider.of<CheckoutBloc>(context)
                  .add(NextPressedChEvent()),
              allowCash: false,
            ),
            buttonText: 'Pay',
            controller: controller,
          ),
        );
      },
    );
  }
}
