// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) {
  return Order(
    storeId: json['store_ID'] as int,
    firebaseId: json['firebase_ID'] as String,
    mobileNo: json['mobile_No'] as String,
    billNo: json['bill_No'] as int,
    billAmnt: json['bill_Amnt'] as String,
    billDate: json['bill_Date'] as String,
    checkoutType: json['checkout_Type'] as String,
    paymentMode: json['payment_Mode'] as String,
    qty: json['qty'] as int,
    weight: (json['weight'] as num)?.toDouble() ?? 0,
    cgst: (json['cgst'] as num)?.toDouble() ?? 0,
    sgst: (json['sgst'] as num)?.toDouble() ?? 0,
    status: json['status'] as String,
    timeSlot: json['timeSlot'] == null
        ? null
        : OrderTimeSlot.fromJson(json['timeSlot'] as Map<String, dynamic>),
    products: (json['products'] as List)
        ?.map((e) =>
            e == null ? null : CartProduct.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    price: json['price'] == null
        ? null
        : Price.fromJson(json['price'] as Map<String, dynamic>),
    address: json['address'] == null
        ? null
        : Address.fromJson(json['address'] as Map<String, dynamic>),
  );
}
