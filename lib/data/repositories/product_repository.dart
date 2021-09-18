import 'package:breakq/configs/api_urls.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/data/data_provider.dart';
import 'package:breakq/data/models/brand_tab_model.dart';
import 'package:breakq/data/models/category_model.dart';
import 'package:breakq/data/models/category_tab_model.dart';
import 'package:breakq/data/models/home_models.dart';
import 'package:breakq/data/models/product_model.dart';
import 'package:breakq/data/models/search_history_model.dart';
import 'package:flutter/cupertino.dart';

class ProductsRepository {
  const ProductsRepository({
    this.dataProvider = const DataProvider(),
  });

  final DataProvider dataProvider;

  Future<Map<homeSections, dynamic>> getHomeDetails() async {
    final Uri uri = Uri.http(apiBase, apiHome);

    final Map<String, dynamic> _rawList = await dataProvider.getAsMap(uri);

    /// I - Extra offers:
    ///
    List<DealsModel> _extraOffers = _rawList["offers"]
        .map<DealsModel>(
            (dynamic json) => DealsModel.fromJson(json as Map<String, dynamic>))
        .toList();

    /// II - Deals:
    ///
    List<DealsModel> _topDeals = _rawList["deals"]
        .map<DealsModel>(
            (dynamic json) => DealsModel.fromJson(json as Map<String, dynamic>))
        .toList();

    /// III - Categories:
    ///
    /// 1. Populate all the sub categories
    List<CategoryModel> _categories = _rawList["categories"]
        .map<CategoryModel>((dynamic json) =>
            CategoryModel.fromJson(json as Map<String, dynamic>))
        .toList();

    /// 2. Map all sub categories to their tabs
    List<CategoryTabModel> _categoryTabModels = _categories
        .map<CategoryTabModel>((category) =>
            CategoryTabModel(category, GlobalKey(debugLabel: category.title)))
        .toList();

    return {
      homeSections.topOffers: _extraOffers,
      homeSections.topDeals: _topDeals,
      homeSections.categories: _categoryTabModels,
    };
  }

  Future<List<Product>> getExclusiveProduct() async {
    final Uri uri = Uri.http(apiBase, apiExclusiveProducts);
    final List<dynamic> _rawList = await dataProvider.get(uri);

    /// 1. Populate all the sub categories
    return _rawList
        .map<Product>(
            (dynamic json) => Product.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  // Future<List<CategoryTabModel>> getCategoryTabs() async {
  //   final Uri uri = Uri.http(apiBase, apiCategory);

  //   final List<dynamic> _rawList = await dataProvider.get(uri);

  //   /// 1. Populate all the sub categories
  //   List<CategoryModel> _categories = _rawList
  //       .map<CategoryModel>((dynamic json) =>
  //           CategoryModel.fromJson(json as Map<String, dynamic>))
  //       .toList();

  //   /// 2. Map all sub categories to their tabs
  //   return _categories
  //       .map<CategoryTabModel>((category) =>
  //           CategoryTabModel(category, GlobalKey(debugLabel: category.title)))
  //       .toList();
  // }

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
      String productCode,
      String barCode,
      String brandCode,
      String sortBy,
      String filterBy,
      String filterByValue,
      String pageNumber}) async {
    final Uri uri = Uri.http(apiBase, apiProducts, {
      apiCategoryQuery: category,
      apiProductQuery: product,
      apiProductCode: productCode,
      apiBarCode: barCode,
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

  Future<List<Product>> getOfferProducts({
    DealsModel offer,
  }) async {
    final Uri uri = Uri.http(apiBase, apiOfferProducts, {
      apiStoreId: '1',
      apiName: offer.name,
      apiValue: offer.value,
      apiDescription: offer.description,
      apiPageNumber: '1',
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
    // final rawData = [];
    // await dataProvider.get('search_history');

    final List<dynamic> _history = [];
    // rawData as List<dynamic> ?? <dynamic>[];

    return _history
        .map<SearchHistoryModel>((dynamic json) =>
            SearchHistoryModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
