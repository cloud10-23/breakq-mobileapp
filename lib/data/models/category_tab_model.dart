import 'package:breakq/data/models/category_model.dart';
import 'package:flutter/material.dart';

class CategoryTabModel {
  CategoryTabModel(
    this.category,
    this.globalKey,
  ) : this.id = category.id;

  final int id;
  final CategoryModel category;
  final GlobalKey globalKey;
}
