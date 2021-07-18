import 'package:json_annotation/json_annotation.dart';

part 'address.g.dart';
/*{
  "addressId": 0,
  "mobile_No": "string",
  "fullName": "string",
  "pinCode": "string",
  "houseNo": "string",
  "street": "string",
  "landMark": "string",
  "state": "string",
  "city": "string"
}*/

@JsonSerializable()
class Address {
  final String addressId;
  @JsonKey(name: 'mobile_No')
  final String phone;
  final String fullName;
  final String pinCode;
  final String houseNo;
  final String street;
  @JsonKey(name: 'landMark')
  final String landmark;
  final String state;
  final String city;

  Address({
    this.addressId,
    this.fullName,
    this.houseNo,
    this.street,
    this.city,
    this.state,
    this.landmark,
    this.phone,
    this.pinCode,
  });

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);

  Address rebuild({
    String name,
    String addLine1,
    String addLine2,
    String cityDistTown,
    String state,
    String landmark,
    String phone,
    String pinCode,
  }) {
    return Address(
      fullName: name ?? this.fullName,
      houseNo: addLine1 ?? this.houseNo,
      street: addLine2 ?? this.street,
      city: cityDistTown ?? this.city,
      state: state ?? this.state,
      landmark: landmark ?? this.landmark,
      phone: phone ?? this.phone,
      pinCode: pinCode ?? this.pinCode,
    );
  }

  String getFullAddress() {
    return this.houseNo +
        ", " +
        this.street +
        ", " +
        this.city +
        ", " +
        this.pinCode +
        ", " +
        this.state;
  }

  @override
  String toString() {
    return "Delivery Address Model";
  }
}
