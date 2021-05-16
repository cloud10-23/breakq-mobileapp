import 'package:breakq/data/models/product_model.dart';
import 'package:breakq/data/models/toolbar_option_model.dart';

class SearchSessionModel {
  SearchSessionModel({
    this.products,
    this.currentSort,
    this.currentListType,
    this.query = '',
    this.currentPage = 1,
    this.isLoading = false,
    this.searchSortTypes,
    this.searchListTypes,
  });

  SearchSessionModel rebuild({
    String query,
    int currentPage,
    int selectedDateRange,
    ToolbarOptionModel currentSort,
    ToolbarOptionModel currentListType,
    bool isLoading,
    List<Product> products,
  }) {
    return SearchSessionModel(
      products: products ?? this.products,
      currentPage: currentPage ?? this.currentPage,
      currentSort: currentSort ?? this.currentSort,
      currentListType: currentListType ?? this.currentListType,
      query: query ?? this.query,
      isLoading: isLoading ?? this.isLoading,
      searchSortTypes: this.searchSortTypes,
      searchListTypes: this.searchListTypes,
    );
  }

  final String query;
  final int currentPage;
  final ToolbarOptionModel currentSort;
  final ToolbarOptionModel currentListType;
  final bool isLoading;

  final List<ToolbarOptionModel> searchSortTypes;
  final List<ToolbarOptionModel> searchListTypes;

  final List<Product> products;
}
