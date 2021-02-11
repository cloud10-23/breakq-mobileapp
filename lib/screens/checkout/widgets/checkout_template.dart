import 'package:breakq/blocs/cart/cart_bloc.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:breakq/utils/text_style.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutTemplate extends StatefulWidget {
  CheckoutTemplate({@required this.slivers});

  final List<Widget> slivers;

  @override
  _CheckoutTemplateState createState() => _CheckoutTemplateState();
}

class _CheckoutTemplateState extends State<CheckoutTemplate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
              SliverAppBar(
                pinned: true,
                backgroundColor: kWhite,
                expandedHeight: 150,
                flexibleSpace: FlexibleSpaceBar(
                  background: Row(
                    children: [
                      Spacer(),
                      Image(
                          image: AssetImage(AssetImages.checkoutIllustration)),
                    ],
                  ),
                  title: Column(
                    children: [
                      Spacer(flex: 3),
                      Text(
                        "Checkout",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.subtitle2.w800.black,
                        maxLines: 1,
                      ),
                      Spacer(),
                    ],
                  ),
                ),
                leading: Container(),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.close),
                    tooltip: L10n.of(context).commonTooltipInfo,
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pop();
                    },
                  ),
                ],
              ),
            ] +
            widget.slivers,
      ),
      bottomNavigationBar: _bottomBar(),
    );
  }

  Widget _bottomBar() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border(
          top: BorderSide(
            width: 2,
            color: Theme.of(context).dividerColor,
          ),
        ),
      ),
      padding: const EdgeInsets.all(kPaddingM),
      child: SafeArea(
        top: false,
        child: BlocBuilder<CartBloc, CartState>(builder: (context, state) {
          if (state is! CartLoaded) {
            return Container();
          }
          return Row(
            children: <Widget>[
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5.0),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Amount to Pay (6 items)',
                        style: Theme.of(context).textTheme.bodyText1.fs16.w800,
                      ),
                    ],
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    'View price details',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .fs10
                        .w800
                        .copyWith(color: kHyperLinkColor),
                  ),
                  SizedBox(height: 5.0),
                ],
              ),
              Spacer(),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(height: 5.0),
                  Text(
                    (state is CartLoaded)
                        ? '₹ ' +
                            (state.cart?.cartValue?.toStringAsFixed(2) ??
                                "00.00")
                        : '₹ 00.00',
                    style: Theme.of(context).textTheme.headline6.w700,
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    'You have saved 500 on this order',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .fs10
                        .w800
                        .copyWith(color: kGreen),
                  ),
                  SizedBox(height: 5.0),
                ],
              ),
              // ThemeButton(
              //   text: ((session?.currentStep?.step ?? 0) >=
              //           totalSteps[session?.currentStep?.checkoutType ?? 0])
              //       ? "Pay"
              //       : "Next",
              //   onPressed: _nextStep,
              //   disableTouchWhenLoading: true,
              //   showLoading: session.isLoading,
              // ),
            ],
          );
        }),
      ),
    );
  }
}
