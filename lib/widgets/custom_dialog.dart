import 'package:flutter/material.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/utils/text_style.dart';
import 'package:breakq/utils/string.dart';

/// Custom [Dialog] box used to show warnings, errors and confirmation messages.
class CustomDialog extends StatelessWidget {
  const CustomDialog({
    Key key,
    @required this.title,
    @required this.message,
    this.actions,
    this.icon,
    this.iconBackgroundColor,
  }) : super(key: key);

  /// Buttons to be shown in dialog's [ButtonBar].
  final List<Widget> actions;
  final String title, message;
  final IconData icon;
  final Color iconBackgroundColor;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: kPaddingL),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(kCardRadius),
            ),
            padding: const EdgeInsets.only(
                top: kPaddingL + kPaddingM, left: kPaddingM, right: kPaddingM),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                if (title.isNotNullOrEmpty)
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyText1.fs18.w600,
                  ),
                const SizedBox(height: kPaddingM),
                Text(
                  message,
                  style: Theme.of(context).textTheme.caption.w700,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: kPaddingM),
                ButtonBar(
                  buttonMinWidth: 100,
                  alignment: MainAxisAlignment.spaceEvenly,
                  children: actions,
                ),
              ],
            ),
          ),
          CircleAvatar(
            backgroundColor: iconBackgroundColor ?? Colors.red,
            maxRadius: 20.0,
            child: Icon(
              icon ?? Icons.info,
              color: kWhite,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}
