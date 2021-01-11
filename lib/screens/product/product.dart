import 'package:breakq/blocs/cart/cart_bloc.dart';
import 'package:breakq/configs/app_globals.dart';
import 'package:breakq/main.dart';
import 'package:breakq/screens/listing/widgets/product_cart_buttons.dart';
import 'package:breakq/screens/product/widgets/product_buttons.dart';
import 'package:breakq/widgets/bold_title.dart';
import 'package:breakq/widgets/list_item.dart';
import 'package:breakq/widgets/theme_button.dart';
import 'package:flutter/material.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/data/models/product_model.dart';
import 'package:breakq/generated/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sprintf/sprintf.dart';
import 'package:breakq/utils/text_style.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({
    Key key,
    this.product,
  }) : super(key: key);

  final Product product;

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  /// The GlobalKey needed to access Scaffold widget.
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.product != null) {
      return BlocBuilder<CartBloc, CartState>(
          buildWhen: (previous, current) => current is CartLoaded,
          builder: (context, state) {
            int qty = 0;
            if (state is CartLoaded) {
              state.cart.cartItems.forEach((item) {
                if (widget.product.id == item.product.id) {
                  qty = item.quantity;
                }
              });
            }
            return Scaffold(
              key: _scaffoldKey,
              backgroundColor: Theme.of(context).cardColor,
              body: Padding(
                padding: const EdgeInsets.all(kPaddingL),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Row(
                      children: [
                        Spacer(flex: 3),
                        Flexible(
                          child: Container(
                            height: 2,
                            decoration: BoxDecoration(
                              color: getIt
                                      .get<AppGlobals>()
                                      .isPlatformBrightnessDark
                                  ? Theme.of(context).scaffoldBackgroundColor
                                  : Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(width: 1),
                            ),
                          ),
                        ),
                        Spacer(flex: 3),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Flexible(
                      child: Image(
                          image: AssetImage(widget.product.image), height: 150),
                    ),
                    VeryBoldTitle(title: widget.product.title),
                    ListItem(
                      title: "Quantity: ",
                      trailing: Text(
                        sprintf('%s', <String>[widget.product.quantity]),
                        maxLines: 1,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            .copyWith(color: Theme.of(context).hintColor),
                      ),
                    ),
                    SizedBox(height: kPaddingL),
                    ListItem(
                      title: "Price / Unit: ",
                      trailing: Row(
                        children: <Widget>[
                          Text(
                            "₹ " + widget.product.price.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                .bold
                                .copyWith(color: Theme.of(context).hintColor),
                          ),
                          SizedBox(width: 5),
                          Text(
                            "₹ " + widget.product.oldPrice.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2
                                .w300
                                .copyWith(
                                  decoration: TextDecoration.lineThrough,
                                  color: Theme.of(context).hintColor,
                                ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: kPaddingL),
                    if (qty <= 0)
                      ListItem(
                        showBorder: false,
                        title: "Item Count: \n",
                        trailing: ListAddItemButton(
                          onProductAdd: () => AppGlobals.instance
                              .onProductAdd(widget.product, context),
                        ),
                        // subtitleWidget: ResetCartButtonText(
                        //   onProductDel: () => AppGlobals.instance
                        //       .onProductDel(widget.product, context),
                        // ),
                        thirdRow: BulkAddButtons(product: widget.product),
                      )
                    else
                      ListItem(
                        showBorder: false,
                        title: "Item Count: \n",
                        subtitleWidget: Row(
                          children: [
                            ResetCartButtonText(
                              onProductDel: () => AppGlobals.instance
                                  .onProductDel(widget.product, context),
                            ),
                            Spacer(),
                            ListAddRemButtons(
                              onAdd: () => AppGlobals.instance
                                  .onProductAdd(widget.product, context),
                              onRem: () => AppGlobals.instance
                                  .onProductRed(widget.product, context),
                              qty: qty,
                            ),
                          ],
                        ),
                        thirdRow: BulkAddButtons(product: widget.product),
                      ),
                  ],
                ),
              ),
              bottomNavigationBar: _bottomBar(qty),
            );
          });
    } else
      return Container();
  }

  Widget _bottomBar(int qty) {
    if (widget.product == null) {
      return Container();
    }

    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: kPaddingL, vertical: kPaddingM),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          VeryBoldTitle(
            title: "Sub Total: ",
            fw: FontWeight.w500,
          ),
          VeryBoldTitle(
              title: "₹ ${(widget.product.price * qty).toStringAsFixed(2)}"),
        ],
      ),
    );
  }
}
