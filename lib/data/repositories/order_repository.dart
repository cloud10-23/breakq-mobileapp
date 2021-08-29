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

  Future<List<Order>> getOrders() async {
    final Uri uri = Uri.http(apiBase, apiCheckoutWalkin, {
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
