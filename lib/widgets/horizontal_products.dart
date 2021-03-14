import 'package:breakq/configs/constants.dart';
import 'package:breakq/screens/home/widgets/home_extras.dart';
import 'package:flutter/material.dart';

class ProductsHorizontalView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: kPaddingS),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          5,
          (index) =>
              ExclProductsCard(index: index), //TopDealsCard(index: index),
        ),
      ),
    );
  }
}
