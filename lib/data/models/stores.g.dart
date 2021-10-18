// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stores.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Store _$StoreFromJson(Map<String, dynamic> json) {
  return Store(
    storeId: json['storeId'] as int,
    mobileNo: json['mobileNo'] as String,
    branchName: json['branchName'] as String,
    branchStore: json['branchStore'] as String,
    state: json['state'] as String,
    city: json['city'] as String,
    pinCode: json['pinCode'] as String,
    country: json['country'] as String,
    latitude: json['latitude'] as String,
    longitude: json['longitude'] as String,
  );
}

Map<String, dynamic> _$StoreToJson(Store instance) => <String, dynamic>{
      'storeId': instance.storeId,
      'mobileNo': instance.mobileNo,
      'branchName': instance.branchName,
      'branchStore': instance.branchStore,
      'state': instance.state,
      'city': instance.city,
      'pinCode': instance.pinCode,
      'country': instance.country,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
