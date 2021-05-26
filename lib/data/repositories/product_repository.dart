import 'package:breakq/configs/api_urls.dart';
import 'package:breakq/data/data_provider.dart';
import 'package:breakq/data/models/brand_tab_model.dart';
import 'package:breakq/data/models/category_model.dart';
import 'package:breakq/data/models/category_tab_model.dart';
import 'package:breakq/data/models/product_model.dart';
import 'package:breakq/data/models/search_history_model.dart';
import 'package:flutter/cupertino.dart';

class ProductsRepository {
  const ProductsRepository({
    this.dataProvider = const DataProvider(),
  });

  final DataProvider dataProvider;

  Future<List<CategoryTabModel>> getCategoryTabs() async {
    final Uri uri = Uri.http(apiBase, apiCategory);

    final List<dynamic> _rawList = await dataProvider.get(uri);

    /// 1. Populate all the sub categories
    List<CategoryModel> _categories = _rawList
        .map<CategoryModel>((dynamic json) =>
            CategoryModel.fromJson(json as Map<String, dynamic>))
        .toList();

    /// 2. Map all sub categories to their tabs
    return _categories
        .map<CategoryTabModel>((category) =>
            CategoryTabModel(category, GlobalKey(debugLabel: category.title)))
        .toList();
  }

  Future<List<CategoryTabModel>> getSubCategoryTabs(int category) async {
    final Uri uri =
        Uri.http(apiBase, apiCategory, {apiCategoryQuery: category.toString()});

    final List<dynamic> _rawList = await dataProvider.get(uri);

    /// 1. Populate all the sub categories
    List<CategoryModel> _subCategories = _rawList
        .map<CategoryModel>((dynamic json) =>
            CategoryModel.fromJson(json as Map<String, dynamic>))
        .toList();

    /// 2. Map all sub categories to their tabs
    return _subCategories
        .map<CategoryTabModel>((category) =>
            CategoryTabModel(category, GlobalKey(debugLabel: category.title)))
        .toList();
  }

  Future<List<BrandTabModel>> getBrandTabs(int subCategory) async {
    final Uri uri =
        Uri.http(apiBase, apiBrand, {apiCategoryQuery: subCategory.toString()});

    final List<dynamic> _rawList = await dataProvider.get(uri);

    /// 1. Populate all the sub categories
    List<BrandModel> _brands = _rawList
        .map<BrandModel>(
            (dynamic json) => BrandModel.fromJson(json as Map<String, dynamic>))
        .toList();

    /// 2. Map all sub categories to their tabs
    return _brands
        .map<BrandTabModel>(
            (brand) => BrandTabModel(brand, GlobalKey(debugLabel: brand.title)))
        .toList();
  }

  Future<List<Product>> getProducts(
      {String category,
      String product,
      String brandCode,
      String sortBy,
      String filterBy,
      String filterByValue,
      String pageNumber}) async {
    final Uri uri = Uri.http(apiBase, apiProducts, {
      apiCategoryQuery: category,
      apiProductQuery: product,
      apiBrandCode: brandCode,
      apiSortBy: sortBy,
      apiFilterBy: filterBy,
      apiFilterByValue: filterByValue,
      apiPageNumber: pageNumber,
    });
    final List<dynamic> _rawList = await dataProvider.get(uri);

    /// 1. Populate all the sub categories
    return _rawList
        .map<Product>(
            (dynamic json) => Product.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<Product> getScanProduct({
    String productId,
  }) async {
    final Uri uri = Uri.http(apiBase, apiProducts, {
      apiProductQuery: productId,
    });
    final List<dynamic> _rawList = await dataProvider.get(uri);

    /// 1. Populate all the sub categories
    return _rawList
        .map<Product>(
            (dynamic json) => Product.fromJson(json as Map<String, dynamic>))
        .toList()[0];
  }

  Future<List<SearchHistoryModel>> getSearchHistory() async {
    final rawData = [];
    // await dataProvider.get('search_history');

    final List<dynamic> _history = [];
    // rawData as List<dynamic> ?? <dynamic>[];

    return _history
        .map<SearchHistoryModel>((dynamic json) =>
            SearchHistoryModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
