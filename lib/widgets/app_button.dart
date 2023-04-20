import 'package:flutter/material.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/utils/text_style.dart';

/// A material design "raised button" using primary theme colors.
///
/// A raised button is based on a [Material] widget whose [Material.elevation]
/// increases when the button is pressed.
class AppButton extends StatelessWidget {
  const AppButton({
    Key key,
    this.onPressed,
    this.text,
    this.showLoading = false,
    this.disableTouchWhenLoading = false,
  }) : super(key: key);

  final VoidCallback onPressed;
  final String text;
  final bool showLoading;
  final bool disableTouchWhenLoading;

  Widget _loadingProgressIndicator() {
    if (!showLoading) {
      return Container();
    }
    return Container(
      margin: const EdgeInsets.only(left: kPaddingS, right: kPaddingS),
      width: 14,
      height: 14,
      child: const CircularProgressIndicator(strokeWidth: 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: disableTouchWhenLoading && showLoading ? null : onPressed,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            text.toUpperCase(),
            style: Theme.of(context).textTheme.subtitle1.white.w600,
          ),
          _loadingProgressIndicator()
        ],
      ),
    );
  }
}
