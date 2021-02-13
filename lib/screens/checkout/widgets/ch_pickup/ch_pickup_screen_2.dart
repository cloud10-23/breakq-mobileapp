import 'package:breakq/blocs/checkout/ch_bloc.dart';
import 'package:breakq/data/models/checkout_session.dart';
import 'package:breakq/generated/l10n.dart';
import 'package:breakq/screens/checkout/widgets/bottom_bar.dart';
import 'package:breakq/screens/checkout/widgets/ch_pickup/time_slot_picker.dart';
import 'package:breakq/screens/checkout/widgets/checkout_template.dart';
import 'package:breakq/screens/checkout/widgets/helper_widgets.dart';
import 'package:breakq/widgets/jumbotron.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:breakq/utils/text_style.dart';

class ChPickupConfirm extends StatefulWidget {
  @override
  _ChPickupConfirmState createState() => _ChPickupConfirmState();
}

class _ChPickupConfirmState extends State<ChPickupConfirm> {
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
            child: DisplaySelectedTimeSlot(session: session)));

        _listItems.add(SliverToBoxAdapter(
          child: CartProductsModule(session: session),
        ));

        _listItems.add(SliverToBoxAdapter(child: FooterModule()));

        _listItems.add(SliverToBoxAdapter(child: AdsModule(index: 0)));

        return CheckoutTemplate(
          slivers: _listItems,
          subTitle: 'Summary',
          bottomBar: ChBottomBarWithButton(
            session: session,
            buttonText: 'Confirm',
          ),
        );
      },
    );
  }
}
