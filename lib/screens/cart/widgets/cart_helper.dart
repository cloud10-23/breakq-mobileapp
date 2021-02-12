import 'package:breakq/blocs/cart/cart_bloc.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/data/models/price_model.dart';
import 'package:breakq/screens/scan/barcode_scanner.dart';
import 'package:breakq/widgets/bold_title.dart';
import 'package:breakq/widgets/horizontal_products.dart';
import 'package:breakq/widgets/list_item.dart';
import 'package:flutter/material.dart';
import 'package:breakq/utils/text_style.dart';

class CartHeading extends StatelessWidget {
  CartHeading({@required this.title, @required this.children});

  final String title;
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
        children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(kPaddingM),
                child: BoldTitle(
                  title: title.toUpperCase(),
                  padding: EdgeInsets.symmetric(horizontal: kPaddingM),
                  color: Colors.black54,
                  fw: FontWeight.w600,
                ),
              ),
              Container(
                height: 0.5,
                color: Colors.black12,
              ),
              SizedBox(height: 5),
            ] +
            children,
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

class PriceDetails extends StatelessWidget {
  PriceDetails({@required this.price});

  final Price price;
  @override
  Widget build(BuildContext context) {
    return CartHeading(
      title: 'PRICE DETAILS',
      children: [
        Padding(
          padding: const EdgeInsets.all(kPaddingM),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BoldTitle(
                title: 'Price: ',
                padding: EdgeInsets.symmetric(horizontal: kPaddingM),
                color: Colors.black,
                fw: FontWeight.w600,
              ),
              BoldTitle(
                title: '₹ ' + (price?.price?.toStringAsFixed(2) ?? "00.00"),
                padding: EdgeInsets.symmetric(horizontal: kPaddingM),
                color: Colors.black87,
                fw: FontWeight.w500,
                isNum: true,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(kPaddingM),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BoldTitle(
                title: 'Discount: ',
                padding: EdgeInsets.symmetric(horizontal: kPaddingM),
                color: kGreen,
                fw: FontWeight.w600,
              ),
              BoldTitle(
                title: '- ₹ ' + (price?.discount ?? 0)?.toStringAsFixed(2) ??
                    "00.00",
                padding: EdgeInsets.symmetric(horizontal: kPaddingM),
                color: Colors.green[800],
                isNum: true,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(kPaddingM),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BoldTitle(
                title: 'Extra offer: ',
                padding: EdgeInsets.symmetric(horizontal: kPaddingM),
                color: kGreen,
                fw: FontWeight.w600,
              ),
              BoldTitle(
                title: '- ₹ ' + (price.extraOffer).toStringAsFixed(2),
                padding: EdgeInsets.symmetric(horizontal: kPaddingM),
                color: kGreen,
                isNum: true,
              ),
            ],
          ),
        ),
        Container(
          height: 0.5,
          color: Colors.black12,
        ),
        Padding(
          padding: const EdgeInsets.all(kPaddingM),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BoldTitle(
                title: 'Total Amount:',
                fw: FontWeight.w800,
              ),
              CustomTitle(
                title: '₹ ' + (price.totalAmnt).toStringAsFixed(2),
                fw: FontWeight.w700,
                isNum: true,
              ),
            ],
          ),
        ),
        Container(
          height: 0.5,
          color: Colors.black12,
        ),
        Padding(
          padding: const EdgeInsets.all(kPaddingS),
          child: BoldTitle(
            title: 'You have saved ₹ ' +
                ((price.savings ?? 0)?.toStringAsFixed(2) ?? "00.00") +
                ' on this order',
            fw: FontWeight.w800,
            color: kGreen,
          ),
        ),
      ],
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
