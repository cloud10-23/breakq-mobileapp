import 'package:breakq/blocs/cart/cart_bloc.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/configs/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_badged/flutter_badge.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartIconButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: kPaddingS, vertical: 12.0),
      child: InkWell(
          onTap: () {
            Navigator.of(context, rootNavigator: true).pushNamed(Routes.cart);
          },
          child: BlocBuilder<CartBloc, CartState>(
            buildWhen: (previous, current) => current is CartLoaded,
            builder: (context, state) {
              if (state is CartLoaded) {
                return FlutterBadge(
                  icon: Image(image: AssetImage(AssetImages.cartIcon)),
                  textSize: 8.0,
                  itemCount: state?.cart?.noOfProducts ?? 0,
                );
              }
              return FlutterBadge(
                icon: Image(image: AssetImage(AssetImages.cartIcon)),
                itemCount: 0,
              );
            },
          )),
    );
  }
}
