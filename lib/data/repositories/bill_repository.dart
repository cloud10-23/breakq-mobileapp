import 'package:breakq/data/data_provider.dart';
import 'package:breakq/data/models/bill_model.dart';
import 'package:breakq/data/models/data_response_model.dart';

class BillsRepository {
  const BillsRepository({
    this.dataProvider = const DataProvider(),
  });

  final DataProvider dataProvider;

  Future<List<Bill>> getBills() async {
    final DataResponseModel rawData = await dataProvider.get('bills');

    final List<dynamic> _bills =
        rawData.data['bills'] as List<dynamic> ?? <dynamic>[];

    return _bills
        .map<Bill>(
            (dynamic json) => Bill.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
