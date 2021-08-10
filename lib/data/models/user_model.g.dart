// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return UserModel(
    userId: json['userID'] as int,
    mobileNo: json['mobile_No'] as String,
    name: json['name'] as String,
    firebaseId: json['fireBaseID'] as String,
    email: json['email'] as String,
  );
}

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'userID': instance.userId,
      'mobile_No': instance.mobileNo,
      'name': instance.name,
      'fireBaseID': instance.firebaseId,
      'email': instance.email,
    };
