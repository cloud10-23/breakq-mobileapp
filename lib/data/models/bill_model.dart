import 'package:breakq/data/models/cart_model.dart';

class Bill {
  Bill(
    this.billNo,
    this.billAmnt,
    this.billDate,
    this.products,
  );

  factory Bill.fromJson(Map<String, dynamic> json) {
    return Bill(
      json['bill_no'] as String ?? '0',
      json['bill_amnt'] as double ?? 0.0,
      DateTime.tryParse(json['bill_date'] as String ?? '') ?? DateTime.now(),
      Cart.fromJson(json['products'] as List<dynamic>),
    );
  }

  final String billNo;
  final double billAmnt;
  final DateTime billDate;
  final Cart products;
}
