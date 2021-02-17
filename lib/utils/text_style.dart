import 'package:flutter/material.dart';
import 'package:breakq/configs/constants.dart';

/// [TextStyle] extensions.
extension TextStyleExtension on TextStyle {
  TextStyle get h15 => copyWith(height: 1.5);

  TextStyle get w300 => copyWith(fontWeight: FontWeight.w300);
  TextStyle get w400 => copyWith(fontWeight: FontWeight.w400);
  TextStyle get w500 => copyWith(fontWeight: FontWeight.w500);
  TextStyle get w600 => copyWith(fontWeight: FontWeight.w600);
  TextStyle get w700 => copyWith(fontWeight: FontWeight.w700);
  TextStyle get w800 => copyWith(fontWeight: FontWeight.w800);
  TextStyle get bold => copyWith(fontWeight: FontWeight.bold);

  TextStyle get fs8 => copyWith(fontSize: 8);
  TextStyle get fs10 => copyWith(fontSize: 10);
  TextStyle get fs12 => copyWith(fontSize: 12);
  TextStyle get fs14 => copyWith(fontSize: 14);
  TextStyle get fs16 => copyWith(fontSize: 16);
  TextStyle get fs18 => copyWith(fontSize: 18);
  TextStyle get fs28 => copyWith(fontSize: 28);

  TextStyle get white => copyWith(color: kWhite);
  TextStyle get black => copyWith(color: kBlack);
  TextStyle get green => copyWith(color: Colors.green);
  TextStyle get primaryColor => copyWith(color: kPrimaryColor);
}
