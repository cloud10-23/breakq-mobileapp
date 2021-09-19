import 'package:breakq/configs/api_urls.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/data/models/product_model.dart';
import 'package:breakq/utils/app_cache_manager.dart';
import 'package:breakq/widgets/offer_widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:breakq/utils/text_style.dart';

class CartProductsReadOnly extends StatelessWidget {
  CartProductsReadOnly({
    Key key,
    this.products,
  }) : super(key: key);

  final Map<Product, int> products;

  @override
  Widget build(BuildContext context) {
    List<Widget> _items = [];
    products.forEach((product, qty) {
      _items.add(ProductItemReadOnly(product: product, qty: qty));
    });
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: kPaddingS, vertical: kPaddingM),
      child: Wrap(
          runSpacing: kPaddingM,
          alignment: WrapAlignment.spaceBetween,
          children: _items),
    );
  }
}

class ProductItemReadOnly extends StatelessWidget {
  ProductItemReadOnly({this.product, this.qty});
  final Product product;
  final int qty;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kBoxDecorationRadius),
      ),
      margin: EdgeInsets.zero,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius:
              const BorderRadius.all(Radius.circular(kBoxDecorationRadius)),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: [
                    Container(
                      width: 65,
                      height: 65,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(kBoxDecorationRadius),
                          bottomLeft: Radius.circular(kBoxDecorationRadius),
                        ),
                      ),
                      child: CachedNetworkImage(
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
                          fit: BoxFit.cover,
                        ),
                        fit: BoxFit.cover,
                      ),
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
                                style:
                                    Theme.of(context).textTheme.bodyText2.w600,
                              ),
                              if ((product?.discountPercent ?? 0) > 0)
                                SizedBox(width: kPaddingL),
                              if ((product?.discountPercent ?? 0) > 0)
                                OfferTextGreen(product.discountPercent),
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
                                        color: Theme.of(context).hintColor),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Text(
                                "₹ " + product.salePrice.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    .fs10
                                    .number
                                    .bold,
                              ),
                              SizedBox(width: 2),
                              if (product.salePrice < product.maxPrice)
                                Text(
                                  "₹ " + product.maxPrice.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      .fs10
                                      .w300
                                      .number
                                      .copyWith(
                                          decoration:
                                              TextDecoration.lineThrough),
                                ),
                            ],
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
                            "₹ ${product.salePrice}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .bold
                                .number,
                          ),
                          SizedBox(width: 5),
                          if (product.salePrice < product.maxPrice)
                            Text(
                              "₹ ${product.maxPrice}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .w300
                                  .number
                                  .copyWith(
                                      decoration: TextDecoration.lineThrough),
                            ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Qty:  $qty",
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            .w800
                            .copyWith(color: Colors.black26),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
