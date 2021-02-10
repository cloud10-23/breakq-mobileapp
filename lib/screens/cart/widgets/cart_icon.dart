import 'package:breakq/configs/constants.dart';
import 'package:breakq/configs/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_badged/flutter_badge.dart';

class CartIconButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: kPaddingL),
      child: InkWell(
          onTap: () {
            Navigator.of(context, rootNavigator: true).pushNamed(Routes.cart);
          },
          child: FlutterBadge(
            icon: Icon(Icons.shopping_cart_sharp),
            itemCount: 3,
            contentPadding: EdgeInsets.symmetric(horizontal: kPaddingS),
          )),
    );
  }
}
