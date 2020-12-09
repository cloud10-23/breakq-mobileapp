import 'package:breakq/data/models/product_model.dart';
import 'package:breakq/data/models/toolbar_option_model.dart';

enum SearchType { full, quick, map }

class SearchSessionModel {
  SearchSessionModel({
    this.products,
    this.currentSort,
    this.currentListType,
    this.q = '',
    this.currentPage = 1,
    this.selectedDateRange = 0,
    this.activeSearchTab = 0,
    this.isLoading = false,
    this.searchType = SearchType.full,
  });

  SearchSessionModel rebuild({
    String q,
    int currentPage,
    int selectedDateRange,
    ToolbarOptionModel currentSort,
    ToolbarOptionModel currentListType,
    ToolbarOptionModel currentGenderFilter,
    int activeSearchTab,
    bool isLoading,
    List<ProductModel> products,
    SearchType searchType,
  }) {
    return SearchSessionModel(
      products: products ?? this.products,
      currentPage: currentPage ?? this.currentPage,
      selectedDateRange: selectedDateRange ?? this.selectedDateRange,
      currentSort: currentSort ?? this.currentSort,
      currentListType: currentListType ?? this.currentListType,
      activeSearchTab: activeSearchTab ?? this.activeSearchTab,
      q: q ?? this.q,
      isLoading: isLoading ?? this.isLoading,
      searchType: searchType ?? this.searchType,
    );
  }

  final String q;
  final int currentPage;
  final int selectedDateRange;
  final ToolbarOptionModel currentSort;
  final ToolbarOptionModel currentListType;
  final int activeSearchTab;
  final bool isLoading;
  final SearchType searchType;

  final List<ProductModel> products;
}
