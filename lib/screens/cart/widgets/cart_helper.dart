import 'package:breakq/configs/constants.dart';
import 'package:breakq/data/models/price_model.dart';
import 'package:breakq/screens/scan/barcode_scanner.dart';
import 'package:breakq/widgets/bold_title.dart';
import 'package:breakq/widgets/card_template.dart';
import 'package:breakq/widgets/horizontal_products.dart';
import 'package:flutter/material.dart';
import 'package:breakq/utils/text_style.dart';

class CardTemplate extends StatelessWidget {
  CardTemplate({@required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kWhite,
      margin: const EdgeInsets.all(kPaddingS),
      padding: EdgeInsets.all(kPaddingS),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: children,
      ),
    );
  }
}

class CartEmptyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            primary: true,
            backgroundColor: kWhite,
            pinned: true,
            title: Row(
              children: [
                Image(
                  image: AssetImage(AssetImages.cart),
                  height: 25,
                  // color: kWhite,
                ),
                Spacer(),
                Text('My Cart',
                    style: Theme.of(context).textTheme.bodyText1.fs16),
                Spacer(flex: 9),
              ],
            ),
            actions: <Widget>[],
            flexibleSpace:
                FlexibleSpaceBar(background: Container(color: kWhite)),
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  color: kWhite,
                  child: Column(
                    children: [
                      Image(
                        image: AssetImage(AssetImages.cartEmpty),
                        height: 120,
                      ),
                      SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.all(kPaddingM),
                        child: Text(
                          'Your Cart is Empty!',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              .bold
                              .fs18
                              .copyWith(color: Theme.of(context).disabledColor),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Text(
                        "Try adding more items to your cart!",
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            .copyWith(color: Theme.of(context).disabledColor),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 30),
                    ],
                  ),
                ),
                CartScannerOption(),
                CartFooter(),
                EndPadding(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CartFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CartSuggestionsBuilder(),
        CartRecentlyScanned(),
      ],
    );
  }
}

class CartScannerOption extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => BarcodeScanner().scan(context),
      child: Container(
        color: kBlue,
        margin: const EdgeInsets.symmetric(
            vertical: kPaddingL, horizontal: kPaddingS),
        padding: EdgeInsets.all(kPaddingS),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(kPaddingM),
                child: Row(
                  children: [
                    Image(
                      image: AssetImage(AssetImages.scan),
                      color: Colors.white70,
                    ),
                    Spacer(),
                    BoldTitle(
                      title: "Scan & Add to Cart".toUpperCase(),
                      padding: EdgeInsets.symmetric(horizontal: kPaddingM),
                      color: Colors.white70,
                      fw: FontWeight.w600,
                    ),
                    Spacer(flex: 9),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white70,
                    ),
                  ],
                ),
              ),
            ]),
      ),
    );
  }
}

class CartSuggestionsBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CartHeading(title: "Suggested For You", children: [
      ProductsHorizontalView(),
    ]);
  }
}

class CartRecentlyScanned extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CartHeading(title: "Recently Scanned", children: [
      ProductsHorizontalView(),
    ]);
  }
}

class EndPadding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
    );
  }
}
