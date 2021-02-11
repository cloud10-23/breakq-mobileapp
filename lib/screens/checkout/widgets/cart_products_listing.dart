import 'package:breakq/configs/constants.dart';
import 'package:breakq/data/models/product_model.dart';
import 'package:breakq/widgets/offer_widgets.dart';
import 'package:flutter/material.dart';
import 'package:breakq/utils/text_style.dart';

class CartProductsReadOnly extends StatelessWidget {
  CartProductsReadOnly({
    Key key,
    this.products,
  }) : super(key: key);

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: kPaddingS, vertical: kPaddingM),
      child: Wrap(
        runSpacing: kPaddingM,
        alignment: WrapAlignment.spaceBetween,
        children: products.map((Product item) {
          return ProductItemReadOnly(product: item);
        }).toList(),
      ),
    );
  }
}

class ProductItemReadOnly extends StatelessWidget {
  ProductItemReadOnly({this.product});
  final Product product;

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
                        image: DecorationImage(
                          image: AssetImage(product.image),
                          // image: NetworkImage(product.image),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(kBoxDecorationRadius),
                          bottomLeft: Radius.circular(kBoxDecorationRadius),
                        ),
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
                              SizedBox(width: kPaddingL),
                              OfferTextGreen(),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Text(
                                product.quantity,
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
                                "₹ " + product.price.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    .fs10
                                    .bold,
                              ),
                              SizedBox(width: 2),
                              Text(
                                "₹ " + product.oldPrice.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .fs10
                                    .w300
                                    .copyWith(
                                        decoration: TextDecoration.lineThrough),
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
                            "₹ ${product.price}",
                            style: Theme.of(context).textTheme.bodyText1.bold,
                          ),
                          SizedBox(width: 5),
                          Text(
                            "₹ ${product.oldPrice}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .w300
                                .copyWith(
                                    decoration: TextDecoration.lineThrough),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Qty:  2",
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
