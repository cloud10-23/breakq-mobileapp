import 'package:json_annotation/json_annotation.dart';

part 'category_model.g.dart';

@JsonSerializable(createToJson: false)
class CategoryModel {
  CategoryModel({
    this.id,
    this.parentId,
    this.title,
    this.image,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  @JsonKey(name: 'category_Code')
  final int id;
  @JsonKey(name: 'parent_Category_Code')
  final int parentId;
  @JsonKey(name: 'category_Name')
  final String title;
  final String image;
}

@JsonSerializable(createToJson: false)
class BrandModel {
  BrandModel({
    this.id,
    this.title,
    this.image,
  });

  factory BrandModel.fromJson(Map<String, dynamic> json) =>
      _$BrandModelFromJson(json);

  @JsonKey(name: 'brand_Code')
  final String id;
  @JsonKey(name: 'brand_Name')
  final String title;
  final String image;
}
