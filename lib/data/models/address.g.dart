// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) {
  return Address(
    addressId: json['addressId'] as int,
    firebaseID: json['fireBaseID'] as String,
    fullName: json['fullName'] as String,
    houseNo: json['houseNo'] as String,
    street: json['street'] as String,
    city: json['city'] as String,
    state: json['state'] as String,
    landmark: json['landMark'] as String,
    phone: json['mobile_No'] as String,
    pinCode: json['pinCode'] as String,
  );
}

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'addressId': instance.addressId,
      'mobile_No': instance.phone,
      'fireBaseID': instance.firebaseID,
      'fullName': instance.fullName,
      'pinCode': instance.pinCode,
      'houseNo': instance.houseNo,
      'street': instance.street,
      'landMark': instance.landmark,
      'state': instance.state,
      'city': instance.city,
    };
