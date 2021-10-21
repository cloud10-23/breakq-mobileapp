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
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ProductListing extends StatefulWidget {
  ProductListing({
    Key key,
    this.products,
    this.currentListType,
    this.isLoading = false,
    this.onNextPage,
  }) : super(key: key);

  final List<Product> products;
  final ToolbarOptionModel currentListType;
  final bool isLoading;
  final Future<List<Product>> Function(int) onNextPage;

  @override
  _ProductListingState createState() => _ProductListingState();
}

class _ProductListingState extends State<ProductListing> {
  static const _pageSize = 25;

  final PagingController<int, Product> _pagingController =
      PagingController(firstPageKey: 1);

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = <Product>[];
      if (pageKey == 1) {
        newItems.addAll(widget.products);
      } else {
        newItems.addAll(await widget.onNextPage(pageKey));
      }

      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  void initState() {
    super.initState();

    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultListType = ToolbarOptionModel.fromJson(listTypes[0]);

    final ProductListItemViewType _viewType = ProductListItemViewType.values
        .firstWhere((ProductListItemViewType e) =>
            describeEnum(e) ==
            (widget.currentListType?.code ?? defaultListType.code));

    /// If the state is loading state
    if (widget.isLoading)
      return SliverToBoxAdapter(
        child: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: kPaddingM, vertical: kPaddingM),
          child: Wrap(
            runSpacing: 1.0,
            alignment: WrapAlignment.start,
            children: List.generate(9, (index) {
              switch (_viewType) {
                case ProductListItemViewType.grid:
                  return FractionallySizedBox(
                    widthFactor: 1 / 3,
                    child: ShimmerBox(height: 224),
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
        ),
      );

    if (widget.products?.isEmpty ?? true) {
      return SliverToBoxAdapter(child: NoProducts());
    }

    switch (_viewType) {
      case ProductListItemViewType.grid:
        return PagedSliverGrid(
          pagingController: _pagingController,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: (MediaQuery.of(context).size.width / 3) / 224),
          builderDelegate: PagedChildBuilderDelegate<Product>(
            itemBuilder: (context, item, index) => ProductListItem(
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
          ),
        );
        break;
      default:
        return PagedSliverList(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate(
            itemBuilder: (context, item, index) => ProductListItem(
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
          ),
        );
    }
  }
}
