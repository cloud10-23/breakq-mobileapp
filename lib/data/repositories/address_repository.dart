import 'package:breakq/configs/api_urls.dart';
import 'package:breakq/configs/app_globals.dart';
import 'package:breakq/data/data_provider.dart';
import 'package:breakq/data/models/address.dart';
import 'package:breakq/main.dart';

class AddressRepository {
  const AddressRepository({
    this.dataProvider = const DataProvider(),
  });

  final DataProvider dataProvider;

  Future<List<Address>> getAddress() async {
    final Uri uri = Uri.http(apiBase, apiGetAddress, {
      apiFirebaseId: getIt.get<AppGlobals>().user.uid,
    });

    final List<dynamic> _rawList = await dataProvider.get(uri);

    List<Address> addresses = _rawList
        .map<Address>(
            (dynamic json) => Address.fromJson(json as Map<String, dynamic>))
        .toList();

    return addresses;
  }

  Future<String> addOrUpdate(Address address) async {
    final Uri uri = Uri.http(apiBase, apiPostAddress);
    address.setFirebaseID = getIt.get<AppGlobals>().user.uid;

    return await dataProvider.postByString(uri, address.toJson());
  }
}
