import 'package:breakq/configs/api_urls.dart';
import 'package:breakq/configs/app_globals.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/data/data_provider.dart';
import 'package:breakq/data/models/payment.dart';
import 'package:breakq/data/models/timeslot_model.dart';
import 'package:breakq/main.dart';
import 'package:flutter/cupertino.dart';

class CheckoutRepository {
  const CheckoutRepository({
    this.dataProvider = const DataProvider(),
  });

  final DataProvider dataProvider;

  Future<String> checkoutWalkin() async {
    final Uri uri = Uri.http(apiBase, apiCheckoutWalkin, {
      apistoreId: '1',
      apiFirebaseId: getIt.get<AppGlobals>().user.uid,
    });

    final String billNo = await dataProvider.getAsString(uri);
    return billNo;
  }

  Future<String> checkoutWithTime(
      String date, String sTime, String eTime, CheckoutType type,
      {int addressID}) async {
    final Uri uri = Uri.http(apiBase, apiCheckoutWithTime, {
      apistoreId: '1',
      apiFirebaseId: getIt.get<AppGlobals>().user.uid,
      apiDeliveryDate: date,
      apiStartTime: sTime,
      apiEndTime: eTime,
      apiCheckoutType: apiCheckoutTypes[type],
      apiAddressID: (addressID != null) ? '$addressID' : null,
    });

    final String billNo = await dataProvider.getAsString(uri);
    return billNo;
  }

  Future<List<TimeslotModel>> getTimeSlots(CheckoutType type) async {
    final Uri uri = Uri.http(apiBase, apiCheckoutGetSlots, {
      apistoreId: '1',
      apiCheckoutType: apiCheckoutTypes[type],
    });

    final List<dynamic> _rawList = await dataProvider.get(uri);
    return _rawList
        .map((json) => TimeslotModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<bool> checkoutPay(
      {@required String billNo, @required Amount amount}) async {
    final Uri uri = Uri.http(apiBase, apiCheckoutPay);
    final Payment payment = Payment(
      amount: amount,
      billNo: billNo,
      firebaseID: getIt.get<AppGlobals>().user.uid,
    );
    print(payment.toJson());
    final String _result =
        await dataProvider.postByString(uri, payment.toJson());
    return _result == 'true';
  }
}
