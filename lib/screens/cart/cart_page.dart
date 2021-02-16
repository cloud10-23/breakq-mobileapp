import 'package:breakq/blocs/cart/cart_bloc.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/configs/routes.dart';
import 'package:breakq/screens/cart/widgets/cart_helper.dart';
import 'package:breakq/screens/cart/widgets/cart_listing.dart';
import 'package:breakq/widgets/price_details.dart';
import 'package:breakq/widgets/bold_title.dart';
import 'package:breakq/widgets/card_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:breakq/utils/text_style.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
        buildWhen: (previous, current) => current is CartLoaded,
        builder: (context, state) {
          if (state is! CartLoaded) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if ((state as CartLoaded).cart.cartItems?.isEmpty ?? true) {
            return CartEmptyScreen();
          }

          return Scaffold(
            primary: true,
            body: CustomScrollView(
              controller: _controller,
              slivers: [
                SliverAppBar(
                  primary: true,
                  backgroundColor: kWhite,
                  pinned: true,
                  expandedHeight: 200,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Row(
                      children: [
                        Image(
                          image: AssetImage(AssetImages.cart),
                          height: 25,
                          // color: kWhite,
                        ),
                        Spacer(),
                        Text('My Cart',
                            style: Theme.of(context).textTheme.bodyText1.fs16),
                        Spacer(flex: 9),
                      ],
                    ),
                    background: Image(
                      image: AssetImage(AssetImages.cartIllustration),
                      fit: BoxFit.fill,
                    ),
                  ),
                  actions: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: kPaddingL),
                      child: InkWell(
                        onTap: () {
                          BlocProvider.of<CartBloc>(context)
                              .add(ResetCartEvent());
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.delete,
                            ), // color: kWhite),
                            Text(
                              "CLEAR",
                              style: TextStyle(
                                  // color: kWhite,
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ], // remove the hamburger menu
                  title: Row(
                    children: [
                      Spacer(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Items:  ${(state as CartLoaded).cart.cartItems.length}",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 12.0),
                            // color: kWhite),
                          ),
                          Text(
                            "Qty:      ${(state as CartLoaded).cart.noOfProducts}",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 12.0),
                            // color: kWhite),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      CartScannerOption(),
                      _cartItemsBuilder(context, state),
                      CartFooter(),
                      PriceDetails(price: (state as CartLoaded).cart.cartValue),
                      EndPadding(),
                    ],
                  ),
                ),
              ],
            ),
            bottomNavigationBar: _bottomBar(context, state),
          );
        });
  }

  Widget _cartItemsBuilder(BuildContext context, CartLoaded state) {
    return CartHeading(
        title: 'Cart Products',
        children: [CartListing(products: state.cart.cartItems.keys.toList())]);
  }

  Widget _bottomBar(BuildContext context, CartLoaded state) {
    return Container(
      decoration: BoxDecoration(
        color: kWhite,
        border: Border(
          top: BorderSide(
            width: 2,
            color: Theme.of(context).dividerColor,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(
          vertical: kPaddingM, horizontal: kPaddingM),
      child: SafeArea(
        top: false,
        child: Row(
          children: <Widget>[
            InkWell(
              onTap: () => _controller.animateTo(
                  _controller.position.maxScrollExtent,
                  duration: Duration(milliseconds: 400),
                  curve: Curves.easeInOut),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomTitle(
                        title: 'Pay:',
                        padding: EdgeInsets.symmetric(
                            horizontal: kPaddingS, vertical: kPaddingM),
                        fw: FontWeight.w800,
                      ),
                      CustomTitle(
                        title: '₹ ' +
                                (state.cart.cartValue.totalAmnt)
                                    .toStringAsFixed(2) ??
                            "00.00",
                        padding: EdgeInsets.symmetric(horizontal: kPaddingM),
                        fw: FontWeight.w700,
                      ),
                    ],
                  ),
                  BoldTitle(
                    title: 'View price details',
                    padding: EdgeInsets.symmetric(horizontal: kPaddingS),
                    color: kHyperLinkColor,
                    fw: FontWeight.w700,
                  ),
                ],
              ),
            ),
            Spacer(),
            RaisedButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true)
                    .popAndPushNamed(Routes.checkout);
              },
              child: Text('Proceed to Checkout',
                  style: Theme.of(context).textTheme.bodyText2.white),
            ),
          ],
        ),
      ),
    );
  }
}
