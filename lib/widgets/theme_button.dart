import 'package:flutter/material.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/utils/text_style.dart';

/// General purpose [RaisedButton] using app theme colors.
class ThemeButton extends StatelessWidget {
  const ThemeButton({
    Key key,
    this.onPressed,
    this.text,
    this.showLoading = false,
    this.disableTouchWhenLoading = false,
    this.alternate = false,
  }) : super(key: key);

  final VoidCallback onPressed;
  final String text;
  final bool showLoading;
  final bool disableTouchWhenLoading;
  final bool alternate;

  Widget _buildLoading() {
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
    if (!alternate)
      return SizedBox(
        height: kButtonHeight,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: kPaddingL),
            backgroundColor: kBlue,
          ),
          onPressed: disableTouchWhenLoading && showLoading ? null : onPressed,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                text.toUpperCase(),
                style: Theme.of(context).textTheme.button.white.fs16.w500,
              ),
              _buildLoading()
            ],
          ),
        ),
      );
    else
      return SizedBox(
        height: kButtonHeight,
        child: TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: kPaddingL),
          ),
          onPressed: disableTouchWhenLoading && showLoading ? null : onPressed,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                text.toUpperCase(),
                style: Theme.of(context).textTheme.button.fs16.w500,
              ),
              _buildLoading()
            ],
          ),
        ),
      );
  }
}

class ThemeFilledButton extends StatelessWidget {
  const ThemeFilledButton(
      {Key key, this.icon, this.label, this.onPressed, this.alternate = false})
      : super(key: key);
  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final bool alternate;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: (alternate) ? kWhite : kBlue,
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: kPaddingM * 1.5),
          child: Row(
            children: [
              SizedBox(width: kPaddingL),
              Icon(
                icon,
                color: (!alternate) ? kWhite : kBlue,
              ),
              Expanded(
                child: Text(
                  label,
                  style: (!alternate)
                      ? Theme.of(context).textTheme.button.white
                      : Theme.of(context).textTheme.button.primaryColor,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
