import 'package:breakq/configs/app_globals.dart';
import 'package:breakq/configs/routes.dart';
import 'package:breakq/main.dart';
import 'package:breakq/widgets/no_products.dart';
import 'package:breakq/widgets/shimmer_box.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/data/models/product_model.dart';
import 'package:breakq/data/models/toolbar_option_model.dart';
import 'package:breakq/screens/listing/widgets/product_list_item.dart';

class ProductListing extends StatelessWidget {
  ProductListing({
    Key key,
    this.products,
    this.currentListType,
    this.isLoading = false,
  }) : super(key: key);

  final List<Product> products;
  final ToolbarOptionModel currentListType;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final defaultListType = ToolbarOptionModel.fromJson(listTypes[0]);

    final ProductListItemViewType _viewType = ProductListItemViewType.values
        .firstWhere((ProductListItemViewType e) =>
            describeEnum(e) == (currentListType?.code ?? defaultListType.code));

    /// If the state is loading state
    if (isLoading)
      return Container(
        padding: const EdgeInsets.symmetric(
            horizontal: kPaddingM, vertical: kPaddingM),
        child: Wrap(
          runSpacing: 1.0,
          alignment: WrapAlignment.start,
          children: List.generate(12, (index) {
            switch (_viewType) {
              case ProductListItemViewType.grid:
                return FractionallySizedBox(
                  widthFactor: 0.25,
                  child: ShimmerBox(height: 200),
                );
                break;
              default:
                return Padding(
                  padding: const EdgeInsets.all(kPaddingS),
                  child: ShimmerBox(height: 70),
                );
            }
          }),
        ),
      );

    if (products?.isEmpty ?? true) {
      return NoProducts();
    }

    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: kPaddingM, vertical: kPaddingM),
      child: Wrap(
        runSpacing: 1.0,
        alignment: WrapAlignment.start,
        children: products.map((Product item) {
          switch (_viewType) {
            case ProductListItemViewType.grid:
              return FractionallySizedBox(
                widthFactor: 0.25,
                child: ProductListItem(
                  product: item,
                  viewType: _viewType,
                  onProductPressed: () => Navigator.of(context)
                      .pushNamed(Routes.product, arguments: item),
                  onProductAdd: () =>
                      getIt.get<AppGlobals>().onProductAdd(item, context),
                  onProductRem: () =>
                      getIt.get<AppGlobals>().onProductRed(item, context),
                  onProductDel: () =>
                      getIt.get<AppGlobals>().onProductDel(item, context),
                ),
              );
              break;
            default:
              return ProductListItem(
                product: item,
                viewType: _viewType,
                onProductPressed: () => Navigator.of(context)
                    .pushNamed(Routes.product, arguments: item),
                onProductAdd: () =>
                    getIt.get<AppGlobals>().onProductAdd(item, context),
                onProductRem: () =>
                    getIt.get<AppGlobals>().onProductRed(item, context),
                onProductDel: () =>
                    getIt.get<AppGlobals>().onProductDel(item, context),
              );
          }
        }).toList(),
      ),
    );
  }
}
