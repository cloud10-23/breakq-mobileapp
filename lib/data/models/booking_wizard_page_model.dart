import 'package:flutter/material.dart';

class StepsWizardPageModel {
  StepsWizardPageModel(
    this.step,
    this.body,
    this.globalKey,
  );

  factory StepsWizardPageModel.fromJson(Map<String, dynamic> json) {
    return StepsWizardPageModel(
      json['step'] as int ?? 0,
      json['body'] as Widget ?? Container(),
      json['key'] as GlobalKey ??
          GlobalKey(
              debugLabel: 'booking_step' + (json['step'] as int).toString()),
    );
  }

  final int step;
  final Widget body;
  final GlobalKey globalKey;
}
