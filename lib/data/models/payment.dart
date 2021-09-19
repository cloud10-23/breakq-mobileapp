import 'package:json_annotation/json_annotation.dart';

part 'payment.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class Payment {
  @JsonKey(name: 'firebaseID')
  final String firebaseID;
  @JsonKey(name: 'bill_No')
  final String billNo;
  final Amount amount;

  Payment({this.firebaseID, this.amount, this.billNo});

  factory Payment.fromJson(Map<String, dynamic> json) =>
      _$PaymentFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentToJson(this);
}

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class Amount {
  double cash;
  Card card;
  UPI upi;
  Coupon coupon;

  Amount({this.cash, this.card, this.upi, this.coupon});

  factory Amount.fromJson(Map<String, dynamic> json) => _$AmountFromJson(json);

  Map<String, dynamic> toJson() => _$AmountToJson(this);
}

abstract class PaymentMode {
  String no;
  double amount;
}

@JsonSerializable(includeIfNull: false)
class Card implements PaymentMode {
  @override
  @JsonKey(name: 'card_No')
  String no;
  @override
  double amount;

  Card({this.no, this.amount});

  factory Card.fromJson(Map<String, dynamic> json) => _$CardFromJson(json);

  Map<String, dynamic> toJson() => _$CardToJson(this);
}

@JsonSerializable(includeIfNull: false)
class UPI implements PaymentMode {
  @JsonKey(name: 'upI_Id')
  String no;
  double amount;

  UPI({this.no, this.amount});

  factory UPI.fromJson(Map<String, dynamic> json) => _$UPIFromJson(json);

  Map<String, dynamic> toJson() => _$UPIToJson(this);
}

@JsonSerializable(includeIfNull: false)
class Coupon implements PaymentMode {
  @JsonKey(name: 'coupon_Code')
  String no;
  double amount;

  Coupon({this.no, this.amount});

  factory Coupon.fromJson(Map<String, dynamic> json) => _$CouponFromJson(json);

  Map<String, dynamic> toJson() => _$CouponToJson(this);
}
