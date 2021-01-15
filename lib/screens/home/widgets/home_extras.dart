import 'package:breakq/blocs/cart/cart_bloc.dart';
import 'package:breakq/configs/app_globals.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/configs/routes.dart';
import 'package:breakq/data/models/product_model.dart';
import 'package:breakq/main.dart';
import 'package:breakq/screens/listing/widgets/product_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GridImage extends StatelessWidget {
  GridImage({this.colIndex, this.rowIndex, this.height, this.width});
  final int colIndex;
  final int rowIndex;
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, CustomNavigatorRoutes.listing),
      child: Card(
        child: Image(
            height: height,
            width: width,
            image: AssetImage((colIndex == null)
                ? AssetImages.topDeals(rowIndex)
                : AssetImages.topOffers(colIndex, rowIndex)),
            fit: BoxFit.fill),
      ),
    );
  }
}

class ExclProductsCard extends StatelessWidget {
  ExclProductsCard({this.index});
  final int index;

  Product getProduct(int index) {
    return Product(
      id: index + 10,
      image: AssetImages.maggi,
      oldPrice: 60,
      price: 40,
      quantity: '500 gm',
      title: 'Product ${index + 1}',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      padding: EdgeInsets.all(kPaddingM),
      child: ProductListItem(
        viewType: ProductListItemViewType.grid,
        product: Product(
          id: index + 10,
          image: AssetImages.maggi,
          oldPrice: 60,
          price: 40,
          quantity: '500 gm',
          title: 'Product ${index + 1}',
        ),
        onProductAdd: () =>
            getIt.get<AppGlobals>().onProductAdd(getProduct(index), context),
        onProductRem: () =>
            getIt.get<AppGlobals>().onProductRed(getProduct(index), context),
        onProductDel: () =>
            getIt.get<AppGlobals>().onProductDel(getProduct(index), context),
        onProductPressed: () => getIt
            .get<AppGlobals>()
            .onProductPressed(getProduct(index), context),
      ),
    );
  }
}
