import 'package:breakq/data/models/category_tab_model.dart';
import 'package:breakq/data/models/home_models.dart';
import 'package:breakq/data/models/product_model.dart';
import 'package:breakq/data/models/brand_tab_model.dart';
import 'package:breakq/data/models/toolbar_option_model.dart';
import 'package:flutter/material.dart';

class ProductSessionModel {
  ProductSessionModel({
    this.products,
    this.currentSort,
    this.currentListType,
    this.currentPage = 1,
    this.selectedDateRange = 0,
    this.activeCategoryTab = 0,
    this.activeBrandTab = '0',
    this.range,
    this.isLoading = false,
    this.subCategoryTabs,
    this.brandTabs,
    this.searchSortTypes,
    this.searchListTypes,
    this.offer,
  });

  ProductSessionModel rebuild({
    int currentPage,
    int selectedDateRange,
    ToolbarOptionModel currentSort,
    ToolbarOptionModel currentListType,
    ToolbarOptionModel currentGenderFilter,
    int activeSearchTab,
    String activeBrandTab,
    RangeValues range,
    bool isLoading,
    List<Product> products,
    List<BrandTabModel> brandTabs,
    DealsModel offer,
  }) {
    return ProductSessionModel(
      products: products ?? this.products,
      currentPage: currentPage ?? this.currentPage,
      selectedDateRange: selectedDateRange ?? this.selectedDateRange,
      currentSort: currentSort ?? this.currentSort,
      currentListType: currentListType ?? this.currentListType,
      activeCategoryTab: activeSearchTab ?? this.activeCategoryTab,
      activeBrandTab: activeBrandTab ?? this.activeBrandTab,
      range: range ?? this.range,
      isLoading: isLoading ?? this.isLoading,
      subCategoryTabs: this.subCategoryTabs,
      brandTabs: brandTabs ?? this.brandTabs,
      searchSortTypes: this.searchSortTypes,
      searchListTypes: this.searchListTypes,
      offer: offer ?? this.offer,
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
  final RangeValues range;

  final DealsModel offer;

  final List<Product> products;
}
