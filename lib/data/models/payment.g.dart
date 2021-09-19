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

Map<String, dynamic> _$PaymentToJson(Payment instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('firebaseID', instance.firebaseID);
  writeNotNull('bill_No', instance.billNo);
  writeNotNull('amount', instance.amount?.toJson());
  return val;
}

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

Map<String, dynamic> _$AmountToJson(Amount instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('cash', instance.cash);
  writeNotNull('card', instance.card?.toJson());
  writeNotNull('upi', instance.upi?.toJson());
  writeNotNull('coupon', instance.coupon?.toJson());
  return val;
}

Card _$CardFromJson(Map<String, dynamic> json) {
  return Card(
    no: json['card_No'] as String,
    amount: (json['amount'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$CardToJson(Card instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('card_No', instance.no);
  writeNotNull('amount', instance.amount);
  return val;
}

UPI _$UPIFromJson(Map<String, dynamic> json) {
  return UPI(
    no: json['upI_Id'] as String,
    amount: (json['amount'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$UPIToJson(UPI instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('upI_Id', instance.no);
  writeNotNull('amount', instance.amount);
  return val;
}

Coupon _$CouponFromJson(Map<String, dynamic> json) {
  return Coupon(
    no: json['coupon_Code'] as String,
    amount: (json['amount'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$CouponToJson(Coupon instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('coupon_Code', instance.no);
  writeNotNull('amount', instance.amount);
  return val;
}
