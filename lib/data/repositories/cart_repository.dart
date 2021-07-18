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

  Future<List<CartProduct>> getCart() async {
    final Uri uri = Uri.http(apiBase, apiCartGet, {
      apistoreId: '1',
      apiMobileNo: getIt.get<AppGlobals>().user.phoneNumber,
    });

    final List<dynamic> _rawList = await dataProvider.get(uri);

    List<CartProduct> _cartItems = _rawList
        .map<CartProduct>((dynamic json) =>
            CartProduct.fromJson(json as Map<String, dynamic>))
        .toList();

    return _cartItems;
  }

  Future<bool> deleteCart() async {
    final Uri uri = Uri.http(apiBase, apiCartDelete, {
      apistoreId: '1',
      apiMobileNo: getIt.get<AppGlobals>().user.phoneNumber,
    });

    return await dataProvider.delete(uri);
  }

  Future<CartProduct> addOrUpdateCart(AddCartModel item) async {
    final Uri uri = Uri.http(apiBase, apiCartAddOrUpdate);
    final _item = item.rebuild(
      storeID: 1,
      mobileNo: getIt.get<AppGlobals>().user.phoneNumber,
    );

    final _rawResponse = await dataProvider.post(uri, _item.toJson());

    return CartProduct.fromJson(_rawResponse);
  }
}
