import 'package:breakq/configs/app_globals.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/data/models/product_model.dart';
import 'package:breakq/data/models/toolbar_option_model.dart';
import 'package:breakq/generated/l10n.dart';
import 'package:breakq/widgets/jumbotron.dart';
import 'package:breakq/screens/listing/widgets/product_list_item.dart';

class SearchResultList extends StatelessWidget {
  SearchResultList({
    Key key,
    this.products,
    this.currentListType,
    // onProductPressed,
    // onProductAdd,
    // onProductRed,
    // onProductDel,
    // })  : this.onProductPressed =
    //           onProductPressed ?? AppGlobals.instance.onProductPressed,
    //       this.onProductAdd = onProductAdd ?? AppGlobals.instance.onProductAdd,
    //       this.onProductRed = onProductRed ?? AppGlobals.instance.onProductRed,
    //       this.onProductDel = onProductDel ?? AppGlobals.instance.onProductDel,
  }) : super(key: key);

  final List<Product> products;
  final ToolbarOptionModel currentListType;
  // final Function(Product, BuildContext) onProductPressed;
  // final Function(Product, BuildContext) onProductAdd;
  // final Function(Product, BuildContext) onProductRed;
  // final Function(Product, BuildContext) onProductDel;

  @override
  Widget build(BuildContext context) {
    if (products?.isEmpty ?? true) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 3 * kPaddingM),
        child: Column(
          children: <Widget>[
            Jumbotron(
              title: L10n.of(context).searchTitleNoResults.toUpperCase(),
              icon: Icons.info_outline,
            ),
            Text(
              L10n.of(context).locationNoResults,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  .copyWith(color: Theme.of(context).disabledColor),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    final ProductListItemViewType _viewType = ProductListItemViewType.values
        .firstWhere((ProductListItemViewType e) =>
            describeEnum(e) == currentListType.code);

    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: kPaddingS, vertical: kPaddingM),
      child: Wrap(
        runSpacing: kPaddingM,
        alignment: WrapAlignment.spaceBetween,
        children: products.map((Product item) {
          switch (_viewType) {
            case ProductListItemViewType.grid:
              return FractionallySizedBox(
                widthFactor: 0.30,
                child: ProductListItem(
                  product: item,
                  viewType: _viewType,
                  onProductPressed: () =>
                      AppGlobals.instance.onProductPressed(item, context),
                  onProductAdd: () =>
                      AppGlobals.instance.onProductAdd(item, context),
                  onProductRem: () =>
                      AppGlobals.instance.onProductRed(item, context),
                  onProductDel: () =>
                      AppGlobals.instance.onProductDel(item, context),
                ),
              );
              break;
            default:
              return ProductListItem(
                product: item,
                viewType: _viewType,
                onProductPressed: () =>
                    AppGlobals.instance.onProductPressed(item, context),
                onProductAdd: () =>
                    AppGlobals.instance.onProductAdd(item, context),
                onProductRem: () =>
                    AppGlobals.instance.onProductRed(item, context),
                onProductDel: () =>
                    AppGlobals.instance.onProductDel(item, context),
              );
          }
        }).toList(),
      ),
    );
  }
}
