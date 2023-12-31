import 'package:flutter/material.dart';
import 'package:breakq/configs/app_globals.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/main.dart';
import 'package:breakq/utils/text_style.dart';

class LabeledIconButton extends StatelessWidget {
  const LabeledIconButton({
    Key key,
    this.onTap,
    this.icon,
    this.text,
    this.showLoading = false,
    this.disableTouchWhenLoading = false,
  }) : super(key: key);

  final VoidCallback onTap;
  final IconData icon;
  final String text;
  final bool showLoading;
  final bool disableTouchWhenLoading;

  Widget _buildLoading() {
    if (!showLoading) {
      return Container();
    }

    return Container(
      margin: const EdgeInsets.all(kPaddingM),
      width: 12,
      height: 12,
      child: const CircularProgressIndicator(
        strokeWidth: 2,
        backgroundColor: kWhite,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: disableTouchWhenLoading && showLoading ? null : onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 150,
            height: 80,
            decoration: BoxDecoration(
              color: getIt.get<AppGlobals>().isPlatformBrightnessDark
                  ? Theme.of(context).dividerColor
                  : kPrimaryColor.withAlpha(24),
              borderRadius: BorderRadius.circular(kBadgeRadius),
            ),
            child: showLoading
                ? _buildLoading()
                : Icon(
                    icon,
                    size: 38,
                    color: getIt.get<AppGlobals>().isPlatformBrightnessDark
                        ? Theme.of(context)
                            .textTheme
                            .button
                            .color
                            .withOpacity(0.75)
                        : kPrimaryColor,
                  ),
          ),
          const Padding(padding: EdgeInsets.only(top: kPaddingS)),
          Text(
            text,
            style: Theme.of(context)
                .textTheme
                .subtitle1
                .w500
                .copyWith(color: Theme.of(context).textTheme.bodyText2.color),
          ),
        ],
      ),
    );
  }
}
