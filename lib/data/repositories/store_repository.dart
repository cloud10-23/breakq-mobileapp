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
    // final Uri uri = Uri.http(apiBase, apiGetStores);

    // final List<dynamic> _rawList = await dataProvider.get(uri);

    // if (_rawList.isNotEmpty) {
    //   return _rawList
    //       .map<Store>(
    //           (dynamic json) => Store.fromJson(json as Map<String, dynamic>))
    //       .toList();
    // }
    return [
      Store(storeId: 1,branchName: "Branch 1",branchStore: "",city: "Chennai",country: "India",mobileNo: "+91 9874327722",state: "TN", distance: 1),
      Store(storeId: 2,branchName: "Branch 2",branchStore: "",city: "Chennai",country: "India",mobileNo: "+91 9923557229",state: "TN",distance: 10),
      Store(storeId: 3,branchName: "Branch 3",branchStore: "",city: "Chennai",country: "India",mobileNo: "+91 7321039223",state: "TN",distance: 7),
    ];
  }

  Future<List<Store>> calculateDistances(List<Store> stores) async {
    final currentLocation = getIt.get<AppGlobals>().currentPosition;
    final newStores = <Store>[];
    stores.forEach((store) {
      newStores.add(Store.rebuild(
          store, currentLocation.latitude, currentLocation.longitude));
    });
    return newStores;
  }
}
