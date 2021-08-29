import 'package:breakq/configs/api_urls.dart';
import 'package:breakq/configs/app_globals.dart';
import 'package:breakq/data/data_provider.dart';
import 'package:breakq/data/models/cart_api_model.dart';
import 'package:breakq/main.dart';

class CartRepository {
  const CartRepository({
    this.dataProvider = const DataProvider(),
  });

  final DataProvider dataProvider;

  Future<CartAPI> getCart() async {
    final Uri uri = Uri.http(apiBase, apiCartGet, {
      apistoreId: '1',
      apiFirebaseId: getIt.get<AppGlobals>().user.uid,
    });

    final Map<String, dynamic> _rawMap = await dataProvider.getAsMap(uri);

    return CartAPI.fromJson(_rawMap);
  }

  Future<bool> deleteCart() async {
    final Uri uri = Uri.http(apiBase, apiCartDelete, {
      apistoreId: '1',
      apiFirebaseId: getIt.get<AppGlobals>().user.uid,
    });

    return await dataProvider.delete(uri);
  }

  Future<CartProduct> addOrUpdateCart(AddCartModel item) async {
    final Uri uri = Uri.http(apiBase, apiCartAddOrUpdate);
    final _item = item.rebuild(
      storeID: 1,
      firebaseID: getIt.get<AppGlobals>().user.uid,
    );

    final _rawResponse = await dataProvider.post(uri, _item.toJson());

    return CartProduct.fromJson(_rawResponse);
  }
}
