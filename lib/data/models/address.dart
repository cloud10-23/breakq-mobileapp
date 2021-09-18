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
  int addressId;
  @JsonKey(name: 'mobile_No')
  String phone;
  @JsonKey(name: 'fireBaseID')
  String firebaseID;
  String fullName;
  String pinCode;
  String houseNo;
  String street;
  @JsonKey(name: 'landMark')
  String landmark;
  String state;
  String city;

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

  set setName(String name) => this.fullName = name;
  set setHouseNo(String no) => this.houseNo = no;
  set setStreet(String street) => this.street = street;
  set setCityTown(String city) => this.city = city;
  set setState(String state) => this.state = state;
  set setLandmark(landmark) => this.landmark = landmark;
  set setPhone(String phno) => this.phone = phno;
  set setFirebaseID(String fID) => this.firebaseID = fID;
  set setPinCode(String pinCode) => this.pinCode = pinCode;

  String getFullAddress() {
    return (this?.houseNo ?? '') +
        ", " +
        (this?.street ?? '') +
        ", " +
        (this?.city ?? '') +
        ", " +
        (this?.pinCode ?? '') +
        ", " +
        (this?.state ?? '');
  }

  @override
  String toString() {
    return "Delivery Address Model";
  }
}
