import 'package:breakq/configs/constants.dart';
import 'package:breakq/data/models/checkout_session.dart';
import 'package:breakq/screens/cart/widgets/cart_helper.dart';
import 'package:breakq/screens/checkout/widgets/cart_products_listing.dart';
import 'package:breakq/screens/checkout/widgets/radio_helper.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ShowQRModule extends StatelessWidget {
  ShowQRModule({@required this.billNo});
  final String billNo;

  @override
  Widget build(BuildContext context) {
    return CartHeading(
      title: 'Show QR Code',
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kPaddingL),
          child: Text(
            "Order No: ${billNo ?? 123445678990}",
            style: Theme.of(context).textTheme.caption,
          ),
        ),
        SizedBox(height: kPaddingS),
        Center(
          child: QrImage(
            data: billNo ?? 'ERROR',
            version: QrVersions.auto,
            backgroundColor: kWhite,
            size: 100,
            gapless: false,
            // embeddedImage: AssetImage(AssetImages.icon),
            embeddedImageStyle: QrEmbeddedImageStyle(
              size: Size(30, 30),
            ),
          ),
        ),
        SizedBox(height: kPaddingM),
      ],
    );
  }
}

class CheckoutTypeModule extends StatelessWidget {
  CheckoutTypeModule({@required this.session});
  final CheckoutSession session;
  @override
  Widget build(BuildContext context) {
    return CartHeading(
      title: 'Checkout Type',
      children: [
        Padding(
            padding: const EdgeInsets.only(left: kPaddingM),
            child: CheckoutTypeOption(index: 0, session: session)),
      ],
    );
  }
}

class CartProductsModule extends StatelessWidget {
  CartProductsModule({@required this.session});
  final CheckoutSession session;
  @override
  Widget build(BuildContext context) {
    return CartHeading(
      title: 'Cart products',
      children: [
        CartProductsReadOnly(
          products: session.cartProducts.cartItems,
        )
      ],
    );
  }
}
