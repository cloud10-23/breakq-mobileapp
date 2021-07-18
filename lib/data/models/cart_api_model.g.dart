// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartResponse _$CartResponseFromJson(Map<String, dynamic> json) {
  return CartResponse(
    cartDetId: json['cartDetId'] as int,
    storeId: json['store_ID'] as int,
    mobileNo: json['mobile_No'] as String,
    itemCode: json['item_Code'] as int,
    qty: json['qty'] as int,
    rate: (json['rate'] as num)?.toDouble(),
    discountPercent: (json['discount_Percent'] as num)?.toDouble(),
    taxCode: json['tax_Code'] as String,
    weight: (json['weight'] as num)?.toDouble(),
    status: json['status'] as String,
    title: json['title'] as String,
    categoryId: json['category_Id'] as int,
    available: (json['available'] as num)?.toDouble(),
    brandCode: json['brand_Code'] as String,
    categoryName: json['category_Name'] as String,
    description: json['description'],
    image: json['image'],
    maxPrice: (json['maxPrice'] as num)?.toDouble(),
    quantity: json['quantity'],
    salePrice: json['sale_Price'],
  );
}

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
