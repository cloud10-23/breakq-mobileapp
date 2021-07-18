import 'package:breakq/data/models/product_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart_api_model.g.dart';

/*  "cartDetId": 7,
    "store_ID": 1,
    "mobile_No": "1234567890",
    "item_Code": 408,
    "qty": 4,
    "rate": 13,
    "discount_Percent": 0,
    "tax_Code": "S0 ",
    "weight": 0.1,
    "status": "C",
    "title": "MUSTARD 100G",
    "category_Id": 1002,
    "brand_Code": "B034",
    "category_Name": "SPICES",
    "description": "MUSTARD 100G",
    "quantity": null,
    "image": "/Images/Product/408.jpg",
    "sale_Price": 13,
    "max_Price": 13,
    "available": 1
*/
class CartProduct extends Equatable {
  final int cartDetId;
  final int storeId;
  final String mobileNo;
  final int qty;
  final double rate;
  final String taxCode;
  final double weight;
  final String status;
  final Product product;

  CartProduct({
    this.cartDetId,
    this.storeId,
    this.mobileNo,
    this.qty,
    this.rate,
    this.taxCode,
    this.weight,
    this.status,
    this.product,
  });

  factory CartProduct.fromJson(Map<String, dynamic> json) =>
      _$CartProductFromJson(json);

  @override
  List<Object> get props => [this.product];
}

@JsonSerializable()
class AddCartModel {
  @JsonKey(name: 'store_ID')
  final int storeID;
  @JsonKey(name: 'mobile_No')
  final String mobileNo;
  @JsonKey(name: 'item_Code')
  final int itemCode;
  final int qty;

  AddCartModel({this.storeID, this.mobileNo, this.itemCode, this.qty});

  factory AddCartModel.fromJson(Map<String, dynamic> json) =>
      _$AddCartModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddCartModelToJson(this);

  AddCartModel rebuild({storeID, mobileNo}) => AddCartModel(
        itemCode: this.itemCode,
        qty: this.qty,
        storeID: storeID,
        mobileNo: mobileNo,
      );
}

CartProduct _$CartProductFromJson(Map<String, dynamic> json) {
  return CartProduct(
    cartDetId: json['cartDetId'] as int,
    storeId: json['store_ID'] as int,
    mobileNo: json['mobile_No'] as String,
    qty: json['qty'] as int,
    rate: (json['rate'] as num)?.toDouble(),
    taxCode: json['tax_Code'] as String,
    weight: (json['weight'] as num)?.toDouble(),
    status: json['status'] as String,
    product: Product(
      id: json['item_Code'] as int,
      discountPercent: json['discount_Percent'] as int,
      title: json['title'] as String,
      categoryId: json['category_Id'] as int,
      available: (json['available'] as num)?.toDouble(),
      brandCode: json['brand_Code'] as String,
      categoryName: json['category_Name'] as String,
      description: json['description'],
      image: json['image'],
      maxPrice: (json['max_Price'] as num)?.toDouble(),
      quantity: json['quantity'],
      salePrice: json['sale_Price'],
    ),
  );
}
