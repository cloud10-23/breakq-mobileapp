import 'package:breakq/configs/api_urls.dart';
import 'package:breakq/data/data_provider.dart';
import 'package:breakq/data/models/stores.dart';

class StoresRepository {
  const StoresRepository({
    this.dataProvider = const DataProvider(),
  });

  final DataProvider dataProvider;

  Future<List<Store>> getStores() async {
    final Uri uri = Uri.http(apiBase, apiGetStores);

    final List<dynamic> _rawList = await dataProvider.get(uri);

    if (_rawList.isNotEmpty) {
      List<Store> stores = _rawList
          .map<Store>(
              (dynamic json) => Store.fromJson(json as Map<String, dynamic>))
          .toList();

      return stores;
    }
    return [];
  }
}
