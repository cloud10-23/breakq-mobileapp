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
  final int addressId;
  @JsonKey(name: 'mobile_No')
  final String phone;
  @JsonKey(name: 'fireBaseID')
  final String firebaseID;
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
    this.firebaseID,
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
    String houseNo,
    String street,
    String cityDistTown,
    String state,
    String landmark,
    String phone,
    String firebaseID,
    String pinCode,
  }) {
    return Address(
      fullName: name ?? this.fullName,
      houseNo: houseNo ?? this.houseNo,
      street: street ?? this.street,
      city: cityDistTown ?? this.city,
      state: state ?? this.state,
      landmark: landmark ?? this.landmark,
      phone: phone ?? this.phone,
      firebaseID: firebaseID ?? this.firebaseID,
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
