import 'package:breakq/blocs/cart/cart_bloc.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/data/models/toolbar_option_model.dart';
import 'package:breakq/screens/listing/widgets/search_result_list.dart';
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
                            BoldTitle(
                                title:
                                    "Items in your Cart ( ${state.cart.noOfProducts} )"),
                            Expanded(
                              child: Container(
                                color: kWhite,
                                padding: EdgeInsets.all(kPaddingS),
                                child: SingleChildScrollView(
                                  child: SearchResultList(
                                    currentListType: ToolbarOptionModel(
                                        'list', 'List', Icons.list),
                                    products: state.cart.cartItems
                                        .map((cartItem) => cartItem.product)
                                        .toList(),
                                  ),
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
                      CartTitle(
                        title: 'Cart Total:',
                      ),
                      CartTitle(
                        title: (state is CartLoaded)
                            ? state.cart.cartValue.toString()
                            : '0.00',
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
