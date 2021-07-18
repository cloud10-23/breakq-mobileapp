// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddCartModel _$AddCartModelFromJson(Map<String, dynamic> json) {
  return AddCartModel(
    storeID: json['store_ID'] as int,
    mobileNo: json['mobile_No'] as String,
    itemCode: json['item_Code'] as int,
    qty: json['qty'] as int,
  );
}

Map<String, dynamic> _$AddCartModelToJson(AddCartModel instance) =>
    <String, dynamic>{
      'store_ID': instance.storeID,
      'mobile_No': instance.mobileNo,
      'item_Code': instance.itemCode,
      'qty': instance.qty,
    };
