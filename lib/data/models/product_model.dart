import 'package:equatable/equatable.dart';

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

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int ?? 0,
      title: json['title'] as String ?? '',
      categoryId: json['category_Id'] as int ?? 0,
      brandCode: json['brand_Code'] as String ?? '',
      categoryName: json['category_Name'] as String ?? '',
      description: json['description'] as String ?? '',
      quantity: json['quantity'] as String ?? '',
      image: json['image'] as String ?? '',
      salePrice: json['sale_Price'] as double ?? 0,
      maxPrice: json['max_Price'] as double ?? null,
      available: json['available'] as double ?? 0,
      discountPercent: json['discount_Percent'] as int ?? 0,
    );
  }

  final int id;
  final String title;
  final int categoryId;
  final String brandCode;
  final String categoryName;
  final String quantity;
  final String description;
  final String image;
  final double available;
  final double salePrice;
  final double maxPrice;
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
