// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) {
  return Product(
    id: json['id'] as int,
    title: json['description'] as String,
    categoryId: json['category_Id'] as int,
    brandCode: json['brand_Code'] as String,
    categoryName: json['category_Name'] as String,
    description: json['title'] as String,
    image: json['image'] as String,
    salePrice: (json['sale_Price'] as num)?.toDouble(),
    maxPrice: (json['max_Price'] as num)?.toDouble(),
    quantity: json['quantity'] as String,
    available: (json['available'] as num)?.toDouble(),
    discountPercent: json['discount_Percent'] as int,
  );
}
