import 'package:breakq/blocs/cart/cart_bloc.dart';
import 'package:breakq/configs/api_urls.dart';
import 'package:breakq/screens/listing/widgets/product_cart_buttons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/data/models/product_model.dart';
import 'package:breakq/utils/text_style.dart';
import 'package:breakq/utils/string.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sprintf/sprintf.dart';

enum ProductListItemViewType { grid, search, list, block, map }

class ProductListItem extends StatelessWidget {
  const ProductListItem({
    Key key,
    this.product,
    this.viewType,
    this.wordToStyle = '',
    this.showDistance = true,
    this.showFavoriteButton = false,
    this.isFavorited = false,
    this.onFavoriteButtonPressed,
    this.onProductPressed,
    this.onProductAdd,
    this.onProductRem,
    this.onProductDel,
  }) : super(key: key);

  final Product product;
  final ProductListItemViewType viewType;
  final String wordToStyle;
  final bool showDistance;
  final bool showFavoriteButton;
  final bool isFavorited;
  final VoidCallback onFavoriteButtonPressed;
  final VoidCallback onProductPressed;
  final VoidCallback onProductAdd;
  final VoidCallback onProductRem;
  final VoidCallback onProductDel;

  // void _showLocationScreen(BuildContext context) {
  //   Navigator.pushNamed(context, Routes.location, arguments: product.id);
  // }

  @override
  Widget build(BuildContext context) {
    switch (viewType) {
      case ProductListItemViewType.grid:
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
          ),
          margin: EdgeInsets.all(1.0),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius:
                  const BorderRadius.all(Radius.circular(kBoxDecorationRadius)),
              // border: Border.all(
              //   color: Theme.of(context).dividerColor,
              //   width: 1,
              // ),
            ),
            child: BlocBuilder<CartBloc, CartState>(
                buildWhen: (previous, current) => current is CartLoaded,
                builder: (context, state) {
                  int qty = 0;
                  if (state is CartLoaded) {
                    qty = state.cart.cartItems[product] ?? 0;
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      InkWell(
                        splashColor: kBlue200,
                        onTap: onProductPressed ?? () {},
                        onLongPress: () {},
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Stack(
                              alignment: Alignment.topRight,
                              children: [
                                CachedNetworkImage(
                                  // cacheManager: AppCacheManager.instance,
                                  imageUrl: apiBaseFull + product.image,
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CircularProgressIndicator(
                                          value: downloadProgress.progress)
                                    ],
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                    AssetImages.productPlaceholder,
                                    height: 80,
                                    fit: BoxFit.fill,
                                  ),
                                  height: 80,
                                  fit: BoxFit.fill,
                                ),
                                if (qty > 0)
                                  Positioned(
                                    top: 0.0,
                                    right: 0.0,
                                    child: ResetCartButtonCircleIcon(
                                        onProductDel: onProductDel),
                                  ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.only(
                                  top: kPaddingS,
                                  left: kPaddingS,
                                  right: kPaddingS),
                              height: 48,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      product.title,
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption
                                          .black
                                          .fs12
                                          .w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: kPaddingS, right: kPaddingS, top: 2),
                              child: Text(
                                product.quantity ?? "",
                                maxLines: 1,
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .copyWith(
                                        color: Theme.of(context).hintColor),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(height: kPaddingS),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: kPaddingS,
                                  right: kPaddingS,
                                  bottom: kPaddingS,
                                  top: 2),
                              child: Text(
                                "₹ " + product.salePrice.toStringAsFixed(2),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .bold
                                    .number,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: kPaddingS,
                                  right: kPaddingS,
                                  top: kPaddingS),
                              child: Text(
                                (product.maxPrice != product.salePrice)
                                    ? "₹ " + product.maxPrice.toStringAsFixed(2)
                                    : '',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .w500
                                    .number
                                    .copyWith(
                                        decoration: TextDecoration.lineThrough),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (qty <= 0)
                        GridAddButton(onProductAdd: onProductAdd)
                      else
                        GridAddRemButtons(
                          onAdd: onProductAdd,
                          onRem: onProductRem,
                          qty: qty,
                        )
                    ],
                  );
                }),
          ),
        );
        break;

      case ProductListItemViewType.block:
      case ProductListItemViewType.map:
        return Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(1.0),
          ),
          margin: EdgeInsets.all(1.0),
          child: Container(
            height: 180,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius:
                  const BorderRadius.all(Radius.circular(kBoxDecorationRadius)),
              // border: Border.all(
              //   color: Theme.of(context).dividerColor,
              //   width: 1,
              // ),
            ),
            child: InkWell(
              onTap: onProductPressed ?? () {},
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CachedNetworkImage(
                    // cacheManager: AppCacheManager.instance,
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
                      // height:
                      //     viewType == ProductListItemViewType.map ? 160 : 200,
                      fit: BoxFit.contain,
                    ),
                    // height: viewType == ProductListItemViewType.map ? 160 : 200,
                    fit: BoxFit.contain,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: kPaddingS,
                        right: kPaddingS,
                        top: kPaddingS,
                        bottom: kPaddingS / 2),
                    child: Text(
                      product.title,
                      maxLines: 2,
                      style:
                          Theme.of(context).textTheme.caption.black.fs12.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );

      case ProductListItemViewType.list:
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kBoxDecorationRadius),
          ),
          margin: EdgeInsets.zero,
          child: InkWell(
            onTap: onProductPressed ?? () {},
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: const BorderRadius.all(
                    Radius.circular(kBoxDecorationRadius)),
              ),
              child: BlocBuilder<CartBloc, CartState>(
                  buildWhen: (previous, current) => current is CartLoaded,
                  builder: (context, state) {
                    int qty = 0;
                    if (state is CartLoaded) {
                      qty = state.cart.cartItems[product] ?? 0;
                    }
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Row(
                            children: [
                              Stack(
                                children: [
                                  CachedNetworkImage(
                                    // cacheManager: AppCacheManager.instance,
                                    imageUrl: apiBaseFull + product.image,
                                    progressIndicatorBuilder:
                                        (context, url, downloadProgress) =>
                                            Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        CircularProgressIndicator(
                                            value: downloadProgress.progress)
                                      ],
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Image.asset(
                                      AssetImages.productPlaceholder,
                                      width: 75,
                                      height: 75,
                                      fit: BoxFit.cover,
                                    ),
                                    width: 75,
                                    height: 75,
                                    fit: BoxFit.cover,
                                  ),
                                  if (qty > 0)
                                    Positioned(
                                      top: 5.0,
                                      left: 5.0,
                                      child: ResetCartButtonCircleIcon(
                                          onProductDel: onProductDel),
                                    ),
                                ],
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: kPaddingS,
                                      bottom: kPaddingS,
                                      left: kPaddingS,
                                      right: kPaddingS),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text(
                                        product.title,
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption
                                            .black
                                            .fs12
                                            .w600,
                                      ),
                                      const Padding(
                                          padding: EdgeInsets.only(top: 2)),
                                      Text(
                                        sprintf(
                                            '%s', <String>[product.quantity]),
                                        maxLines: 1,
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption
                                            .copyWith(
                                                color: Theme.of(context)
                                                    .hintColor),
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
                                              "₹ " +
                                                  product.maxPrice
                                                      .toStringAsFixed(2),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2
                                                  .number
                                                  .bold,
                                            ),
                                            SizedBox(width: 5),
                                            Visibility(
                                              visible: product.maxPrice !=
                                                  product.salePrice,
                                              child: Text(
                                                "₹ " +
                                                    product.salePrice
                                                        .toStringAsFixed(2),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .caption
                                                    .w300
                                                    .number
                                                    .copyWith(
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (qty <= 0)
                          ListAddItemButton(onProductAdd: onProductAdd)
                        else
                          ListAddRemButtons(
                            onAdd: onProductAdd,
                            onRem: onProductRem,
                            qty: qty,
                          ),
                      ],
                    );
                  }),
            ),
          ),
        );
        break;

      case ProductListItemViewType.search:
        return InkWell(
          onTap: () {
            // _showLocationScreen(context);
          },
          child: Container(
            decoration: BoxDecoration(
              //color: Theme.of(context).cardColor,
              border: Border(
                bottom: BorderSide(
                  width: 1,
                  color: Theme.of(context).dividerColor,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: kPaddingS),
                  child: Icon(
                    Icons.location_on,
                    color: Theme.of(context).disabledColor,
                    size: 36,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: kPaddingM, bottom: kPaddingM),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          if (wordToStyle.isEmpty)
                            Text(
                              product.title,
                              style: Theme.of(context).textTheme.subtitle1,
                              overflow: TextOverflow.ellipsis,
                            )
                          else
                            RichText(
                              text: TextSpan(
                                style: Theme.of(context).textTheme.subtitle1,
                                children: product.title.getSpans(
                                  matchWord: wordToStyle,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          Text(
                            sprintf('%s', <String>[product.quantity]),
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                .copyWith(color: Theme.of(context).hintColor),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ]),
                  ),
                ),
              ],
            ),
          ),
        );
        break;

      default:
        return Container();
    }
  }
}
