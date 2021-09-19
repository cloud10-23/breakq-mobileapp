import 'package:breakq/data/models/address.dart';
import 'package:breakq/data/models/cart_api_model.dart';
import 'package:breakq/data/models/price_model.dart';
import 'package:breakq/data/models/timeslot_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'my_order.g.dart';

@JsonSerializable(createToJson: false)
class Order extends Equatable {
  @JsonKey(name: "store_ID")
  final int storeId;
  @JsonKey(name: "firebase_ID")
  final String firebaseId;
  @JsonKey(name: "mobile_No")
  final String mobileNo;
  @JsonKey(name: "bill_No")
  final int billNo;
  @JsonKey(name: "bill_Amnt")
  final String billAmnt;
  @JsonKey(name: "bill_Date")
  final String billDate;
  @JsonKey(name: "checkout_Type")
  final String checkoutType;
  @JsonKey(name: "payment_Mode")
  final String paymentMode;
  final int qty;
  final double weight;
  final double cgst;
  final double sgst;
  final String status;
  @JsonKey(name: "paymentStatus")
  final String paymentStatus;
  @JsonKey(name: "time_Slot")
  final OrderTimeSlot timeSlot;
  final List<CartProduct> products;
  @JsonKey(name: "price_Details")
  final Price price;
  final Address address;

  Order({
    this.storeId,
    this.firebaseId,
    this.mobileNo,
    this.billNo,
    this.billAmnt,
    this.billDate,
    this.checkoutType,
    this.paymentMode,
    this.qty,
    this.weight,
    this.cgst,
    this.sgst,
    this.status,
    this.paymentStatus,
    this.timeSlot,
    this.products,
    this.price,
    this.address,
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  @override
  List<Object> get props => [this.billNo];
}

/*
{
  "store_ID": 0,
  "firebase_ID": "string",
  "mobile_No": "string",
  "bill_No": 0,
  "bill_Amnt": "string",
  "bill_Date": "2021-08-10T08:02:08.122Z",
  "checkout_Type": "string",
  "payment_Mode": "string",
  "qty": 0,
  "weight": 0,
  "cgst": 0,
  "sgst": 0,
  "status": "string",
  "time_Slot": {
    "date": "string",
    "time": "string"
  },
  "products": [
    {
      "cartDetId": 0,
      "store_ID": 0,
      "mobile_No": "string",
      "item_Code": 0,
      "qty": 0,
      "rate": 0,
      "discount_Percent": 0,
      "tax_Code": "string",
      "weight": 0,
      "status": "string",
      "title": "string",
      "category_Id": 0,
      "brand_Code": "string",
      "category_Name": "string",
      "description": "string",
      "quantity": "string",
      "image": "string",
      "sale_Price": 0,
      "item_Total_Price": 0,
      "tax_Amount": 0,
      "max_Price": 0,
      "available": 0
    }
  ],
  "price_Details": {
    "discount": 0,
    "extra_Offer": 0,
    "delivery_Charges": 0,
    "final_Amount": 0,
    "savings": 0
  },
  "address": {
    "addressId": 0,
    "mobile_No": "string",
    "fullName": "string",
    "pinCode": "string",
    "houseNo": "string",
    "street": "string",
    "landMark": "string",
    "state": "string",
    "city": "string"
  }
}
*/