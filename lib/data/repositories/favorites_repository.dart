import 'package:breakq/data/data_provider.dart';
import 'package:breakq/data/models/data_response_model.dart';
import 'package:breakq/data/models/product_model.dart';

class FavoritesRepository {
  const FavoritesRepository({
    this.dataProvider = const DataProvider(),
  });

  final DataProvider dataProvider;

  Future<List<ProductModel>> getFavorites() async {
    final DataResponseModel rawData = await dataProvider.get('favorites');

    final List<dynamic> _favorites =
        rawData.data['favorites'] as List<dynamic> ?? <dynamic>[];
    return null;
    // return _favorites
    //     .map<LocationModel>((dynamic json) =>
    //         LocationModel.fromJson(json as Map<String, dynamic>))
    //     .toList();
  }
}
