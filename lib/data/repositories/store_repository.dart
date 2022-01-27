import 'package:breakq/configs/api_urls.dart';
import 'package:breakq/configs/app_globals.dart';
import 'package:breakq/data/data_provider.dart';
import 'package:breakq/data/models/stores.dart';
import 'package:breakq/main.dart';

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
      final currentLocation = getIt.get<AppGlobals>().currentPosition;
      final newStores = <Store>[];
      stores.forEach((store) {
        newStores.add(Store.rebuild(
            store, currentLocation.latitude, currentLocation.longitude));
      });
      return newStores;
    }
    return [];
  }
}
