import 'package:breakq/data/data_provider.dart';
import 'package:breakq/data/models/category_model.dart';
import 'package:breakq/data/models/data_response_model.dart';
import 'package:breakq/data/models/product_model.dart';
import 'package:breakq/data/models/search_history_model.dart';

class ProductsRepository {
  const ProductsRepository({
    this.dataProvider = const DataProvider(),
  });

  final DataProvider dataProvider;

  Future<List<CategoryModel>> getCategories() async {
    final DataResponseModel rawData = await dataProvider.get('categories_new');

    final List<dynamic> _categories =
        rawData.data['data'] as List<dynamic> ?? <dynamic>[];

    return _categories
        .map<CategoryModel>((dynamic json) =>
            CategoryModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<Product> getProduct({int id}) async {
    final DataResponseModel rawData = await dataProvider.get('location_new');
    // return null;
    return Product.fromJson(rawData.data['data'] as Map<String, dynamic>);
  }

  Future<List<SearchHistoryModel>> getSearchHistory() async {
    final DataResponseModel rawData = await dataProvider.get('search_history');

    final List<dynamic> _history =
        rawData.data['search_queries'] as List<dynamic> ?? <dynamic>[];

    return _history
        .map<SearchHistoryModel>((dynamic json) =>
            SearchHistoryModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<List<Product>> search() async {
    final DataResponseModel rawData = await dataProvider.get('discover');

    final List<dynamic> _rawProducts =
        rawData.data['products'] as List<dynamic> ?? <dynamic>[];

    final List<dynamic> _products = _rawProducts + _rawProducts + _rawProducts;
    // return null;
    return _products
        .map<Product>(
            (dynamic json) => Product.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<List<Product>> searchCategory({int id}) async {
    /// Just make the call with the given ID and server takes care
    final DataResponseModel rawData = await dataProvider.get('discover');

    final List<dynamic> _rawProducts =
        rawData.data['products'] as List<dynamic> ?? <dynamic>[];

    final List<dynamic> _products = _rawProducts + _rawProducts + _rawProducts;

    /// Shuffle it to simulate network activity for now! ;-)
    /// Because anyway it will be handled by the API server!
    _products.shuffle();
    return _products
        .map<Product>(
            (dynamic json) => Product.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
