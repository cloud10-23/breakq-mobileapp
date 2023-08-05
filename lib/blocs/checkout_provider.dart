import 'package:flutter/cupertino.dart';

class CheckoutProvider extends ChangeNotifier{

  String paymentId = "";

  void storePaymentId(String id) {
    paymentId = id;
    notifyListeners();
  }

  void removePaymentId() {
    paymentId = "";
    notifyListeners();
  }


}