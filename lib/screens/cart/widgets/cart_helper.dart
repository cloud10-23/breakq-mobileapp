import 'package:breakq/configs/constants.dart';
import 'package:breakq/data/models/product_model.dart';
import 'package:breakq/screens/cart/widgets/cart_icon.dart';
import 'package:breakq/screens/scan/barcode_scanner.dart';
import 'package:breakq/widgets/back_button.dart';
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
  CartEmptyScreen({this.products});
  final List<Product> products;
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
                CartIconPlane(),
                Spacer(),
                Text('My Cart',
                    style: Theme.of(context).textTheme.bodyText1.fs16),
                Spacer(flex: 9),
              ],
            ),
            leading: BackButtonCircle(),
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
                CartFooter(products: products),
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
  CartFooter({this.products});
  final List<Product> products;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // CartRecentlyScanned(products: products),
        if (products?.isNotEmpty ?? false)
          CartSuggestionsBuilder(products: products),
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
        // decoration: BoxDecoration(
        //     image: DecorationImage(
        //         image: AssetImage(AssetImages.banner), fit: BoxFit.fill)),
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
                      color: kWhite,
                    ),
                    Spacer(),
                    BoldTitle(
                      title: "Scan & Add to Cart".toUpperCase(),
                      padding: EdgeInsets.symmetric(horizontal: kPaddingM),
                      color: kWhite,
                      fw: FontWeight.w600,
                    ),
                    Spacer(flex: 9),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: kWhite,
                    ),
                  ],
                ),
              ),
            ]),
      ),
    );
  }
}

class CartQtyDisplay extends StatelessWidget {
  CartQtyDisplay({@required this.items, @required this.qty});
  final int items;
  final int qty;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kWhite,
      padding: const EdgeInsets.symmetric(vertical: kPaddingM),
      child: Table(
        border: TableBorder(
          verticalInside: BorderSide(width: 1.0, color: Colors.black45),
        ),
        children: [
          TableRow(
            children: [
              TableCell(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Items",
                      style: Theme.of(context).textTheme.bodyText1.fs16.w600,
                    ),
                    Text(
                      "$items",
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          .copyWith(color: Colors.black54),
                    ),
                  ],
                ),
              ),
              TableCell(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Quantity",
                      style: Theme.of(context).textTheme.bodyText1.fs16.w600,
                    ),
                    Text(
                      "$qty",
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          .copyWith(color: Colors.black54),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CartSuggestionsBuilder extends StatelessWidget {
  CartSuggestionsBuilder({this.products});
  final List<Product> products;
  @override
  Widget build(BuildContext context) {
    return CartHeading(title: "Suggested For You", children: [
      ProductsHorizontalView(products: products),
    ]);
  }
}

class CartRecentlyScanned extends StatelessWidget {
  CartRecentlyScanned({this.products});
  final List<Product> products;
  @override
  Widget build(BuildContext context) {
    return CartHeading(title: "Recently Scanned", children: [
      ProductsHorizontalView(products: products),
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
