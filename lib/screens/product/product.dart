import 'package:breakq/blocs/cart/cart_bloc.dart';
import 'package:breakq/configs/api_urls.dart';
import 'package:breakq/configs/app_globals.dart';
import 'package:breakq/main.dart';
import 'package:breakq/screens/listing/widgets/product_cart_buttons.dart';
import 'package:breakq/screens/product/widgets/product_buttons.dart';
import 'package:breakq/widgets/bold_title.dart';
import 'package:breakq/widgets/list_item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/data/models/product_model.dart';
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
              qty = state?.cart?.cartItems[widget.product] ?? 0;
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
                      child: CachedNetworkImage(
                        // cacheManager: AppCacheManager.instance,
                        imageUrl: apiBaseFull + widget.product.image,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(
                                value: downloadProgress.progress)
                          ],
                        ),
                        errorWidget: (context, url, error) => Image.asset(
                          AssetImages.productPlaceholder,
                          fit: BoxFit.contain,
                        ),
                        fit: BoxFit.contain,
                      ),
                    ),
                    Text(
                      widget.product.title,
                      style: Theme.of(context).textTheme.headline6.number.w800,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                    // BoldTitle(
                    //   title: widget.product.description ?? "",
                    //   fw: FontWeight.w500,
                    // ),
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
                    ListItem(
                      title: "Price / Unit: ",
                      trailing: Row(
                        children: <Widget>[
                          Text(
                            "₹ " + widget.product.maxPrice.toStringAsFixed(2),
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                .bold
                                .number
                                .copyWith(color: Theme.of(context).hintColor),
                          ),
                          SizedBox(width: 5),
                          Visibility(
                            visible: widget.product.maxPrice !=
                                widget.product.salePrice,
                            child: Text(
                              "₹ " +
                                  widget.product.salePrice.toStringAsFixed(2),
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  .w300
                                  .number
                                  .copyWith(
                                    decoration: TextDecoration.lineThrough,
                                    color: Theme.of(context).hintColor,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (qty <= 0)
                      ListItem(
                        showBorder: false,
                        title: "Item Count: \n",
                        trailing: ListAddItemButton(
                          onProductAdd: () => getIt
                              .get<AppGlobals>()
                              .onProductAdd(widget.product, context),
                        ),
                        // subtitleWidget: ResetCartButtonText(
                        //   onProductDel: () => getIt.get<AppGlobals>()
                        //       .onProductDel(widget.product, context),
                        // ),
                        thirdRow: BulkAddButtons(
                          product: widget.product,
                          onPressed: (qty) => getIt
                              .get<AppGlobals>()
                              .onProductAdd(widget.product, context, qty: qty),
                        ),
                      )
                    else
                      ListItem(
                        showBorder: false,
                        title: "Item Count: \n",
                        subtitleWidget: Row(
                          children: [
                            ResetCartButtonText(
                              onProductDel: () => getIt
                                  .get<AppGlobals>()
                                  .onProductDel(widget.product, context),
                            ),
                            Spacer(),
                            ListAddRemButtons(
                              onAdd: () => getIt
                                  .get<AppGlobals>()
                                  .onProductAdd(widget.product, context),
                              onRem: () => getIt
                                  .get<AppGlobals>()
                                  .onProductRed(widget.product, context),
                              qty: qty,
                            ),
                          ],
                        ),
                        thirdRow: BulkAddButtons(
                          product: widget.product,
                          onPressed: (qty) => getIt
                              .get<AppGlobals>()
                              .onProductAdd(widget.product, context, qty: qty),
                        ),
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
          CustomTitle(
            title: "Sub Total: ",
            fw: FontWeight.w500,
          ),
          CustomTitle(
              title: "₹ ${(widget.product.maxPrice * qty).toStringAsFixed(2)}"),
        ],
      ),
    );
  }
}
