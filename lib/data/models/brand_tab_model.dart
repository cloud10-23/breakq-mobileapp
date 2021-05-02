import 'package:breakq/data/models/category_model.dart';
import 'package:flutter/material.dart';

class BrandTabModel {
  BrandTabModel(
    this.brand,
    this.globalKey,
  ) : this.id = brand.id;

  factory BrandTabModel.fromJson(Map<String, dynamic> json) {
    return BrandTabModel(
      json['brand'] as BrandModel ?? BrandModel(),
      json['globalKey'] as GlobalKey,
    );
  }

  final String id;
  final BrandModel brand;
  final GlobalKey globalKey;
}
