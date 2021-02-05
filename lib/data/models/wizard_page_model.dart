import 'package:breakq/configs/constants.dart';
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
              debugLabel: 'wizard_step' + (json['step'] as int).toString()),
    );
  }

  final int step;
  final Widget body;
  final GlobalKey globalKey;
}

class CheckoutStepsWizardPageModel {
  CheckoutStepsWizardPageModel(
    this.type,
    this.step,
    this.body,
    this.globalKey,
  );

  factory CheckoutStepsWizardPageModel.fromJson(Map<String, dynamic> json) {
    return CheckoutStepsWizardPageModel(
      json['type'] as CheckoutType ?? CheckoutType.walkIn,
      json['step'] as int ?? 0,
      json['body'] as Widget ?? Container(),
      json['key'] as GlobalKey ??
          GlobalKey(
              debugLabel: 'checkout_wizard_step' +
                  (json['type'] as CheckoutType).toString() +
                  (json['step'] as int).toString()),
    );
  }

  final CheckoutType type;
  final int step;
  final Widget body;
  final GlobalKey globalKey;
}
