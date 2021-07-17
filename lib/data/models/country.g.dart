// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Country _$CountryFromJson(Map<String, dynamic> json) {
  return Country(
    name: json['name'] as String,
    code: json['code'] as String,
    dialCode: json['dial_code'] as String,
    flag: json['flag'] as String,
  );
}

Map<String, dynamic> _$CountryToJson(Country instance) => <String, dynamic>{
      'name': instance.name,
      'code': instance.code,
      'dial_code': instance.dialCode,
      'flag': instance.flag,
    };
