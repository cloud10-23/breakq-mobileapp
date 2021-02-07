import 'package:breakq/blocs/cart/cart_bloc.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/configs/routes.dart';
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
              toolbarHeight: 50.0,
              elevation: 0.0,
              leading: IconButton(
                  icon: Icon(Icons.arrow_drop_down_circle, size: 30),
                  onPressed: () => Navigator.pop(context)),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: kPaddingL),
                  child: InkWell(
                    onTap: () {
                      BlocProvider.of<CartBloc>(context).add(ResetCartEvent());
                    },
                    child: Icon(Icons.delete),
                  ),
                ),
              ],
              centerTitle: true,
              title: Row(
                children: [
                  Spacer(flex: 6),
                  Image(
                    image: AssetImage(AssetImages.cart),
                    height: 25,
                  ),
                  Spacer(),
                  Text('Cart'),
                  Spacer(flex: 6),
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
                        margin: EdgeInsets.symmetric(horizontal: kPaddingM),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                BoldTitle(
                                  title:
                                      "No of Products:  ${state.cart.cartItems.length}",
                                ),
                                BoldTitle(
                                  title:
                                      "No of Items:  ${state.cart.noOfProducts}",
                                ),
                              ],
                            ),
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
                  SizedBox(height: 5.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BoldTitle(
                        title: 'Price: ',
                        padding: EdgeInsets.symmetric(horizontal: kPaddingM),
                        color: Colors.grey[700],
                      ),
                      BoldTitle(
                        title: (state is CartLoaded)
                            ? '₹ ' +
                                (state.cart?.orgCartValue?.toStringAsFixed(2) ??
                                    "00.00")
                            : '₹ 00.00',
                        padding: EdgeInsets.symmetric(horizontal: kPaddingM),
                        color: Colors.grey[700],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BoldTitle(
                        title: 'Discount: ',
                        padding: EdgeInsets.symmetric(horizontal: kPaddingM),
                        color: Colors.green[800],
                      ),
                      BoldTitle(
                        title: (state is CartLoaded)
                            ? '- ₹ ' +
                                (((state.cart?.orgCartValue ?? 0) -
                                            (state.cart?.cartValue ?? 0))
                                        ?.toStringAsFixed(2) ??
                                    "00.00")
                            : '- ₹ 00.00',
                        padding: EdgeInsets.symmetric(horizontal: kPaddingM),
                        color: Colors.green[800],
                      ),
                    ],
                  ),
                  SizedBox(height: kPaddingM),
                  Container(
                    height: 1.0,
                    color: Colors.black12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomTitle(
                        title: 'Cart Total:',
                        fw: FontWeight.w600,
                      ),
                      CustomTitle(
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
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true)
                          .popAndPushNamed(Routes.checkout);
                    },
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
