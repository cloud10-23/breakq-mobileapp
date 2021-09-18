// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Payment _$PaymentFromJson(Map<String, dynamic> json) {
  return Payment(
    firebaseID: json['firebaseID'] as String,
    amount: json['amount'] == null
        ? null
        : Amount.fromJson(json['amount'] as Map<String, dynamic>),
    billNo: json['bill_No'] as String,
  );
}

Map<String, dynamic> _$PaymentToJson(Payment instance) => <String, dynamic>{
      'firebaseID': instance.firebaseID,
      'bill_No': instance.billNo,
      'amount': instance.amount,
    };

Amount _$AmountFromJson(Map<String, dynamic> json) {
  return Amount(
    cash: (json['cash'] as num)?.toDouble(),
    card: json['card'] == null
        ? null
        : Card.fromJson(json['card'] as Map<String, dynamic>),
    upi: json['upi'] == null
        ? null
        : UPI.fromJson(json['upi'] as Map<String, dynamic>),
    coupon: json['coupon'] == null
        ? null
        : Coupon.fromJson(json['coupon'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AmountToJson(Amount instance) => <String, dynamic>{
      'cash': instance.cash,
      'card': instance.card,
      'upi': instance.upi,
      'coupon': instance.coupon,
    };

Card _$CardFromJson(Map<String, dynamic> json) {
  return Card(
    no: json['card_No'] as String,
    amount: (json['amount'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$CardToJson(Card instance) => <String, dynamic>{
      'card_No': instance.no,
      'amount': instance.amount,
    };

UPI _$UPIFromJson(Map<String, dynamic> json) {
  return UPI(
    no: json['upI_Id'] as String,
    amount: (json['amount'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$UPIToJson(UPI instance) => <String, dynamic>{
      'upI_Id': instance.no,
      'amount': instance.amount,
    };

Coupon _$CouponFromJson(Map<String, dynamic> json) {
  return Coupon(
    no: json['coupon_Code'] as String,
    amount: (json['amount'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$CouponToJson(Coupon instance) => <String, dynamic>{
      'coupon_Code': instance.no,
      'amount': instance.amount,
    };
