import 'package:breakq/blocs/cart/cart_bloc.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/data/models/checkout_session.dart';
import 'package:breakq/generated/l10n.dart';
import 'package:breakq/screens/cart/widgets/cart_helper.dart';
import 'package:breakq/utils/ui.dart';
import 'package:flutter/material.dart';
import 'package:breakq/utils/text_style.dart';

class CheckoutTemplate extends StatefulWidget {
  CheckoutTemplate({@required this.slivers, @required this.session});

  final List<Widget> slivers;
  final CheckoutSession session;

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
                      UI.confirmationDialogBox(context,
                          title: "Warning !",
                          cancelButtonText: "No",
                          okButtonText: "Yes",
                          message: "Are you sure you want to cancel checkout?",
                          onConfirmation: () {
                        Navigator.of(context, rootNavigator: true).pop();
                      });
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
                              ? 'Amount to Pay (${widget.session?.cartProducts?.noOfProducts ?? 0} item)'
                              : 'Amount to Pay (${widget.session?.cartProducts?.noOfProducts ?? 0} items)',
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
                Spacer(),
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
                      style: Theme.of(context).textTheme.headline6.w700,
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
