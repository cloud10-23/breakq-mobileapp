// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bill_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Bill _$BillFromJson(Map<String, dynamic> json) {
  return Bill(
    json['bill_no'] as String,
    (json['bill_amnt'] as num)?.toDouble(),
    json['bill_date'] == null
        ? null
        : DateTime.parse(json['bill_date'] as String),
    Bill._fromProducts(json['products'] as List),
  );
}
