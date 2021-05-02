import 'package:breakq/data/models/category_tab_model.dart';
import 'package:breakq/data/models/product_model.dart';
import 'package:breakq/data/models/brand_tab_model.dart';
import 'package:breakq/data/models/toolbar_option_model.dart';

enum SearchType { full, quick, map }

class ProductSessionModel {
  ProductSessionModel({
    this.products,
    this.currentSort,
    this.currentListType,
    this.q = '',
    this.currentPage = 1,
    this.selectedDateRange = 0,
    this.activeCategoryTab = 0,
    this.activeBrandTab = '0',
    this.isLoading = false,
    this.searchType = SearchType.full,
    this.categoryTabs,
    this.brandTabs,
    this.searchSortTypes,
    this.searchListTypes,
  });

  ProductSessionModel rebuild({
    String q,
    int currentPage,
    int selectedDateRange,
    ToolbarOptionModel currentSort,
    ToolbarOptionModel currentListType,
    ToolbarOptionModel currentGenderFilter,
    int activeSearchTab,
    String activeBrandTab,
    bool isLoading,
    List<Product> products,
    SearchType searchType,
  }) {
    return ProductSessionModel(
      products: products ?? this.products,
      currentPage: currentPage ?? this.currentPage,
      selectedDateRange: selectedDateRange ?? this.selectedDateRange,
      currentSort: currentSort ?? this.currentSort,
      currentListType: currentListType ?? this.currentListType,
      activeCategoryTab: activeSearchTab ?? this.activeCategoryTab,
      activeBrandTab: activeBrandTab ?? this.activeBrandTab,
      q: q ?? this.q,
      isLoading: isLoading ?? this.isLoading,
      searchType: searchType ?? this.searchType,
      categoryTabs: this.categoryTabs,
      brandTabs: this.brandTabs,
      searchSortTypes: this.searchSortTypes,
      searchListTypes: this.searchListTypes,
    );
  }

  final String q;
  final int currentPage;
  final int selectedDateRange;
  final ToolbarOptionModel currentSort;
  final ToolbarOptionModel currentListType;
  final int activeCategoryTab;
  final String activeBrandTab;
  final bool isLoading;
  final SearchType searchType;

  final List<CategoryTabModel> categoryTabs;
  final List<BrandTabModel> brandTabs;
  final List<ToolbarOptionModel> searchSortTypes;
  final List<ToolbarOptionModel> searchListTypes;

  final List<Product> products;
}
