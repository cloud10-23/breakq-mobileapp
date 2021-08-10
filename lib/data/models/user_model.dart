import 'package:json_annotation/json_annotation.dart';
part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  UserModel({
    this.userId,
    this.mobileNo,
    this.name,
    this.firebaseId,
    this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  UserModel copyWith(
      {String userId,
      String firebaseId,
      String facebookId,
      String name,
      String email,
      String profilePhoto,
      String mobileNo}) {
    return UserModel(
      userId: userId ?? this.userId,
      mobileNo: mobileNo ?? this.mobileNo,
      firebaseId: firebaseId ?? this.firebaseId,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }

  @JsonKey(name: 'userID')
  final int userId;
  @JsonKey(name: 'mobile_No')
  final String mobileNo;
  final String name;
  @JsonKey(name: 'fireBaseID')
  final String firebaseId;
  final String email;
}
