import 'package:breakq/data/models/category_tab_model.dart';
import 'package:breakq/data/models/minmax.dart';
import 'package:breakq/data/models/product_model.dart';
import 'package:breakq/data/models/brand_tab_model.dart';
import 'package:breakq/data/models/toolbar_option_model.dart';

class ProductSessionModel {
  ProductSessionModel({
    this.products,
    this.currentSort,
    this.currentListType,
    this.currentPage = 1,
    this.selectedDateRange = 0,
    this.activeCategoryTab = 0,
    this.activeBrandTab = '0',
    this.minMax,
    this.isLoading = false,
    this.subCategoryTabs,
    this.brandTabs,
    this.searchSortTypes,
    this.searchListTypes,
  });

  ProductSessionModel rebuild({
    int currentPage,
    int selectedDateRange,
    ToolbarOptionModel currentSort,
    ToolbarOptionModel currentListType,
    ToolbarOptionModel currentGenderFilter,
    int activeSearchTab,
    String activeBrandTab,
    MinMax minMax,
    bool isLoading,
    List<Product> products,
    List<BrandTabModel> brandTabs,
  }) {
    return ProductSessionModel(
      products: products ?? this.products,
      currentPage: currentPage ?? this.currentPage,
      selectedDateRange: selectedDateRange ?? this.selectedDateRange,
      currentSort: currentSort ?? this.currentSort,
      currentListType: currentListType ?? this.currentListType,
      activeCategoryTab: activeSearchTab ?? this.activeCategoryTab,
      activeBrandTab: activeBrandTab ?? this.activeBrandTab,
      minMax: minMax ?? this.minMax,
      isLoading: isLoading ?? this.isLoading,
      subCategoryTabs: this.subCategoryTabs,
      brandTabs: brandTabs ?? this.brandTabs,
      searchSortTypes: this.searchSortTypes,
      searchListTypes: this.searchListTypes,
    );
  }

  final int currentPage;
  final int selectedDateRange;
  final ToolbarOptionModel currentSort;
  final ToolbarOptionModel currentListType;
  final int activeCategoryTab;
  final String activeBrandTab;
  final bool isLoading;

  final List<CategoryTabModel> subCategoryTabs;
  final List<BrandTabModel> brandTabs;
  final List<ToolbarOptionModel> searchSortTypes;
  final List<ToolbarOptionModel> searchListTypes;
  final MinMax minMax;

  final List<Product> products;
}
