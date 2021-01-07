import 'package:breakq/blocs/cart/cart_bloc.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/data/models/product_model.dart';
import 'package:breakq/screens/listing/widgets/product_list_item.dart';
import 'package:flutter/material.dart';
import 'package:breakq/utils/text_style.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopDealsCard extends StatelessWidget {
  TopDealsCard({this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: Card(
        // shape: RoundedRectangleBorder(),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Image(
                  image: AssetImage(categories[index]['image']),
                  fit: BoxFit.fill),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(categories[index]['name'],
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText2.bold),
            SizedBox(
              height: 5.0,
            ),
          ],
        ),
      ),
    );
  }
}

class ExclProductsCard extends StatelessWidget {
  ExclProductsCard({this.index});
  final int index;

  ProductModel getProduct(int index) {
    return ProductModel(
      id: index + 10,
      image: AssetImages.maggi,
      price: 40,
      quantity: '500 gm',
      title: 'Product ${index + 1}',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: EdgeInsets.all(kPaddingM),
      child: ProductListItem(
        viewType: ProductListItemViewType.grid,
        product: ProductModel(
          id: index + 10,
          image: AssetImages.maggi,
          price: 40,
          quantity: '500 gm',
          title: 'Product ${index + 1}',
        ),
        onProductAdd: () {
          BlocProvider.of<CartBloc>(context)
              .add(AddPToCartEvent(product: getProduct(index)));
        },
        onProductRem: () {
          BlocProvider.of<CartBloc>(context)
              .add(RemovePFromCartEvent(product: getProduct(index)));
        },
        onProductPressed:
            () {}, //BlocProvider.of<CartBloc>(context).add(AddPToCartEvent(product: product)),
      ),
    );
  }
}
