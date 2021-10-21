import 'package:breakq/blocs/cart/cart_bloc.dart';
import 'package:breakq/blocs/product/product_bloc.dart';
import 'package:breakq/configs/api_urls.dart';
import 'package:breakq/configs/app_globals.dart';
import 'package:breakq/main.dart';
import 'package:breakq/screens/cart/widgets/cart_icon.dart';
import 'package:breakq/screens/listing/widgets/product_cart_buttons.dart';
import 'package:breakq/screens/product/widgets/product_buttons.dart';
import 'package:breakq/widgets/back_button.dart';
import 'package:breakq/widgets/card_template.dart';
import 'package:breakq/widgets/horizontal_products.dart';
import 'package:breakq/widgets/list_item.dart';
import 'package:breakq/widgets/offer_widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/data/models/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
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
  ProductBloc productBloc;
  @override
  void initState() {
    super.initState();
    productBloc = ProductBloc()
      ..add(FetchRelatedProducts(productCode: widget.product?.id?.toString()));
  }

  @override
  Widget build(BuildContext context) {
    if (widget.product != null) {
      return BlocBuilder<CartBloc, CartState>(
          buildWhen: (previous, current) => current is CartLoaded,
          builder: (context, state) {
            int qty = 0;
            final _recentlyScanned = <Product>[];
            if (state is CartLoaded) {
              qty = state?.cart?.cartItems[widget.product] ?? 0;
              _recentlyScanned.clear();
              _recentlyScanned.addAll(state.recentlyScanned);
            }
            return Scaffold(
              backgroundColor: Theme.of(context).cardColor,
              appBar: AppBar(
                title: Text(
                  widget.product.title ?? "Product Details",
                  style: TextStyle(color: kWhite),
                ),
                leading: BackButtonCircle(),
                actions: [
                  CartIconButton(),
                ],
              ),
              body: ListView(
                children: [
                  Card(
                    margin: const EdgeInsets.symmetric(horizontal: kPaddingM),
                    elevation: 2.0,
                    child: Padding(
                      padding: const EdgeInsets.all(kPaddingL),
                      child: Column(
                        children: [
                          CachedNetworkImage(
                            // cacheManager: AppCacheManager.instance,
                            height: 200,
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
                              height: 200,
                            ),
                            fit: BoxFit.contain,
                          ),
                          SizedBox(height: kPaddingL),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                widget.product.title,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .number
                                    .w800,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(width: 20),
                              OfferTextGreenAlt(20),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  // BoldTitle(
                  //   title: widget.product.description ?? "",
                  //   fw: FontWeight.w500,
                  // ),
                  Card(
                    margin: const EdgeInsets.symmetric(horizontal: kPaddingM),
                    elevation: 2.0,
                    child: Padding(
                      padding: const EdgeInsets.all(kPaddingL),
                      child: Column(
                        children: [
                          ListItem(
                            title: "Quantity: ",
                            trailing: Padding(
                              padding: const EdgeInsets.only(right: kPaddingL),
                              child: Text(
                                sprintf(
                                    '%s', <String>[widget.product.quantity]),
                                maxLines: 1,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    .copyWith(
                                        color: Theme.of(context).hintColor),
                              ),
                            ),
                          ),
                          ListItem(
                            title: "MRP: ",
                            trailing: Padding(
                              padding: const EdgeInsets.only(right: kPaddingL),
                              child: Text(
                                "₹ " +
                                    widget.product.maxPrice.toStringAsFixed(2),
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    .bold
                                    .number
                                    .copyWith(
                                        color: Theme.of(context).hintColor),
                              ),
                            ),
                          ),
                          ListItem(
                            title: "Sale Price: ",
                            trailing: Padding(
                              padding: const EdgeInsets.only(right: kPaddingL),
                              child: Text(
                                "₹ " +
                                    widget.product.salePrice.toStringAsFixed(2),
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    .bold
                                    .number
                                    .copyWith(
                                        color: Theme.of(context).hintColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  BlocBuilder<ProductBloc, ProductState>(
                    bloc: productBloc,
                    builder: (context, state) {
                      if (state is! RefreshSuccessProductState) {
                        return Container();
                      }
                      final _products = (state as RefreshSuccessProductState)
                          .session
                          .products;
                      return Card(
                        elevation: 2.0,
                        margin:
                            const EdgeInsets.symmetric(horizontal: kPaddingM),
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: kPaddingS, bottom: kPaddingS),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(kPaddingM),
                                  child: Row(
                                    children: [
                                      Icon(
                                        MaterialCommunityIcons.ticket_percent,
                                      ),
                                      SizedBox(width: 5.0),
                                      Text(
                                        "Related Products",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            .w700
                                            .copyWith(
                                              color: kBlack,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                ProductsHorizontalView(products: _products),
                                SizedBox(
                                  height: 10,
                                ),
                              ]),
                        ),
                      );
                    },
                  ),
                  if (_recentlyScanned != null && _recentlyScanned.isNotEmpty)
                    SizedBox(height: 5.0),
                  if (_recentlyScanned != null && _recentlyScanned.isNotEmpty)
                    Card(
                      elevation: 2.0,
                      margin: const EdgeInsets.symmetric(horizontal: kPaddingM),
                      child: Padding(
                        padding:
                            EdgeInsets.only(left: kPaddingS, bottom: kPaddingS),
                        child: HomeBoldHeading(
                          title: "Recently Scanned",
                          icon: Icon(
                            MaterialCommunityIcons.barcode_scan,
                          ),
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            ProductsHorizontalView(products: _recentlyScanned),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
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
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black38,
            blurRadius: 15,
          ),
        ],
      ),
      child: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: kPaddingL, vertical: kPaddingM),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (qty > 0)
                Row(
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
              if (qty > 0)
                Row(
                  children: [
                    BulkAddButtons(
                      product: widget.product,
                      onPressed: (qty) => getIt
                          .get<AppGlobals>()
                          .onProductAdd(widget.product, context, qty: qty),
                    ),
                  ],
                )
              else
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: BulkAddButtons(
                        product: widget.product,
                        onPressed: (qty) => getIt
                            .get<AppGlobals>()
                            .onProductAdd(widget.product, context, qty: qty),
                      ),
                    ),
                    ListAddItemButton(
                      onProductAdd: () => getIt
                          .get<AppGlobals>()
                          .onProductAdd(widget.product, context),
                    ),
                  ],
                ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: kPaddingM, vertical: kPaddingL),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Sub Total: ",
                      style: Theme.of(context).textTheme.bodyText1.w500,
                    ),
                    Text(
                      "₹ ${(widget.product.maxPrice * qty).toStringAsFixed(2)}",
                      style: Theme.of(context).textTheme.bodyText1.w800.number,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
