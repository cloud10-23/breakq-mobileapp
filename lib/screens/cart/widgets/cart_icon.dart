import 'package:breakq/blocs/cart/cart_bloc.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/configs/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_badged/flutter_badge.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:breakq/utils/text_style.dart';

class CartIconButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kPaddingM),
      child: InkWell(
          onTap: () {
            Navigator.of(context, rootNavigator: true).pushNamed(Routes.cart);
          },
          child: CartIconWithBadge()),
    );
  }
}

class CartFloatingButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: null,
      backgroundColor: kWhite,
      onPressed: () =>
          Navigator.of(context, rootNavigator: true).pushNamed(Routes.cart),
      child: CartIconWithBadge(color: kBlack),
    );
  }
}

class CartIconWithBadge extends StatelessWidget {
  CartIconWithBadge({this.color});
  final Color color;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      buildWhen: (previous, current) => current is CartLoaded,
      builder: (context, state) {
        if (state is CartLoaded) {
          return FlutterBadge(
            icon: Padding(
              padding: const EdgeInsets.only(right: kPaddingM),
              child: Icon(
                FontAwesome.shopping_cart,
                size: 22.0,
                color: color,
              ),
            ),
            textStyle: Theme.of(context).textTheme.bodyText1.white.w600.number,
            textSize: 12.0,
            itemCount: state?.cart?.noOfProducts ?? 0,
          );
        }
        return FlutterBadge(
          icon: Icon(
            FontAwesome.shopping_cart,
            size: 22.0,
            color: color,
          ),
          itemCount: 0,
        );
      },
    );
  }
}

class CartIconPlane extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Icon(
      FontAwesome.shopping_cart,
      size: 20.0,
      color: kBlack,
    );
  }
}
