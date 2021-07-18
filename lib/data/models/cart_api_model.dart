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
@JsonSerializable(createToJson: false)
class CartResponse {
  @JsonKey(name: 'cartDetId')
  final int cartDetId;
  @JsonKey(name: 'store_ID')
  final int storeId;
  @JsonKey(name: 'mobile_No')
  final String mobileNo;
  @JsonKey(name: 'item_Code')
  final int itemCode;
  final int qty;
  final double rate;
  @JsonKey(name: 'discount_Percent')
  final double discountPercent;
  @JsonKey(name: 'tax_Code')
  final String taxCode;
  final double weight;
  final String status;
  final String title;
  @JsonKey(name: 'category_Id')
  final int categoryId;
  @JsonKey(name: 'brand_Code')
  final String brandCode;
  @JsonKey(name: 'category_Name')
  final String categoryName;
  final description;
  final quantity;
  final image;
  @JsonKey(name: 'sale_Price')
  final salePrice;
  @JsonKey(name: 'maxPrice')
  final double maxPrice;
  final double available;

  CartResponse({
    this.cartDetId,
    this.storeId,
    this.mobileNo,
    this.itemCode,
    this.qty,
    this.rate,
    this.discountPercent,
    this.taxCode,
    this.weight,
    this.status,
    this.title,
    this.categoryId,
    this.available,
    this.brandCode,
    this.categoryName,
    this.description,
    this.image,
    this.maxPrice,
    this.quantity,
    this.salePrice,
  });

  factory CartResponse.fromJson(Map<String, dynamic> json) =>
      _$CartResponseFromJson(json);
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
}
