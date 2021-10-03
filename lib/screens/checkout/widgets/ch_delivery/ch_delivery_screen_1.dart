import 'package:breakq/blocs/checkout/ch_bloc.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/data/models/checkout_session.dart';
import 'package:breakq/generated/l10n.dart';
import 'package:breakq/screens/checkout/widgets/bottom_bar.dart';
import 'package:breakq/screens/checkout/widgets/ch_delivery/ch_delivery_address.dart';
import 'package:breakq/screens/checkout/widgets/checkout_template.dart';
import 'package:breakq/screens/checkout/widgets/helper_widgets.dart';
import 'package:breakq/widgets/jumbotron.dart';
import 'package:breakq/widgets/shimmer_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:breakq/utils/text_style.dart';

class ChDelivery extends StatefulWidget {
  @override
  _ChDeliveryState createState() => _ChDeliveryState();
}

class _ChDeliveryState extends State<ChDelivery> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckoutBloc, CheckoutState>(
      builder: (BuildContext context, CheckoutState state) {
        final CheckoutSession session =
            (state as SessionRefreshSuccessChState).session;

        if (session.cartProducts?.cartItems?.keys?.isEmpty ?? true) {
          return CheckoutTemplate(
            checkoutType: CheckoutType.delivery,
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

        _listItems.add(SliverToBoxAdapter(
            child: CheckoutTypeModule(
          index: 2,
        )));

        _listItems.add(SliverToBoxAdapter(
            child: StepShowModule(
          currentStep: 1,
          steps: [
            Step(
                isActive: true,
                title: Text("Checkout type",
                    style: Theme.of(context).textTheme.caption.fs8.w700),
                content: Container(),
                state: StepState.complete),
            Step(
                isActive: true,
                title: Text("Address",
                    style: Theme.of(context).textTheme.caption.fs8.w700),
                content: Container()),
            Step(
                title: Text("Time slot",
                    style: Theme.of(context).textTheme.caption.fs8.w700),
                content: Container()),
            Step(
                title: Text("Confirm",
                    style: Theme.of(context).textTheme.caption.fs8.w700),
                content: Container()),
          ],
        )));
        if (!session.isLoading)
          _listItems.add(SliverToBoxAdapter(
              child: DeliveryAddressModule(session: session)));
        else
          _listItems.add(SliverToBoxAdapter(
              child: Padding(
            padding: const EdgeInsets.all(kPaddingL),
            child: ShimmerBox(height: 400),
          )));

        _listItems.add(SliverToBoxAdapter(child: FooterModule()));

        _listItems.add(SliverToBoxAdapter(child: AdsModule(index: 0)));

        return CheckoutTemplate(
          checkoutType: CheckoutType.delivery,
          slivers: _listItems,
          showBackButton: false,
          subTitle: (!session.isLoading)
              ? 'Select delivery address'
              : 'Loading your address...',
          bottomBar: ChBottomBarWithButton(
            session: session,
            onTap: () {
              BlocProvider.of<CheckoutBloc>(context).add(NextPressedChEvent());
            },
          ),
        );
      },
    );
  }
}
