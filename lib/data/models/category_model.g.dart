// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryModel _$CategoryModelFromJson(Map<String, dynamic> json) {
  return CategoryModel(
    id: json['category_Code'] as int,
    parentId: json['parent_Category_Code'] as int,
    title: json['category_Name'] as String,
    image: json['image'] as String,
  );
}

BrandModel _$BrandModelFromJson(Map<String, dynamic> json) {
  return BrandModel(
    id: json['brand_Code'] as String,
    title: json['brand_Name'] as String,
    image: json['image'] as String,
  );
}
