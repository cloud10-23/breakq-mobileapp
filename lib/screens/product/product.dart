import 'package:breakq/blocs/cart/cart_bloc.dart';
import 'package:breakq/blocs/product/product_bloc.dart';
import 'package:breakq/configs/api_urls.dart';
import 'package:breakq/configs/app_globals.dart';
import 'package:breakq/main.dart';
import 'package:breakq/screens/cart/widgets/cart_icon.dart';
import 'package:breakq/screens/listing/widgets/product_cart_buttons.dart';
import 'package:breakq/screens/product/widgets/product_buttons.dart';
import 'package:breakq/widgets/back_button.dart';
import 'package:breakq/widgets/bold_title.dart';
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
                leading: BackButtonCircle(),
                actions: [
                  CartIconButton(),
                ],
              ),
              body: ListView(
                children: [
                  CachedNetworkImage(
                    // cacheManager: AppCacheManager.instance,
                    height: 250,
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
                      fit: BoxFit.cover,
                      height: 250,
                    ),
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 40.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.product.title,
                        style:
                            Theme.of(context).textTheme.headline6.number.w800,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(width: 20),
                      OfferTextGreen(20),
                    ],
                  ),
                  SizedBox(height: 40.0),
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
                    title: "MRP: ",
                    trailing: Text(
                      "₹ " + widget.product.maxPrice.toStringAsFixed(2),
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1
                          .bold
                          .number
                          .copyWith(color: Theme.of(context).hintColor),
                    ),
                  ),
                  ListItem(
                    title: "Sale Price: ",
                    trailing: Text(
                      "₹ " + widget.product.salePrice.toStringAsFixed(2),
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1
                          .bold
                          .number
                          .copyWith(color: Theme.of(context).hintColor),
                    ),
                  ),
                  SizedBox(height: 40.0),
                  BlocBuilder<ProductBloc, ProductState>(
                    bloc: productBloc,
                    builder: (context, state) {
                      if (state is! RefreshSuccessProductState) {
                        return Container();
                      }
                      final _products = (state as RefreshSuccessProductState)
                          .session
                          .products;
                      return HomeBoldHeading(
                        title: "Related Products",
                        icon: Icon(
                          MaterialCommunityIcons.ticket_percent,
                          color: kWhite,
                        ),
                        isBlue: true,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          ProductsHorizontalView(products: _products),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      );
                    },
                  ),
                  if (_recentlyScanned != null && _recentlyScanned.isNotEmpty)
                    SizedBox(height: 40.0),
                  if (_recentlyScanned != null && _recentlyScanned.isNotEmpty)
                    HomeBoldHeading(
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomTitle(
                    title: "Sub Total: ",
                    fw: FontWeight.w500,
                  ),
                  CustomTitle(
                    title:
                        "₹ ${(widget.product.maxPrice * qty).toStringAsFixed(2)}",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
