import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  ProductModel({
    this.id,
    this.title,
    this.description,
    this.image,
    this.categoryId,
    this.price,
    this.quantity,
    this.available,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as int ?? 0,
      title: json['title'] as String ?? '',
      description: json['description'] as String ?? '',
      image: json['image'] as String ?? '',
      categoryId: json['category_id'] as int ?? 0,
      price: json['price'] as int ?? 0,
      quantity: json['quantity'] as String ?? '',
      available: json['available'] as int ?? 0,
    );
  }

  final int id;
  final String title;
  final int categoryId;
  final String quantity;
  final String description;
  final String image;
  final int price;
  final int available;

  @override
  List<Object> get props => [id];
}
