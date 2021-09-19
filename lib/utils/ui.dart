import 'package:flutter/material.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/generated/l10n.dart';
import 'package:breakq/widgets/custom_dialog.dart';

/// Custom UI dialogs: message, confirmation and error.
class UI {
  static Future<void> showCustomDialog(
    BuildContext context, {
    String title,
    String message,
    IconData icon,
    Color iconBackgroundColor,
    bool barrierDissmissable = false,
    @required List<Widget> actions,
  }) async {
    return showGeneralDialog(
      useRootNavigator: true,
      // barrierDismissible: barrierDissmissable,
      context: context,
      barrierColor: Colors.black54, // space around dialog
      transitionDuration: const Duration(milliseconds: 250),
      transitionBuilder: (BuildContext context, Animation<double> a1,
          Animation<double> a2, Widget child) {
        return ScaleTransition(
          scale: CurvedAnimation(
              parent: a1,
              curve: Curves.elasticOut,
              reverseCurve: Curves.easeOutCubic),
          child: CustomDialog(
            title: title,
            message: message,
            icon: icon ?? Icons.info,
            iconBackgroundColor: iconBackgroundColor ?? kBlue,
            actions: actions,
          ),
        );
      },
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return null;
      },
    );
  }

  static Future<void> showMessage(
    BuildContext context, {
    String title,
    String message,
    @required String buttonText,
    void Function() onPressed,
  }) async {
    return showCustomDialog(
      context,
      title: title,
      message: message,
      actions: <Widget>[
        Builder(
          builder: (context) => FlatButton(
            color: kBlue,
            child: Text(buttonText),
            onPressed: () {
              Navigator.of(context).pop();
              if (onPressed != null) {
                onPressed();
              }
            },
          ),
        ),
      ],
    );
  }

  static Future<void> confirmationDialogBox(
    BuildContext context, {
    String title,
    String message,
    String okButtonText,
    String cancelButtonText,
    @required void Function() onConfirmation,
  }) async {
    return showCustomDialog(
      context,
      title: title,
      message: message,
      icon: Icons.help,
      // iconBackgroundColor: kBlue200,
      actions: <Widget>[
        FlatButton(
          textColor: Theme.of(context).buttonColor,
          child: Text(okButtonText ?? L10n.of(context).commonBtnOk),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
            onConfirmation();
          },
        ),
        RaisedButton(
          child: Text(cancelButtonText ?? L10n.of(context).commonBtnCancel),
          onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
        ),
      ],
    );
  }

  static Future<void> showErrorDialog(
    BuildContext context, {
    String title,
    String message,
    void Function() onPressed,
  }) async {
    return showCustomDialog(
      context,
      title: title ?? L10n.of(context).commonDialogsErrorTitle,
      message: message,
      icon: Icons.error,
      iconBackgroundColor: Colors.red,
      barrierDissmissable: true,
      actions: <Widget>[
        FlatButton(
          color: Theme.of(context).buttonColor,
          child: Text(L10n.of(context).commonBtnClose.toUpperCase()),
          onPressed: () {
            if (onPressed != null) {
              onPressed();
            } else
              Navigator.of(context, rootNavigator: true).pop();
          },
        ),
      ],
    );
  }
}
