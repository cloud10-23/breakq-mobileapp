import 'package:breakq/blocs/cart/cart_bloc.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/screens/cart/widgets/cart_listing.dart';
import 'package:breakq/widgets/bold_title.dart';
import 'package:breakq/widgets/jumbotron.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:breakq/utils/text_style.dart';

class CartBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
        buildWhen: (previous, current) => current is CartLoaded,
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              leading: IconButton(
                  icon: Icon(Icons.arrow_drop_down_circle),
                  onPressed: () => Navigator.pop(context)),
              centerTitle: true,
              title: Row(
                children: [
                  Spacer(flex: 3),
                  Image(image: AssetImage(AssetImages.cart)),
                  Spacer(),
                  Text('Cart'),
                  Spacer(flex: 5),
                ],
              ),
            ),
            backgroundColor: kPrimaryColor,
            body: (state is CartLoaded)
                ? (state.cart.cartItems?.isEmpty ?? true)
                    ? Container(
                        color: kWhite,
                        margin: EdgeInsets.all(kPaddingL),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Jumbotron(
                              title: "Your Cart is Empty!",
                              icon: Icons.add_shopping_cart,
                            ),
                            Text(
                              "Try adding more items to your cart!",
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  .copyWith(
                                      color: Theme.of(context).disabledColor),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )
                    : Container(
                        margin: EdgeInsets.all(kPaddingM),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                BoldTitle(
                                  title:
                                      "Products in Cart ( ${state.cart.cartItems.length} )",
                                ),
                                BoldTitle(
                                  title:
                                      "Items in Cart ( ${state.cart.noOfProducts} )",
                                ),
                                InkWell(
                                  onTap: () {
                                    BlocProvider.of<CartBloc>(context)
                                        .add(ResetCartEvent());
                                  },
                                  child: Row(
                                    children: [
                                      Icon(Icons.delete),
                                      Text("Reset Cart"),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.0),
                            Expanded(
                              child: Container(
                                color: kWhite,
                                padding: EdgeInsets.all(kPaddingS),
                                child: SingleChildScrollView(
                                  child: CartListing(
                                      products:
                                          state.cart.cartItems.keys.toList()),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                : Center(child: CircularProgressIndicator()),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: kPaddingL, vertical: kPaddingM),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      VeryBoldTitle(
                        title: 'Cart Total:',
                        fw: FontWeight.w600,
                      ),
                      VeryBoldTitle(
                        title: (state is CartLoaded)
                            ? '₹ ' +
                                (state.cart?.cartValue?.toStringAsFixed(2) ??
                                    "00.00")
                            : '₹ 00.00',
                      ),
                    ],
                  ),
                  SizedBox(height: kPaddingM),
                  FlatButton(
                    onPressed: () {},
                    color: kBlack,
                    child: Text('Proceed to Checkout',
                        style: Theme.of(context).textTheme.bodyText2.white),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
