import 'package:breakq/configs/api_urls.dart';
import 'package:breakq/configs/app_globals.dart';
import 'package:breakq/data/data_provider.dart';
import 'package:breakq/data/models/my_order.dart';
import 'package:breakq/main.dart';

class MyOrderRepository {
  const MyOrderRepository({
    this.dataProvider = const DataProvider(),
  });

  final DataProvider dataProvider;

  Future<Order> getOrder(String billNo) async {
    final Uri uri = Uri.http(apiBase, apiOrder, {
      apistoreId: '1',
      apiFirebaseId: getIt.get<AppGlobals>().user.uid,
      apiBillId: billNo,
    });

    final Map<String, dynamic> _rawJson = await dataProvider.getAsMap(uri);
    return Order.fromJson(_rawJson);
  }

  Future<List<Order>> getMyOrders() async {
    final Uri uri = Uri.http(apiBase, apiMyOrders, {
      apistoreId: '1',
      apiFirebaseId: getIt.get<AppGlobals>().user.uid,
    });

    final List<dynamic> _rawList = await dataProvider.get(uri);
    return _rawList
        .map((json) => Order.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<List<Order>> getSampleOrders() async {
    final _rawList = await dataProvider.getAsset('orders');
    return _rawList
        .map((json) => Order.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
