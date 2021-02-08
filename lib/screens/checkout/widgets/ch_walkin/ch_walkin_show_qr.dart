import 'package:breakq/blocs/checkout/ch_bloc.dart';
import 'package:breakq/data/models/checkout_session.dart';
import 'package:breakq/generated/l10n.dart';
import 'package:breakq/screens/checkout/widgets/helper_widgets.dart';
import 'package:breakq/widgets/jumbotron.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:breakq/configs/constants.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ChWalkInShowQr extends StatefulWidget {
  @override
  _ChWalkInShowQrState createState() => _ChWalkInShowQrState();
}

class _ChWalkInShowQrState extends State<ChWalkInShowQr> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: BlocBuilder<CheckoutBloc, CheckoutState>(
        builder: (BuildContext context, CheckoutState state) {
          final CheckoutSession session =
              (state as SessionRefreshSuccessChState).session;

          if (session.cartProducts?.cartItems?.keys?.isEmpty ?? true) {
            return Container(
              alignment: AlignmentDirectional.center,
              child: Jumbotron(
                title: L10n.of(context).QSWarningProducts,
                icon: Icons.report,
              ),
            );
          }

          final List<Widget> _listItems = <Widget>[];

          _listItems
              .add(SliverToBoxAdapter(child: SizedBox(height: kPaddingL)));
          _listItems.add(
              makeHeader(context, "Show this QR Code at the billing counter"));
          _listItems
              .add(SliverToBoxAdapter(child: SizedBox(height: kPaddingL * 2)));

          _listItems.add(SliverToBoxAdapter(
            child: Container(
              color: kPrimaryAccentColor,
              child: Padding(
                padding: const EdgeInsets.all(kPaddingL),
                child: Column(
                  children: [
                    SizedBox(height: kPaddingM),
                    QrImage(
                      data: session.billNo ?? 'ERROR',
                      version: QrVersions.auto,
                      backgroundColor: kWhite,
                      size: 240,
                      gapless: false,
                      embeddedImage: AssetImage(AssetImages.icon),
                      embeddedImageStyle: QrEmbeddedImageStyle(
                        size: Size(30, 30),
                      ),
                    ),
                    SizedBox(height: kPaddingM),
                    Text("Bill No: ${session.billNo}"),
                  ],
                ),
              ),
            ),
          ));

          // final List<Product> _products = session.cartProducts.cartItems.keys;

          // _listItems
          //     .addAll(_products.map((product) => _productItem(product, session)));

          return CustomScrollView(
            slivers: _listItems,
          );
        },
      ),
    );
  }
}
