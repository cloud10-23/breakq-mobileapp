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

class ChDeliveryConfirm extends StatefulWidget {
  @override
  _ChDeliveryConfirmState createState() => _ChDeliveryConfirmState();
}

class _ChDeliveryConfirmState extends State<ChDeliveryConfirm> {
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
            checkoutType: CheckoutType.delivery,
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
                title: Text("Address",
                    style: Theme.of(context).textTheme.caption.fs8.w700),
                content: Container(),
                state: StepState.complete),
            Step(
                isActive: true,
                title: Text("Time slot",
                    style: Theme.of(context).textTheme.caption.fs8.w700),
                content: Container(),
                state: StepState.complete),
            Step(
                isActive: true,
                title: Text("Confirm",
                    style: Theme.of(context).textTheme.caption.fs8.w700),
                content: Container()),
          ],
        )));

        _listItems.add(SliverToBoxAdapter(
            child: CheckoutTypeModule(
          index: 2,
          isReadOnly: true,
        )));

        _listItems.add(SliverToBoxAdapter(
          child: BranchModule(),
        ));
        // _listItems.add(SliverToBoxAdapter(
        //     child: DisplaySelectedAddress(
        //         address: session.address[session.selectedAddress ?? 0])));

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
          checkoutType: CheckoutType.delivery,
          slivers: _listItems,
          controller: controller,
          subTitle: 'Confirm and Pay',
          bottomBar: ChBottomBarWithButton(
            session: session,
            controller: controller,
            buttonText: 'Pay',
            onTap: () => showPayment(
                context,
                () => BlocProvider.of<CheckoutBloc>(context)
                    .add(NextPressedChEvent())),
          ),
        );
      },
    );
  }
}
