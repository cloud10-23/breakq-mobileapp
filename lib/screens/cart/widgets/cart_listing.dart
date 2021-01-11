import 'package:breakq/configs/app_globals.dart';
import 'package:breakq/screens/cart/widgets/cart_item.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/data/models/product_model.dart';

class CartListing extends StatelessWidget {
  CartListing({
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
          return CartListItem(
            product: item,
          );
        }).toList(),
      ),
    );
  }
}
