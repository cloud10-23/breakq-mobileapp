import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'toolbar_option_model.g.dart';

@JsonSerializable(createToJson: false)
class ToolbarOptionModel {
  ToolbarOptionModel(
    this.code,
    this.label,
    this.icon,
  );

  factory ToolbarOptionModel.fromJson(Map<String, dynamic> json) =>
      _$ToolbarOptionModelFromJson(json);

  final String code;
  final String label;
  @JsonKey(fromJson: _icon)
  final IconData icon;

  static IconData _icon(IconData icon) => icon;
}
