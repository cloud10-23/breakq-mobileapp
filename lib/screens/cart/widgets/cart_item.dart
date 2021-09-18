import 'package:breakq/blocs/cart/cart_bloc.dart';
import 'package:breakq/configs/api_urls.dart';
import 'package:breakq/configs/app_globals.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/data/models/product_model.dart';
import 'package:breakq/main.dart';
import 'package:breakq/utils/app_cache_manager.dart';
import 'package:breakq/widgets/offer_widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                            CachedNetworkImage(
                              cacheManager: AppCacheManager.instance,
                              imageUrl: apiBaseFull + product.image,
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) => Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircularProgressIndicator(
                                      value: downloadProgress.progress)
                                ],
                              ),
                              errorWidget: (context, url, error) => Image.asset(
                                AssetImages.productPlaceholder,
                                width: 65,
                                height: 65,
                                fit: BoxFit.fill,
                              ),
                              width: 65,
                              height: 65,
                              fit: BoxFit.fill,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: kPaddingS,
                                  bottom: kPaddingS,
                                  left: kPaddingM,
                                  right: kPaddingS),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: [
                                      Text(
                                        product.title,
                                        maxLines: 1,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            .w600,
                                      ),
                                      SizedBox(width: kPaddingL),
                                      Visibility(
                                          visible:
                                              (product.discountPercent ?? 0) >
                                                  0,
                                          child: OfferTextGreen(
                                              product.discountPercent)),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Text(
                                        product.quantity ?? "",
                                        maxLines: 1,
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption
                                            .fs10
                                            .copyWith(
                                                color: Theme.of(context)
                                                    .hintColor),
                                      ),
                                      SizedBox(width: kPaddingM),
                                      Text(
                                        "₹ " +
                                            product.salePrice
                                                .toStringAsFixed(2),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            .fs10
                                            .number
                                            .bold,
                                      ),
                                      SizedBox(width: 2),
                                      Visibility(
                                        visible: product.maxPrice >
                                            product.salePrice,
                                        child: Text(
                                          "₹ " +
                                              product.maxPrice
                                                  .toStringAsFixed(2),
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption
                                              .fs10
                                              .w300
                                              .number
                                              .copyWith(
                                                  decoration: TextDecoration
                                                      .lineThrough),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  ResetCartButtonText(
                                    onProductDel: () => getIt
                                        .get<AppGlobals>()
                                        .onProductDel(product, context),
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
                                    "₹ " +
                                        (product.salePrice * qty)
                                            .toStringAsFixed(2),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        .number
                                        .bold,
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              ListAddRemButtonSmall(
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
                        ),
                      ],
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
