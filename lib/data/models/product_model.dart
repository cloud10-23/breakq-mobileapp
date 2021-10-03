import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable(createToJson: false)
class Product extends Equatable {
  const Product({
    this.id,
    this.title,
    this.categoryId,
    this.brandCode,
    this.categoryName,
    this.description,
    this.image,
    this.salePrice,
    this.maxPrice,
    this.quantity,
    this.available,
    this.discountPercent,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  final int id;
  @JsonKey(name: 'description')
  final String title;
  @JsonKey(name: 'category_Id')
  final int categoryId;
  @JsonKey(name: 'brand_Code')
  final String brandCode;
  @JsonKey(name: 'category_Name')
  final String categoryName;
  final String quantity;
  @JsonKey(name: 'title')
  final String description;
  final String image;
  final double available;
  @JsonKey(name: 'sale_Price')
  final double salePrice;
  @JsonKey(name: 'max_Price')
  final double maxPrice;
  @JsonKey(name: 'discount_Percent')
  final int discountPercent;

  /// Schema:
// "id": 0,
// "title": "string",
// "category_Id": 0,
// "brand_Code": "string",
// "category_Name": "string",
// "description": "string",
// "quantity": "string",
// "image": "string",
// "sale_Price": 0,
// "max_Price": 0,
// "available": 0,
// "discount_Percent": 0

  @override
  List<Object> get props => [this.id];
}
