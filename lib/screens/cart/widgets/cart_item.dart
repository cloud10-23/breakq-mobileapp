import 'package:breakq/blocs/cart/cart_bloc.dart';
import 'package:breakq/configs/app_globals.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/data/models/product_model.dart';
import 'package:breakq/main.dart';
import 'package:breakq/widgets/offer_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sprintf/sprintf.dart';
import 'package:breakq/utils/text_style.dart';
import 'package:breakq/screens/listing/widgets/product_cart_buttons.dart';

class CartListItem extends StatelessWidget {
  CartListItem({this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kBoxDecorationRadius),
      ),
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: () => getIt.get<AppGlobals>().onProductPressed(product, context),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius:
                const BorderRadius.all(Radius.circular(kBoxDecorationRadius)),
          ),
          child: BlocBuilder<CartBloc, CartState>(
              buildWhen: (previous, current) => current is CartLoaded,
              builder: (context, state) {
                int qty = 0;
                if (state is CartLoaded) {
                  qty = state.cart.cartItems[product] ?? 0;
                }
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          children: [
                            Container(
                              width: 75,
                              height: 75,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(product.image),
                                  // image: NetworkImage(product.image),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: const BorderRadius.only(
                                  topLeft:
                                      Radius.circular(kBoxDecorationRadius),
                                  bottomLeft:
                                      Radius.circular(kBoxDecorationRadius),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: kPaddingS,
                                  bottom: kPaddingS,
                                  left: kPaddingS,
                                  right: kPaddingS),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    product.title,
                                    maxLines: 1,
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2
                                        .w600,
                                  ),
                                  const Padding(
                                      padding: EdgeInsets.only(top: 2)),
                                  Text(
                                    sprintf('%s', <String>[product.quantity]),
                                    maxLines: 1,
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption
                                        .copyWith(
                                            color: Theme.of(context).hintColor),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: kPaddingS,
                                        right: kPaddingS,
                                        bottom: kPaddingS,
                                        top: 2),
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          "₹ " + product.price.toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2
                                              .bold,
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          "₹ " + product.oldPrice.toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption
                                              .w300
                                              .copyWith(
                                                  decoration: TextDecoration
                                                      .lineThrough),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: kPaddingM),
                          child: Column(
                            children: [
                              Row(
                                children: <Widget>[
                                  Text(
                                    "₹ ${product.price * qty}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1
                                        .bold,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    "₹ ${product.oldPrice * qty}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        .w300
                                        .copyWith(
                                            decoration:
                                                TextDecoration.lineThrough),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              OfferTextGreen(),
                            ],
                          ),
                        ),
                      ],
                    ),
                    if (qty > 0)
                      Padding(
                        padding: const EdgeInsets.all(kPaddingM),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ResetCartButtonText(
                              onProductDel: () => getIt
                                  .get<AppGlobals>()
                                  .onProductDel(product, context),
                            ),
                            ListAddRemButtons(
                              onAdd: () => getIt
                                  .get<AppGlobals>()
                                  .onProductAdd(product, context),
                              onRem: () => getIt
                                  .get<AppGlobals>()
                                  .onProductRed(product, context),
                              qty: qty,
                            ),
                          ],
                        ),
                      )
                  ],
                );
              }),
        ),
      ),
    );
  }
}
