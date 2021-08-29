import 'package:breakq/configs/constants.dart';
import 'package:breakq/data/models/product_model.dart';
import 'package:breakq/screens/home/widgets/home_extras.dart';
import 'package:flutter/material.dart';

class ProductsHorizontalView extends StatelessWidget {
  ProductsHorizontalView({@required this.products});
  final List<Product> products;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: kPaddingS),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          products.length,
          (index) => ExclProductsCard(product: products[index]),
        ),
      ),
    );
  }
}
