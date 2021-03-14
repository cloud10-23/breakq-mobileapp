import 'package:breakq/blocs/cart/cart_bloc.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/configs/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_badged/flutter_badge.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';

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
                  icon: Icon(
                    FontAwesome.shopping_cart,
                    size: 16.0,
                    color: kBlack,
                  ),
                  textSize: 8.0,
                  itemCount: state?.cart?.noOfProducts ?? 0,
                );
              }
              return FlutterBadge(
                icon: Icon(
                  FontAwesome.shopping_cart,
                  size: 16.0,
                  color: kBlack,
                ),
                itemCount: 0,
              );
            },
          )),
    );
  }
}

class CartIconPlane extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Icon(
      FontAwesome.shopping_cart,
      size: 16.0,
      color: kBlack,
    );
  }
}
