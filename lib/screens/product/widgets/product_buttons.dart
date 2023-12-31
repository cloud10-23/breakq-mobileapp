import 'package:breakq/configs/constants.dart';
import 'package:breakq/data/models/product_model.dart';
import 'package:flutter/material.dart';

class CartAddBulkButton extends StatelessWidget {
  CartAddBulkButton({this.text, this.onTap});

  final String text;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () {},
      child: Card(
        elevation: 2.0,
        clipBehavior: Clip.antiAlias,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
        child: Padding(
          padding: const EdgeInsets.all(kPaddingM),
          child: Text(text ?? ""),
        ),
      ),
    );
  }
}

class BulkAddButtons extends StatelessWidget {
  BulkAddButtons({@required this.product, @required this.onPressed});
  final Product product;
  final Function(int) onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: kPaddingM),
      child: Wrap(
        children: bulkAddToCart
            .map((map) => CartAddBulkButton(
                  text: map.keys.first,
                  onTap: () => onPressed(map.values.first),
                ))
            .toList(),
      ),
    );
  }
}
