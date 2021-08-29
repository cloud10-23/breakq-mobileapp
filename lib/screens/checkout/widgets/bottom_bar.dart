import 'package:breakq/blocs/checkout/ch_bloc.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/data/models/checkout_session.dart';
import 'package:breakq/widgets/price_details.dart';
import 'package:flutter/material.dart';
import 'package:breakq/utils/text_style.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChBottomBar extends StatefulWidget {
  ChBottomBar({@required this.session});

  final CheckoutSession session;
  @override
  _ChBottomBarState createState() => _ChBottomBarState();
}

class _ChBottomBarState extends State<ChBottomBar> {
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return InkWell(
        onTap: () => showPriceDetails(),
        child: Container(
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
            child: Row(
              children: <Widget>[
                Spacer(),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 5.0),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          ((widget.session?.cartProducts?.noOfProducts ?? 0) ==
                                  1)
                              ? 'Pay (${widget.session?.cartProducts?.noOfProducts ?? 0} item)'
                              : 'Pay (${widget.session?.cartProducts?.noOfProducts ?? 0} items)',
                          style:
                              Theme.of(context).textTheme.bodyText1.fs16.w800,
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
                Spacer(flex: 10),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(height: 5.0),
                    Text(
                      '₹ ' +
                          (widget.session?.cartProducts?.cartValue?.totalAmnt
                                  ?.toStringAsFixed(2) ??
                              "00.00"),
                      style: Theme.of(context).textTheme.headline6.w700.number,
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      'You have saved ₹ ${widget.session?.cartProducts?.cartValue?.savings ?? 0} on this order',
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
                Spacer(),
              ],
            ),
          ),
        ),
      );
    });
  }

  Future<void> showPriceDetails() {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      builder: (context) => Container(
        // height: MediaQuery.of(context).size.height * 0.9,
        child: PriceDetails(
          price: widget.session.cartProducts.cartValue,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
      ),
      clipBehavior: Clip.antiAlias,
      isDismissible: true,
    );
  }
}

class ChBottomBarWithButton extends StatefulWidget {
  ChBottomBarWithButton(
      {@required this.session,
      this.onTap,
      this.buttonText = 'Next',
      this.controller});

  final CheckoutSession session;
  final VoidCallback onTap;
  final String buttonText;
  final ScrollController controller;
  @override
  _ChBottomBarWithButtonState createState() => _ChBottomBarWithButtonState();
}

class _ChBottomBarWithButtonState extends State<ChBottomBarWithButton> {
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      List<Widget> addDetails = [];
      if (widget.controller != null)
        addDetails = [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 5.0),
              Text(
                ((widget.session?.cartProducts?.noOfProducts ?? 0) == 1)
                    ? 'Pay (${widget.session?.cartProducts?.noOfProducts ?? 0} item)'
                    : 'Pay (${widget.session?.cartProducts?.noOfProducts ?? 0} items)',
                style: Theme.of(context).textTheme.bodyText1.fs16.w800,
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
            children: [
              Text(
                '₹ ' +
                    (widget.session?.cartProducts?.cartValue?.totalAmnt
                            ?.toStringAsFixed(2) ??
                        "00.00"),
                style: Theme.of(context).textTheme.headline6.w700.number,
              ),
              SizedBox(height: 15),
            ],
          ),
        ];

      Widget child = Container(
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
          child: Row(
            children: addDetails +
                <Widget>[
                  Spacer(flex: 9),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      RaisedButton(
                        onPressed: widget.onTap ??
                            () {
                              BlocProvider.of<CheckoutBloc>(context)
                                  .add(NextPressedChEvent());
                            },
                        child: Text(widget.buttonText),
                      )
                    ],
                  ),
                ],
          ),
        ),
      );
      if (widget.controller != null)
        return InkWell(
          onTap: () => widget.controller.animateTo(
              widget.controller.position.maxScrollExtent,
              duration: Duration(milliseconds: 400),
              curve: Curves.easeInOut),
          // onTap: () => widget.controller. ?? showPriceDetails(),
          child: child,
        );
      else
        return child;
    });
  }

  Future<void> showPriceDetails() {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      builder: (context) => Container(
        // height: MediaQuery.of(context).size.height * 0.9,
        child: PriceDetails(
          price: widget.session.cartProducts.cartValue,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
      ),
      clipBehavior: Clip.antiAlias,
      isDismissible: true,
    );
  }
}
