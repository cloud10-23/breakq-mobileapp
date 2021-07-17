// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DealsModel _$DealsModelFromJson(Map<String, dynamic> json) {
  return DealsModel(
    id: json['dealsandOffersID'] as int,
    name: json['name'] as String,
    value: json['value'] as String,
    description: json['description'] as String,
    image: DealsModel._getImage(json['image'] as String),
  );
}
