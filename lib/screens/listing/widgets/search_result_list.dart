import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/data/models/product_model.dart';
import 'package:breakq/data/models/toolbar_option_model.dart';
import 'package:breakq/generated/l10n.dart';
import 'package:breakq/widgets/jumbotron.dart';
import 'package:breakq/screens/listing/widgets/product_list_item.dart';

class SearchResultList extends StatelessWidget {
  const SearchResultList({
    Key key,
    this.products,
    this.currentListType,
  }) : super(key: key);

  final List<ProductModel> products;
  final ToolbarOptionModel currentListType;

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
      padding: const EdgeInsets.only(
          left: kPaddingM, top: kPaddingM, bottom: kPaddingM),
      child: Wrap(
        runSpacing: kPaddingS,
        alignment: WrapAlignment.spaceBetween,
        children: products.map((ProductModel item) {
          switch (_viewType) {
            case ProductListItemViewType.grid:
              return Padding(
                padding: const EdgeInsets.fromLTRB(
                    kPaddingM, kPaddingL, kPaddingM, 0),
                child: FractionallySizedBox(
                  widthFactor: 0.30,
                  child: Container(
                    padding: const EdgeInsets.only(right: kPaddingS),
                    child: ProductListItem(
                      product: item,
                      viewType: _viewType,
                    ),
                  ),
                ),
              );
              break;
            default:
              return Container(
                padding: const EdgeInsets.only(right: kPaddingM),
                child: ProductListItem(
                  product: item,
                  viewType: _viewType,
                ),
              );
          }
        }).toList(),
      ),
    );
  }
}
