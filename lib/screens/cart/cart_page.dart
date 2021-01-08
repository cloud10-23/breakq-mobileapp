import 'package:breakq/blocs/cart/cart_bloc.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/data/models/toolbar_option_model.dart';
import 'package:breakq/generated/l10n.dart';
import 'package:breakq/screens/listing/widgets/search_result_list.dart';
import 'package:breakq/widgets/bold_title.dart';
import 'package:breakq/widgets/jumbotron.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
      body: BlocBuilder<CartBloc, CartState>(
          buildWhen: (previous, current) => current is CartLoaded,
          builder: (context, state) {
            if (state is CartLoaded) {
              if (state.cartItems.cartItems?.isEmpty ?? true) {
                return Container(
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
                            .copyWith(color: Theme.of(context).disabledColor),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              }
              return Container(
                margin: EdgeInsets.all(kPaddingL),
                child: Column(
                  children: [
                    BoldTitle(
                        title: "Items in your Cart ( ${state.totalItems} )"),
                    Expanded(
                      child: Container(
                        color: kWhite,
                        padding: EdgeInsets.all(kPaddingM),
                        child: SingleChildScrollView(
                          child: SearchResultList(
                            currentListType:
                                ToolbarOptionModel('list', 'List', Icons.list),
                            products: state.cartItems.cartItems
                                .map((cartItem) => cartItem.product)
                                .toList(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            return Center(child: CircularProgressIndicator());
          }),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: kPaddingL, vertical: kPaddingM),
        child: FlatButton(
          onPressed: () {},
          color: kBlack,
          child: Text('Proceed to Checkout'),
        ),
      ),
    );
  }
}
