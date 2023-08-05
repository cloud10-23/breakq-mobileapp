import 'package:breakq/configs/app_globals.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/configs/routes.dart';
import 'package:breakq/main.dart';
import 'package:breakq/screens/search/widgets/search_widgets.dart';
import 'package:flutter/material.dart';
import 'package:breakq/generated/l10n.dart';
import 'package:flutter_icons/flutter_icons.dart';

class SearchAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Theme.of(context).scaffoldBackgroundColor,
      padding: const EdgeInsets.only(
        left: kPaddingM,
        right: kPaddingM,
        bottom: kPaddingM,
      ),
      height: 50,
      child: Card(
        color: getIt.get<AppGlobals>().isPlatformBrightnessDark
            ? Theme.of(context).colorScheme.secondary
            : Theme.of(context).cardColor,
        margin: const EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kBoxDecorationRadius),
          side: BorderSide(width: 0.5, color: Colors.black45),
        ),
        child: TextButton(
          // color: kPrimaryAccentColor,
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(kBoxDecorationRadius / 2)),
          ),
          onPressed: () => Navigator.pushNamed(context, Routes.search),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Spacer(),
              Icon(
                Feather.search,
                color: Theme.of(context).hintColor,
                size: 16,
              ),
              Spacer(),
              Expanded(
                flex: 16,
                child: Text(
                  L10n.of(context).homePlaceholderSearch,
                  style: getIt.get<AppGlobals>().captionStyle(context),
                  // style: Theme.of(context)
                  //     .textTheme
                  //     .subtitle1
                  //     .copyWith(color: Theme.of(context).hintColor),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              VoiceIconButton(),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
